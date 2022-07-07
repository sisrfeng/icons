" Version: 0.11.0
" Webpage: https://github.com/ryanoasis/vim-devicons
" Maintainer: Ryan McIntyre <ryanoasis@gmail.com>
" License: see LICENSE

let s:version = '0.11.0'
let s:plugin_home = expand('<sfile>:p:h:h')

" set scriptencoding after 'encoding' and when using multibyte chars
scriptencoding utf-8

" standard fix/safety
    let s:save_cpo = &cpo
    set cpo&vim


    if exists('g:loaded_webdevicons')
    finish
    en

    let g:loaded_webdevicons = 1

" config enable / disable settings
    " only if variable is not defined.
        " Set the variable to the default value,
    "
    " @param {string} var Variable name with its scope.
    " @param {*} default Default value for variable.
    ""
    fun! s:set(var, default) abort
        if !exists(a:var)
            if type(a:default)
                exe     'let' a:var '=' string(a:default)
            el
                exe     'let' a:var '=' a:default
            en
        en
    endf

    call s:set('g:webdevicons_enable'                                        , 1)
    call s:set('g:webdevicons_enable_nerdtree'                               , 1)
    call s:set('g:webdevicons_enable_unite '                                 , 1)
    call s:set('g:webdevicons_enable_denite'                                 , 1)
    call s:set('g:webdevicons_enable_vimfiler'                               , 1)
    call s:set('g:webdevicons_enable_ctrlp'                                  , 1)
    call s:set('g:webdevicons_enable_airline_tabline'                        , 1)
    call s:set('g:webdevicons_enable_airline_statusline'                     , 1)
    call s:set('g:webdevicons_enable_airline_statusline_fileformat_symbols'  , 1)
    call s:set('g:webdevicons_enable_flagship_statusline'                    , 1)
    call s:set('g:webdevicons_enable_flagship_statusline_fileformat_symbols' , 1)
    call s:set('g:webdevicons_enable_startify'                               , 1)
    call s:set('g:webdevicons_conceal_nerdtree_brackets'                     , 1)
    call s:set('g:DevIconsAppendArtifactFix'                                 , has('gui_running') ? 1 : 0)
    call s:set('g:DevIconsArtifactFixChar'                                   , ' ')

" config options
    call s:set('g:WebDevIconsUnicodeDecorateFileNodes'               , 1)
    call s:set('g:WebDevIconsUnicodeDecorateFolderNodes'             , 1)
    call s:set('g:DevIconsEnableFoldersOpenClose'                    , 0)
    call s:set('g:DevIconsEnableFolderPatternMatching'               , 1)
    call s:set('g:DevIconsEnableFolderExtensionPatternMatching'      , 0)
    call s:set('g:DevIconsEnableDistro'                              , 1)
    call s:set('g:WebDevIconsUnicodeDecorateFolderNodesExactMatches' , 1)
    call s:set('g:WebDevIconsUnicodeGlyphDoubleWidth'                , 1)
    call s:set('g:WebDevIconsNerdTreeBeforeGlyphPadding'             , ' ')
    call s:set('g:WebDevIconsNerdTreeAfterGlyphPadding'              , ' ')
    call s:set('g:WebDevIconsNerdTreeGitPluginForceVAlign'           , 1)
    call s:set('g:NERDTreeUpdateOnCursorHold'                        , 1) " Obsolete: For backward compatibility
    call s:set('g:NERDTreeGitStatusUpdateOnCursorHold'               , 1)
    call s:set('g:WebDevIconsTabAirLineBeforeGlyphPadding'           , ' ')
    call s:set('g:WebDevIconsTabAirLineAfterGlyphPadding'            , '')


    call s:set('g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol'   , '')
    call s:set('g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol'     , '')
    call s:set('g:DevIconsDefaultFolderOpenSymbol'                    , '')
    call s:set('g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol' , g:DevIconsEnableFoldersOpenClose ? '' : '')
    call s:set('g:WebDevIconsUnicodeDecorateFolderNodesSymlinkSymbol' , '')

