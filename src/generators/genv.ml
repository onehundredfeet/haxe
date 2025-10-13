(*
	The Haxe Compiler
	Copyright (C) 2005-2019  Haxe Foundation

	This program is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public License
	as published by the Free Software Foundation; either version 2
	of the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program; if not, write to the Free Software
	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*)

open Extlib_leftovers
open Ast
open Type
open Gctx
open ExtList
open Error

type pos = Globals.pos

type ctx = {
	com : Gctx.t;
	buf : Buffer.t;
	packages : (string list,unit) Hashtbl.t;
	mutable current : tclass;
	mutable statics : (tclass * tclass_field * texpr) list;
	mutable inits : texpr list;
	mutable tabs : string;
	mutable in_value : tvar option;
	mutable in_loop : bool;
	mutable break_depth : int;
	mutable id_counter : int;
	mutable type_accessor : module_type -> string;
	mutable separator : bool;
}

let s_path = Globals.s_type_path

let print ctx str = Buffer.add_string ctx.buf str

let spr ctx s = Printf.kprintf (print ctx) s

let newline ctx = print ctx "\n"

let println ctx s = print ctx s; newline ctx

let concat ctx s f = function
	| [] -> ()
	| [x] -> f x
	| l ->
		let rec loop = function
			| [] -> ()
			| [x] -> f x
			| x :: l -> f x; print ctx s; loop l
		in
		loop l

let open_block ctx =
	let old = ctx.tabs in
	ctx.tabs <- "\t" ^ ctx.tabs;
	(fun() -> ctx.tabs <- old)

let rec has_feature ctx = Gctx.has_feature ctx.com

let add_feature ctx = Gctx.add_feature ctx.com

let rec v_type_name ctx t =
	match follow t with
	| TInst ({ cl_path = [],"Int" },_) -> "int"
	| TInst ({ cl_path = [],"Float" },_) -> "f64"
	| TInst ({ cl_path = [],"Bool" },_) -> "bool"
	| TInst ({ cl_path = [],"String" },_) -> "string"
	| TInst ({ cl_path = [],"Array" },[t]) -> Printf.sprintf "[]%s" (v_type_name ctx t)
	| TInst ({ cl_path = path },_) -> s_path path
	| TEnum ({ e_path = path },_) -> s_path path
	| TAbstract ({ a_path = [],"Void" },_) -> ""
	| TAbstract ({ a_path = path },_) -> s_path path
	| TType ({ t_path = path },_) -> s_path path
	| TDynamic _ -> "voidptr"
	| TFun (args,ret) ->
		let sargs = String.concat ", " (List.map (fun (_,_,t) -> v_type_name ctx t) args) in
		let sret = v_type_name ctx ret in
		if sret = "" then Printf.sprintf "fn(%s)" sargs
		else Printf.sprintf "fn(%s) %s" sargs sret
	| _ -> "voidptr"

let v_escape_string s =
	let b = Buffer.create (String.length s) in
	for i = 0 to String.length s - 1 do
		match s.[i] with
		| '\n' -> Buffer.add_string b "\\n"
		| '\t' -> Buffer.add_string b "\\t"
		| '\r' -> Buffer.add_string b "\\r"
		| '"' -> Buffer.add_string b "\\\""
		| '\\' -> Buffer.add_string b "\\\\"
		| c -> Buffer.add_char b c
	done;
	Buffer.contents b

let snake_case s =
	let result = Buffer.create (String.length s) in
	for i = 0 to String.length s - 1 do
		let c = s.[i] in
		if i > 0 && c >= 'A' && c <= 'Z' then
			Buffer.add_char result '_';
		Buffer.add_char result (Char.lowercase_ascii c)
	done;
	Buffer.contents result

let v_function_name s =
	let s = snake_case s in
	match s with
	| "fn" | "struct" | "enum" | "interface" | "type" | "const" | "mut" 
	| "pub" | "import" | "module" | "for" | "if" | "else" | "match"
	| "go" | "return" | "defer" | "unsafe" | "union" | "shared" -> s ^ "_"
	| _ -> s

