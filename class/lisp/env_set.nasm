%include 'inc/func.inc'
%include 'class/class_pair.inc'
%include 'class/class_error.inc'
%include 'class/class_lisp.inc'

def_func class/lisp/env_set
	;inputs
	;r0 = lisp object
	;r1 = symbol
	;r2 = value
	;outputs
	;r0 = lisp object
	;r1 = value

	ptr this, symbol, value
	pptr iter

	push_scope
	retire {r0, r1, r2}, {this, symbol, value}

	func_call lisp, env_find, {this, symbol}, {iter, _}
	if {iter}
		;change existing value
		func_call ref, ref, {value}
		func_call ref, ref, {value}
		func_call pair, set_second, {*iter, value}
	else
		func_call error, create, {"symbol not bound", symbol}, {value}
	endif

	eval {this, value}, {r0, r1}
	pop_scope
	return

def_func_end