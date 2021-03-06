scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim


function! marching#sync_clang_command#complete(context)
	echo "marching completion start"

	let tempfile = marching#make_tempfile_from_buffer(a:context.bufnr)
	if !filereadable(tempfile)
		return
	endif
	try
		let command = marching#clang_command#clang_complete_command(
\			get(b:, "marching_clang_command", g:marching_clang_command),
\			tempfile,
\			a:context.pos[0],
\			a:context.pos[1],
\				get(b:, "marching_clang_command_default_options", '-cc1 -fsyntax-only')
\			  . " "
\			  . marching#clang_command#include_opt()
\			  . " "
\			  . get(b:, "marching_clang_command_option", g:marching_clang_command_option)
\		)
		call marching#print_log("sync_clang_command command", command)

		let has_vimproc = 0
		silent! let has_vimproc = vimproc#version()
		if has_vimproc
			let result = vimproc#system(command)
		else
			let result = system(command)
		endif

		redraw
		echo "marching completion finish"
		return marching#clang_command#parse_complete_result(result)
	finally
		call delete(tempfile)
	endtry
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