" local functions
    function s:getDistro()
        if exists('s:distro')
            return s:distro
        en

        if has('bsd')
            let s:distro = ''
            return s:distro
        en

        if g:DevIconsEnableDistro && executable('lsb_release')
            let s:lsb = system('lsb_release -i')
            if s:lsb =~# 'Arch'
                let s:distro = ''
            elseif s:lsb =~# 'Gentoo'
                let s:distro = ''
            elseif s:lsb =~# 'Ubuntu'
                let s:distro = ''
            elseif s:lsb =~# 'Cent'
                let s:distro = ''
            elseif s:lsb =~# 'Debian'
                let s:distro = ''
            elseif s:lsb =~# 'Dock'
                let s:distro = ''
            el
                let s:distro = ''
            en
            return s:distro
        en

        let s:distro = ''
        return s:distro
    endf

    function s:isDarwin()
        if exists('s:is_darwin')
            return s:is_darwin
        en

        if exists('g:WebDevIconsOS')
            let s:is_darwin = g:WebDevIconsOS ==? 'Darwin'
            return s:is_darwin
        en

        if has('macunix')
            let s:is_darwin = 1
            return s:is_darwin
        en

        if ! has('unix')
            let s:is_darwin = 0
            return s:is_darwin
        en

        if system('uname -s') ==# "Darwin\n"
            let s:is_darwin = 1
        el
            let s:is_darwin = 0
        en

        return s:is_darwin
    endf

    fun! s:strip(input)
        return substitute(a:input, '^\s*\(.\{-}\)\s*$', '\1', '')
    endf

    fun! s:setDictionaries()
        " XX.extensions
            let s:file_node_extensions = {
                \ 'styl'     : '',
                \ 'sass'     : '',
                \ 'scss'     : '',
                \ 'htm'      : '',
                \ 'html'     : '',
                \ 'slim'     : '',
                \ 'haml'     : '',
                \ 'ejs'      : '',
                \ 'css'      : '',
                \ 'less'     : '',
                \ 'md'       : '⏬',
                \ 'mdx'      : '⏬',
                \ 'markdown' : '⏬',
                \ 'rmd'      : '⏬',
                \ 'json'     : '',
                \ 'webmanifest' : '',
                \ 'js'       : '',
                \ 'mjs'      : '',
                \ 'jsx'      : '',
                \ 'rb'       : '',
                \ 'gemspec'  : '',
                \ 'rake'     : '',
                \ 'php'      : '',
                \
                \ 'py'       : '',
                \ 'pyc'      : '',
                \ 'pyo'      : '',
                \ 'pyd'      : '',
                \
                \ 'coffee'   : '',
                \ 'mustache' : '',
                \ 'hbs'      : '',
                \ 'conf'     : '',
                \ 'ini'      : '',
                \ 'yml'      : '',
                \ 'yaml'     : '',
                \ 'toml'     : '',
                \ 'bat'      : '',
                \ 'mk'       : '',
                \ 'jpg'      : '',
                \ 'jpeg'     : '',
                \ 'bmp'      : '',
                \ 'png'      : '',
                \ 'webp'     : '',
                \ 'gif'      : '',
                \ 'ico'      : '',
                \ 'twig'     : '',
                \ 'cpp'      : '',
                \ 'c++'      : '',
                \ 'cxx'      : '',
                \ 'cc'       : '',
                \ 'cp'       : '',
                \ 'c'        : '',
                \ 'cs'       : '',
                \ 'h'        : '',
                \ 'hh'       : '',
                \ 'hpp'      : '',
                \ 'hxx'      : '',
                \ 'hs'       : '',
                \ 'lhs'      : '',
                \ 'nix'      : '',
                \ 'lua'      : '',
                \ 'java'     : '',
                \ 'sh'       : '🐚',
                \ 'fish'     : '',
                \ 'bash'     : '🐚',
                \ 'zsh'      : '🐚',
                \ '.zlogin'  : '🐚',
                \ 'zshenv'   : '🐚',
                \ 'zz'       : '🐚',
                \ 'ksh'      : '',
                \ 'csh'      : '',
                \ 'awk'      : '',
                \ 'ps1'      : '',
                \ 'snippets' : '',
                \ 'ml'       : 'λ',
                \ 'mli'      : 'λ',
                \ 'diff'     : '',
                \ 'db'       : '',
                \ 'sql'      : '',
                \ 'dump'     : '',
                \ 'clj'      : '',
                \ 'cljc'     : '',
                \ 'cljs'     : '',
                \ 'edn'      : '',
                \ 'scala'    : '',
                \ 'go'       : '',
                \ 'dart'     : '',
                \ 'xul'      : '',
                \ 'sln'      : '',
                \ 'suo'      : '',
                \ 'pl'       : '',
                \ 'pm'       : '',
                \ 't'        : '',
                \ 'rss'      : '',
                \ 'f#'       : '',
                \ 'fsscript' : '',
                \ 'fsx'      : '',
                \ 'fs'       : '',
                \ 'fsi'      : '',
                \ 'rs'       : '',
                \ 'rlib'     : '',
                \ 'd'        : '',
                \ 'erl'      : '',
                \ 'hrl'      : '',
                \ 'ex'       : '',
                \ 'exs'      : '',
                \ 'eex'      : '',
                \ 'leex'     : '',
                \ 'heex'     : '',
                \ 'vim'         :'',
                \ 'ai'          :'',
                \ 'psd'         :'',
                \ 'psb'         :'',
                \ 'ts'          :'',
                \ 'tsx'         :'',
                \ 'jl'          :'',
                \ 'pp'          :'',
                \ 'vue'         :'﵂',
                \ 'elm'         :'',
                \ 'swift'       :'',
                \ 'xcplayground':'',
                \ 'tex'         :'ﭨ',
                \ 'bib'         :'ﭨ',
                \ 'bbl'         :'ﭨ',
                \ 'xdv'         :'ﭨ',
                \ 'cls'         :'ﭨ',
                \ 'r'           :'ﳒ',
                \ 'rproj'       :'鉶',
                \ 'sol'         :'ﲹ',
                \ 'pem'         :'',
                \ 'ahk'         :'',
                \ 'autohotkey'  :'',
                \ 'w'           :'📁',
                \ 'man'         :'👤',
                \ 'txt'         :'📄',
                \}

            if !exists('g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols')
                let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
            en

            "  allow user overriding of ¿specific individual keys ¿in vimrc
            " (only gvimrc was working previously)
            for [key, val] in items(s:file_node_extensions)
                if !has_key(g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols, key)
                    let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[key] = val
                en
            endfor


        " exact_matches
            let s:file_node_exact_matches = {
                \ 'exact-match-case-sensitive-1.txt' : '1',
                \ 'exact-match-case-sensitive-2'     : '2',
                \ 'gruntfile.coffee'                 : '',
                \ 'gruntfile.js'                     : '',
                \ 'gruntfile.ls'                     : '',
                \ 'gulpfile.coffee'                  : '',
                \ 'gulpfile.js'                      : '',
                \ 'gulpfile.ls'                      : '',
                \ 'mix.lock'                         : '',
                \ 'dropbox'                          : '',
                \ '.ds_store'                        : '',
                \ '.gitconfig'                       : '',
                \ '.gitignore'                       : '',
                \ '.gitattributes'                   : '',
                \ '.gitlab-ci.yml'                   : '',
                \ '.bashrc'                          : '',
                \ '.zshrc'                           : '',
                \ '.zshenv'                          : '',
                \ '.zprofile'                        : '',
                \ '.vimrc'                           : '',
                \ '.gvimrc'                          : '',
                \ '_vimrc'                           : '',
                \ '_gvimrc'                          : '',
                \ '.bashprofile'                     : '',
                \ 'favicon.ico'                      : '',
                \ 'license'                          : '',
                \ 'node_modules'                     : '',
                \ 'react.jsx'                        : '',
                \ 'procfile'                         : '',
                \ 'dockerfile'                       : '',
                \ 'docker-compose.yml'               : '',
                \ 'rakefile'                         : '',
                \ 'config.ru'                        : '',
                \ 'gemfile'                          : '',
                \ 'makefile'                         : '',
                \ 'cmakelists.txt'                   : '',
                \ 'robots.txt'                       : 'ﮧ',
                \ 'zathurarc'                        : ''
                \}

            if !exists('g:WebDevIconsUnicodeDecorateFileNodesExactSymbols')
                " do not remove: exact-match-case-sensitive-*
                let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {}
            en

            for [key, val] in items(s:file_node_exact_matches)
            if !has_key(g:WebDevIconsUnicodeDecorateFileNodesExactSymbols, key)
                let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols[key] = val
            en
            endfor



        " pattern_matches
            let s:file_node_pattern_matches = {
                \ '.*jquery.*\.js$'       : '',
                \ '.*angular.*\.js$'      : '',
                \ '.*backbone.*\.js$'     : '',
                \ '.*require.*\.js$'      : '',
                \ '.*materialize.*\.js$'  : '',
                \ '.*materialize.*\.css$' : '',
                \ '.*mootools.*\.js$'     : '',
                \ '.*vimrc.*'             : '',
                \ 'Vagrantfile$'          : ''
                \}

            if !exists('g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols')
                let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols = {}
            en


            for [key, val] in items(s:file_node_pattern_matches)
                if !has_key(g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols, key)
                    let g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols[key] = val
                en
            endfor
    endf


    fun! s:setSyntax()
        if g:webdevicons_enable_nerdtree == 1 && g:webdevicons_conceal_nerdtree_brackets == 1
        augroup webdevicons_conceal_nerdtree_brackets
            au!
            au      FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=NERDTreeFlags
            au      FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=NERDTreeFlags
            au      FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=NERDTreeLinkFile
            au      FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=NERDTreeLinkDir
            au      FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=NERDTreeLinkFile
            au      FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=NERDTreeLinkDir
            au      FileType nerdtree setl     conceallevel=3
            au      FileType nerdtree setl     concealcursor=nvic
        augroup END
        en
    endf

    " NERDTree
        " stole solution/idea from nerdtree-git-plugin :)
            fun! s:setCursorHold()
                if g:webdevicons_enable_nerdtree
                augroup webdevicons_cursor_hold
                    au      CursorHold * silent! call s:CursorHoldUpdate()
                augroup END
                en
            endf

            fun! s:CursorHoldUpdate()
                if g:NERDTreeUpdateOnCursorHold != 1 || g:NERDTreeGitStatusUpdateOnCursorHold != 1
                return
                en

                if !exists('g:NERDTree') || !g:NERDTree.IsOpen()
                return
                en

                " Do not update when a special buffer is selected
                if !empty(&l:buftype)
                return
                en

                " winnr need to make focus go to opened file
                " CursorToTreeWin needed to avoid error on opening file
                let l:winnr = winnr()
                let l:altwinnr = winnr('#')

                call g:NERDTree.CursorToTreeWin()
                call b:NERDTree.root.refreshFlags()
                call NERDTreeRender()

                exec l:altwinnr . 'wincmd w'
                exec l:winnr . 'wincmd w'
            endf

        fun! s:hardRefreshNerdTree()
            if g:webdevicons_enable_nerdtree == 1 && g:webdevicons_conceal_nerdtree_brackets == 1 && g:NERDTree.IsOpen()
            NERDTreeClose
            NERDTree
            en
        endf

        fun! s:softRefreshNerdTree()
            if g:webdevicons_enable_nerdtree == 1 && exists('g:NERDTree') && g:NERDTree.IsOpen()
            NERDTreeToggle
            NERDTreeToggle
            en
        endf


        fun! s:initialize()
            call s:setDictionaries()
            call s:setSyntax()
            call s:setCursorHold()

            if exists('g:loaded_flagship') | call devicons#plugins#flagship#init() | endif
            if exists('g:loaded_unite') && g:webdevicons_enable_unite | call devicons#plugins#unite#init() | endif
            if exists('g:loaded_denite') && g:webdevicons_enable_denite | call devicons#plugins#denite#init() | endif
            if exists('g:loaded_vimfiler') && g:webdevicons_enable_vimfiler | call devicons#plugins#vimfiler#init() | endif
            if exists('g:loaded_ctrlp') && g:webdevicons_enable_ctrlp | call devicons#plugins#ctrlp#init() | endif
            if exists('g:loaded_startify') && g:webdevicons_enable_startify | call devicons#plugins#startify#init() | endif
        endf