let v_struct_name s =
	(* Struct names need to be capitalized in V *)
	let s = String.capitalize_ascii s in
	match s with
	| "Fn" | "Struct" | "Enum" | "Interface" | "Type" | "Const" | "Mut" 
	| "Pub" | "Import" | "Module" | "For" | "If" | "Else" | "Match"
	| "Go" | "Return" | "Defer" | "Unsafe" | "Union" | "Shared" -> s ^ "_"
	| _ -> s

let v_ident s =
	snake_case s

let rec gen_value ctx e =
	match e.eexpr with
	| TConst c -> gen_const ctx c e.epos
	| TLocal v -> print ctx (v_ident v.v_name)
	| TArray (e1,e2) ->
		gen_value ctx e1;
		print ctx "[";
		gen_value ctx e2;
		print ctx "]"
	| TBinop (op,e1,e2) ->
		gen_value ctx e1;
		print ctx " ";
		gen_binop ctx op;
		print ctx " ";
		gen_value ctx e2
	| TUnop (op,flag,e) ->
		(match flag with
		| Prefix ->
			gen_unop ctx op;
			gen_value ctx e
		| Postfix ->
			gen_value ctx e;
			gen_unop ctx op)
	| TField (e,f) ->
		gen_value ctx e;
		print ctx ".";
		print ctx (v_ident (field_name f))
	| TCall (e,el) ->
		(* Handle different types of function calls *)
		(match e.eexpr with
		| TField (obj, field) ->
			(match obj.eexpr, field with
			| TTypeExpr (TClassDecl {cl_path = (["haxe"],"Log")}), FStatic (_, {cf_name = "trace"}) -> 
				(* Handle trace() calls - convert to println *)
				(match el with
				| arg :: _ ->
					print ctx "println(";
					(match arg.eexpr with
					| TConst (TString s) -> print ctx ("'" ^ v_escape_string s ^ "'")
					| TBinop (OpAdd, e1, e2) ->
						(* Check if this is actually string concatenation or numeric addition *)
						let is_string_concat = 
							let rec contains_string e =
								match e.eexpr with
								| TConst (TString _) -> true
								| TBinop (OpAdd, e1, e2) -> contains_string e1 || contains_string e2
								| _ -> false
							in
							contains_string arg
						in
						if is_string_concat then (
							(* Handle string concatenation in trace *)
							let rec gen_concat e =
								match e.eexpr with
								| TBinop (OpAdd, e1, e2) ->
									gen_concat e1;
									print ctx " + ";
									gen_concat e2
								| TConst (TString s) -> print ctx ("'" ^ v_escape_string s ^ "'")
								| TConst (TInt i) -> print ctx ("'" ^ Int32.to_string i ^ "'")
								| TConst (TFloat f) -> print ctx ("'" ^ f ^ "'")
								| TLocal v -> print ctx (v_ident v.v_name ^ ".str()")
								| _ -> 
									print ctx "(";
									gen_value ctx e;
									print ctx ").str()"
							in
							gen_concat arg
						) else (
							(* Regular arithmetic - just generate normally *)
							gen_value ctx arg
						)
					| _ -> gen_value ctx arg);
					print ctx ")"
				| [] -> 
					print ctx "println('empty trace')")
			| TTypeExpr (TClassDecl c), FStatic (_, {cf_name = "main"}) ->
				(* Handle static main method call - generate the main body directly *)
				(try
					let main_field = PMap.find "main" c.cl_statics in
					(match main_field.cf_expr with
					| Some {eexpr = TFunction tf} -> gen_value ctx tf.tf_expr
					| _ -> print ctx "// no main body found")
				with Not_found -> print ctx "// main method not found")
			| _ ->
				(* Default function call handling *)
				gen_value ctx e;
				print ctx "(";
				concat ctx ", " (gen_value ctx) el;
				print ctx ")"
			)
		| _ ->
			(* Other types of calls *)
			gen_value ctx e;
			print ctx "(";
			concat ctx ", " (gen_value ctx) el;
			print ctx ")")
	| TReturn e ->
		print ctx "return";
		(match e with
		| None -> ()
		| Some e -> print ctx " "; gen_value ctx e)
	| TIf (e,e1,e2) ->
		print ctx "if ";
		gen_value ctx e;
		print ctx " {\n";
		let b = open_block ctx in
		print ctx ctx.tabs;
		gen_value ctx e1;
		b();
		print ctx "\n}";
		(match e2 with
		| None -> ()
		| Some e ->
			print ctx " else {\n";
			let b = open_block ctx in
			print ctx ctx.tabs;
			gen_value ctx e;
			b();
			print ctx "\n}")
	| TBlock el ->
		print ctx "{\n";
		let b = open_block ctx in
		List.iter (fun e ->
			print ctx ctx.tabs;
			gen_value ctx e;
			print ctx "\n"
		) el;
		b();
		print ctx ctx.tabs;
		print ctx "}"
	| TTypeExpr _ ->
		print ctx "// type expression"
	| TVar (v,eo) ->
		print ctx (v_ident v.v_name);
		print ctx " := ";
		(match eo with
		| None -> print ctx "0" (* Default initialization *)
		| Some e -> gen_value ctx e)
	| TParenthesis e ->
		print ctx "(";
		gen_value ctx e;
		print ctx ")"
	| _ ->
		print ctx "// TODO: ";
		print ctx (Type.s_expr_kind e)

