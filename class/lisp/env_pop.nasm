%include 'inc/func.inc'
%include 'class/class_unordered_map.inc'
%include 'class/class_pair.inc'
%include 'class/class_lisp.inc'

def_func class/lisp/env_pop
	;inputs
	;r0 = lisp object
	;outputs
	;r0 = lisp object

	ptr this, env
	pptr iter

	push_scope
	retire {r0}, {this}

	func_call unordered_map, find, {this->lisp_enviroment, this->lisp_sym_parent}, {iter, _}
	if {iter}
		func_call pair, ref_second, {*iter}, {env}
		func_call ref, deref, {this->lisp_enviroment}
		assign {env}, {this->lisp_enviroment}
	endif

	eval {this}, {r0}
	pop_scope
	return

def_func_end