scriptencoding utf-8
if exists('g:loaded_marching')
  finish
endif
let g:loaded_marching = 1

let s:save_cpo = &cpo
set cpo&vim

let g:marching_command        = get(g:, "marching_clang_command", "clang")
let g:marching_command_option = get(g:, "marching_clang_command_option", "")
let g:marching_include_paths  = get(g:, "marching_include_paths", [])
let g:marching_wait_time      = get(g:, "marching_wait_time", 0.5)
let g:marching_enable_auto_select = get(g:, "marching_enable_auto_select", 0)
let g:marching_enable_neocomplete = get(g:, "marching_enable_neocomplete", 0)
let g:marching_debug = get(g:, "marching_debug", 0)


inoremap <silent> <Plug>(marching_start_auto_complete)
   \ <C-x><C-o><C-r>=marching#complete#popup_pos()<CR>


let &cpo = s:save_cpo
unlet s:save_cpo