and gen_const ctx c pos =
	match c with
	| TInt i -> print ctx (Int32.to_string i)
	| TFloat s -> print ctx s
	| TString s -> print ctx ("\"" ^ v_escape_string s ^ "\"")
	| TBool b -> print ctx (if b then "true" else "false")
	| TNull -> print ctx "unsafe { nil }"
	| TThis -> print ctx "self"
	| TSuper -> print ctx "super"

and gen_binop ctx = function
	| OpAdd -> print ctx "+"
	| OpMult -> print ctx "*"
	| OpDiv -> print ctx "/"
	| OpSub -> print ctx "-"
	| OpAssign -> print ctx "="
	| OpEq -> print ctx "=="
	| OpNotEq -> print ctx "!="
	| OpGt -> print ctx ">"
	| OpGte -> print ctx ">="
	| OpLt -> print ctx "<"
	| OpLte -> print ctx "<="
	| OpAnd -> print ctx "&&"
	| OpOr -> print ctx "||"
	| OpMod -> print ctx "%"
	| OpShl -> print ctx "<<"
	| OpShr -> print ctx ">>"
	| OpUShr -> print ctx ">>"
	| OpXor -> print ctx "^"
	| OpBoolAnd -> print ctx "&"
	| OpBoolOr -> print ctx "|"
	| OpAssignOp op -> gen_binop ctx op; print ctx "="
	| OpInterval -> print ctx ".."
	| OpArrow -> print ctx "=>"
	| OpIn -> print ctx "in"
	| OpNullCoal -> print ctx "or"

and gen_unop ctx = function
	| Not -> print ctx "!"
	| Neg -> print ctx "-"
	| NegBits -> print ctx "~"
	| Increment -> print ctx "++"
	| Decrement -> print ctx "--"
	| Spread -> print ctx "..."

let gen_function_header ctx name args ret =
	print ctx "fn ";
	print ctx (v_ident name);
	print ctx "(";
	concat ctx ", " (fun (v,_) ->
		print ctx (v_ident v.v_name);
		print ctx " ";
		print ctx (v_type_name ctx v.v_type)
	) args;
	print ctx ")";
	let ret_type = v_type_name ctx ret in
	if ret_type <> "" then begin
		print ctx " ";
		print ctx ret_type
	end

let gen_class_field ctx c f =
	match f.cf_kind with
	| Method _ ->
		(* Don't generate methods inside struct - they'll be generated outside *)
		()
	| Var _ ->
		print ctx ctx.tabs;
		print ctx (v_ident f.cf_name);
		print ctx " ";
		print ctx (v_type_name ctx f.cf_type);
		newline ctx

