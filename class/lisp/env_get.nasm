%include 'inc/func.inc'
%include 'class/class_pair.inc'
%include 'class/class_error.inc'
%include 'class/class_lisp.inc'

def_func class/lisp/env_get
	;inputs
	;r0 = lisp object
	;r1 = symbol
	;outputs
	;r0 = lisp object
	;r1 = value

	ptr this, symbol
	pptr iter

	push_scope
	retire {r0, r1}, {this, symbol}

	func_call lisp, env_find, {this, symbol}, {iter, _}
	if {iter}
		func_call pair, ref_second, {*iter}, {symbol}
	else
		func_call error, create, {"symbol not bound", symbol}, {symbol}
	endif

	eval {this, symbol}, {r0, r1}
	pop_scope
	return

def_func_end