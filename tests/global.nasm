%include 'inc/func.inc'
%include 'inc/task.inc'

;;;;;;;;;;;
; test code
;;;;;;;;;;;

	TEST_SIZE equ 1000

	fn_function tests/global

		;get max cpu num
		static_call sys_cpu, total
		vp_cpy r0, r12

		;allocate temp array for mailbox ID's
		vp_mul mailbox_id_size, r0
		static_call sys_mem, alloc
		assert r0, !=, 0
		vp_cpy r0, r14

		;open test12 global farm, off chip
		fn_string 'tests/global_child', r0
		vp_cpy r14, r1
		vp_cpy r12, r2
		static_call sys_task, open_global

		;send messages etc
		for r11, 0, 10, 1
			for r13, 0, r12, 1
				vp_cpy (TEST_SIZE * 8), r0
				static_call sys_mail, alloc_parcel
				for r15, 0, TEST_SIZE, 1
					vp_cpy r15, [r0 + (r15 * 8) + ml_msg_data]
				next
				vp_cpy r13, r3
				vp_mul mailbox_id_size, r3
				vp_cpy [r14 + r3], r1
				vp_cpy [r14 + r3 + 8], r2
				vp_cpy r1, [r0 + ml_msg_dest]
				vp_cpy r2, [r0 + ml_msg_dest + 8]
				static_call sys_mail, send
				static_call sys_task, yield
			next
		next

		;free ID array and return
		vp_cpy r14, r0
		static_jmp sys_mem, free

	fn_function_end