let gen_class ctx c =
	print ctx "struct ";
	print ctx (v_struct_name (snd c.cl_path));
	print ctx " {\n";
	let b = open_block ctx in
	
	List.iter (gen_class_field ctx c) c.cl_ordered_fields;
	
	b();
	print ctx "}\n\n";
	
	(* Generate methods outside of struct *)
	List.iter (fun f ->
		match f.cf_expr with
		| Some { eexpr = TFunction tf } ->
			(* Check if this is a static main method *)
			if f.cf_name = "main" && has_class_field_flag f CfStatic then
				() (* Don't generate method - will be handled by main function *)
			else begin
				print ctx "fn (self &";
				print ctx (v_struct_name (snd c.cl_path));
				print ctx ") ";
				print ctx (v_function_name f.cf_name);
				print ctx "(";
				concat ctx ", " (fun (v,_) ->
					print ctx (v_ident v.v_name);
					print ctx " ";
					print ctx (v_type_name ctx v.v_type)
				) tf.tf_args;
				print ctx ")";
				let ret_type = v_type_name ctx tf.tf_type in
				if ret_type <> "" then begin
					print ctx " ";
					print ctx ret_type
				end;
				print ctx " ";
				gen_value ctx tf.tf_expr;
				newline ctx;
				newline ctx
			end
		| _ -> ()
	) c.cl_ordered_fields

let gen_enum ctx e =
	print ctx "enum ";
	print ctx (v_struct_name (snd e.e_path));
	print ctx " {\n";
	let b = open_block ctx in
	
	PMap.iter (fun _ ef ->
		print ctx ctx.tabs;
		print ctx (v_ident ef.ef_name);
		(match follow ef.ef_type with
		| TFun (args,_) when args <> [] ->
			print ctx " { ";
			concat ctx "; " (fun (n,_,t) ->
				print ctx (v_ident n);
				print ctx " ";
				print ctx (v_type_name ctx t)
			) args;
			print ctx " }"
		| _ -> ());
		newline ctx
	) e.e_constrs;
	
	b();
	print ctx "}\n\n"

let should_generate_class c =
	match c.cl_path with
	(* Only generate classes from the root package that are not standard library classes *)
	| ([], name) when not (List.mem name ["Std"; "Log"; "PosException"; "ArrayIterator"; "String"; "StringTools"]) -> true
	| (pack, _) when pack <> [] && (List.hd pack = "haxe" || List.hd pack = "sys") -> false
	| _ -> true

let generate_type ctx = function
	| TClassDecl c when not (has_class_flag c CInterface) && not (has_class_flag c CExtern) && should_generate_class c ->
		gen_class ctx c
	| TEnumDecl e when not (has_enum_flag e EnExtern) ->
		gen_enum ctx e
	| _ -> ()

let alloc_ctx com =
	let ctx = {
		com = com;
		buf = Buffer.create 16000;
		packages = Hashtbl.create 0;
		current = null_class;
		statics = [];
		inits = [];
		tabs = "";
		in_value = None;
		in_loop = false;
		break_depth = 0;
		id_counter = 0;
		type_accessor = (fun _ -> ""); (* Will be set properly later *)
		separator = false;
	} in
	ctx

let generate com =
	let ctx = alloc_ctx com in
	
	(* Set up type_accessor function *)
	ctx.type_accessor <- (fun t ->
		let p = TFunctions.t_path t in
		s_path p
	);
	
	print ctx "module main\n\n";
	print ctx "// Generated by Haxe\n\n";
	
	List.iter (generate_type ctx) com.types;
	
	(match com.main.main_expr with
	| Some e ->
		print ctx "fn main() {\n";
		let b = open_block ctx in
		print ctx ctx.tabs;
		gen_value ctx e;
		newline ctx;
		b();
		print ctx "}\n"
	| None -> ());
	
	Path.mkdir_from_path com.file;
	let ch = open_out_bin com.file in
	output_string ch (Buffer.contents ctx.buf);
	close_out ch