" public functions
    fun! webdevicons#version()
        return s:version
    endf

    fun! webdevicons#pluginHome()
        return s:plugin_home
    endf

    " allow the first version of refresh to now call softRefresh
    fun! webdevicons#refresh()
        call webdevicons#softRefresh()
    endf

    fun! webdevicons#hardRefresh()
        call s:setSyntax()
        call s:hardRefreshNerdTree()
    endf

    fun! webdevicons#softRefresh()
        call s:setSyntax()
        call s:softRefreshNerdTree()
    endf

    " a:1 (bufferName), a:2 (isDirectory)
    fun! WebDevIconsGetFileTypeSymbol(...) abort
        if a:0 == 0
        let fileNodeExtension = !empty(expand('%:e')) ? expand('%:e') : &filetype
        let fileNode = expand('%:t')
        let isDirectory = 0
        el
        let fileNodeExtension = fnamemodify(a:1, ':e')
        let fileNode = fnamemodify(a:1, ':t')
        if a:0 > 1
            let isDirectory = a:2
        el
            let isDirectory = 0
        en
        en

        if isDirectory == 0 || g:DevIconsEnableFolderPatternMatching

        let symbol = g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol
        let fileNodeExtension = tolower(fileNodeExtension)
        let fileNode = tolower(fileNode)

        for [pattern, glyph] in items(g:WebDevIconsUnicodeDecorateFileNodesPatternSymbols)
            if match(fileNode, pattern) != -1
            let symbol = glyph
            break
            en
        endfor

        if symbol == g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol
            if has_key(g:WebDevIconsUnicodeDecorateFileNodesExactSymbols, fileNode)
            let symbol = g:WebDevIconsUnicodeDecorateFileNodesExactSymbols[fileNode]
            elseif ((isDirectory == 1 && g:DevIconsEnableFolderExtensionPatternMatching) || isDirectory == 0) && has_key(g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols, fileNodeExtension)
            let symbol = g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols[fileNodeExtension]
            elseif isDirectory == 1
            let symbol = g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol
            en
        en

        el
        let symbol = g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol
        en

        let artifactFix = s:DevIconsGetArtifactFix()

        return symbol . artifactFix

    endf

    " scope: local
    " Temporary (hopefully) fix for glyph issues in gvim (proper fix is with the  actual font patcher)
    fun! s:DevIconsGetArtifactFix()
        if g:DevIconsAppendArtifactFix == 1
        let artifactFix = g:DevIconsArtifactFixChar
        el
        let artifactFix = ''
        en

        return artifactFix
    endf

    fun! WebDevIconsGetFileFormatSymbol(...)
        let fileformat = ''
        let bomb = ''

        if (&bomb && g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol !=? '')
        let bomb = g:WebDevIconsUnicodeByteOrderMarkerDefaultSymbol . ' '
        en

        if &fileformat ==? 'dos'
        let fileformat = ''
        elseif &fileformat ==? 'unix'
        let fileformat = s:isDarwin() ? '' : s:getDistro()
        elseif &fileformat ==? 'mac'
        let fileformat = ''
        en

        let artifactFix = s:DevIconsGetArtifactFix()

        return bomb . fileformat . artifactFix
    endf

    " for airline plugin
        " scope: public
        fun! AirlineWebDevIcons(...)
            let w:airline_section_x = get(w:, 'airline_section_x',
                \ get(g:, 'airline_section_x', ''))
            let w:airline_section_x .= ' %{WebDevIconsGetFileTypeSymbol()} '
            let hasFileFormatEncodingPart = airline#parts#ffenc() !=? ''
            if g:webdevicons_enable_airline_statusline_fileformat_symbols && hasFileFormatEncodingPart
            let w:airline_section_y = ' %{&fenc . " " . WebDevIconsGetFileFormatSymbol()} '
            en
        endf

        if g:webdevicons_enable == 1 && exists('g:loaded_airline') && g:loaded_airline == 1 && g:webdevicons_enable_airline_statusline
            call airline#add_statusline_func('AirlineWebDevIcons')
        en

        if g:webdevicons_enable == 1 && g:webdevicons_enable_airline_tabline
            " Store original formatter.
            let g:_webdevicons_airline_orig_formatter = get(g:, 'airline#extensions#tabline#formatter', 'default')
            let g:airline#extensions#tabline#formatter = 'webdevicons'
        en

    " for nerdtree plugin
        fun! NERDTreeWebDevIconsRefreshListener(event)
            let path = a:event.subject
            let postPadding = g:WebDevIconsNerdTreeAfterGlyphPadding
            let prePadding = g:WebDevIconsNerdTreeBeforeGlyphPadding
            let hasGitFlags = (len(path.flagSet._flagsForScope('git')) > 0)
            let hasGitNerdTreePlugin = (exists('g:loaded_nerdtree_git_status') == 1)
            let artifactFix = s:DevIconsGetArtifactFix()

            " align vertically at the same level: non git-flag nodes with git-flag nodes
            if g:WebDevIconsNerdTreeGitPluginForceVAlign && !hasGitFlags && hasGitNerdTreePlugin
                let prePadding .= ' '
            en

            if !path.isDirectory
                " Hey we got a regular file, lets get it's proper icon
                let flag = prePadding . WebDevIconsGetFileTypeSymbol(path.str()) . postPadding

            elseif path.isDirectory && g:WebDevIconsUnicodeDecorateFolderNodes == 1
                " Ok we got a directory, some more tests and checks
                let directoryOpened = 0

                if g:DevIconsEnableFoldersOpenClose && len(path.flagSet._flagsForScope('webdevicons')) > 0
                    " did the user set different icons for open and close?

                    " isOpen is not available on the path listener directly
                    " but we added one via overriding particular keymappings for NERDTree
                    if has_key(path, 'isOpen') && path.isOpen == 1
                        let directoryOpened = 1
                    en
                en

                if g:WebDevIconsUnicodeDecorateFolderNodesExactMatches == 1
                    " Did the user enable exact matching of folder type/names
                    " think node_modules
                    if g:DevIconsEnableFoldersOpenClose && directoryOpened
                        " the folder is open
                        let flag = prePadding . g:DevIconsDefaultFolderOpenSymbol . artifactFix . postPadding
                    el
                        " the folder is not open
                        if path.isSymLink
                            " We have a symlink
                            let flag = prePadding . g:WebDevIconsUnicodeDecorateFolderNodesSymlinkSymbol . artifactFix . postPadding
                        el
                            " We have a regular folder
                            let flag = prePadding . WebDevIconsGetFileTypeSymbol(path.str(), path.isDirectory) . postPadding
                        en
                    en

                el
                    " the user did not enable exact matching
                    if g:DevIconsEnableFoldersOpenClose && directoryOpened
                        " the folder is open
                        let flag = prePadding . g:DevIconsDefaultFolderOpenSymbol . artifactFix . postPadding
                    el
                        " the folder is not open
                        if path.isSymLink
                            " We have a symlink
                            let flag = prePadding . g:WebDevIconsUnicodeDecorateFolderNodesSymlinkSymbol . artifactFix . postPadding
                        el
                            " We have a regular folder
                            let flag = prePadding . g:WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol . artifactFix . postPadding
                        en
                    en

                en

            el
                let flag = prePadding . ' ' . artifactFix . postPadding
            en

            call path.flagSet.clearFlags('webdevicons')

            if flag !=? ''
                call path.flagSet.addFlag('webdevicons', flag)
            en
        endf


" call setup after processing all the functions (to avoid errors)
" had some issues with ¿VimEnter,¿ for now using :
    call s:initialize()

let &cpo = s:save_cpo
unlet s:save_cpo

