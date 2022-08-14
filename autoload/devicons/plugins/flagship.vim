function! devicons#plugins#flagship#init() abort
  if g:icon_wf_enable_flagship_statusline
    augroup icon_wf_flagship_filetype
      autocmd User Flags call Hoist('buffer', 'File_Icon')
    augroup END
  endif

  if g:icon_wf_enable_flagship_statusline_fileformat_symbols
    augroup icon_wf_flagship_filesymbol
      autocmd User Flags call Hoist('buffer', 'WebDevIconsGetFileFormatSymbol')
    augroup END
  endif
endfunction

" vim: tabstop=2 softtabstop=2 shiftwidth=2 expandtab:
