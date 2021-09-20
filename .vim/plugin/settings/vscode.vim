nnoremap <silent> <c-k> <Cmd>call VSCodeCall('editor.action.showHover')<CR>
nnoremap <silent> gD <Cmd>call VSCodeCall('editor.action.goToImplementation')<CR>
nnoremap <silent> gr <Cmd>call VSCodeCall('references-view.find')<CR>
nnoremap <silent> gR <Cmd>call VSCodeCall('references-view.findImplementations')<CR>
nnoremap <silent> <delete> <Cmd>call VSCodeCall('editor.debug.action.toggleBreakpoint')<CR>
" nnoremap <silent> gO <Cmd>call VSCodeCall('workbench.action.gotoSymbol')<CR>
nnoremap <silent> gO <Cmd>call VSCodeCall('outline.focus')<CR>
nnoremap <silent> z/ <Cmd>call VSCodeCall('workbench.action.showAllSymbols')<CR>
nnoremap <silent> - <Cmd>call VSCodeCall('workbench.files.action.showActiveFileInExplorer')<CR>

nnoremap <silent> UD <Cmd>call VSCodeCall('git.openChange')<CR>
nnoremap <silent> UB <Cmd>call VSCodeCall('gitlens.toggleFileBlame')<CR>

