" Version: 0.11.0
"  https://github.com/ryanoasis/vim-devicons

scriptencoding utf-8

let s:save_cpo = &cpo  | set cpo&vim
if exists('g:loaded_icon_wf')  | finish  | en | let g:loaded_icon_wf = 1

" enable / disable settings
    "\ only if variable is not defined,
        " set the variable to the default value,
    "
    " @param {string} var Variable name with its scope.
    " @param {*} default Default value for variable.
    fun! s:set(var, default) abort
        if !exists(a:var)
            if type(a:default)
                exe     'let' a:var '=' string(a:default)
            el
                exe     'let' a:var '=' a:default
                                      "\ type为number
            en
        en
    endf

    call s:set('g:icon_wf_enable'                                        , 1)
    call s:set('g:icon_wf_enable_nerdtree'                               , 1)
    call s:set('g:icon_wf_enable_denite'                                 , 1)
    call s:set('g:icon_wf_enable_startify'                               , 1)
    call s:set('g:icon_wf_conceal_nerdtree_brackets'                     , 1)
    call s:set('g:Icons__AppendArtifactFix'          , has('gui_running') ? 1 : 0)
    call s:set('g:Icons__ArtifactFixChar'                                   , ' ')

" config options
    call s:set('g:Icons_utf_DecorateFileNodes'               , 1)
    call s:set('g:Icons_utf_DecorateFolderNodes'             , 1)

    call s:set('g:Icons__FoldersOpenClose'                    , 0)
    call s:set('g:Icons__FolderPatternMatching'               , 1)
    call s:set('g:Icons__FolderExtensionPatternMatching'      , 0)
    call s:set('g:Icons__Distro'                              , 1)
    call s:set('g:Icons_utf_DecorateFolderNodesExactMatches' , 1)
    call s:set('g:Icons_utf_GlyphDoubleWidth'                , 1)
    call s:set('g:Icons_NerdTreeBeforeGlyphPadding'             , ' ')
    call s:set('g:Icons_NerdTreeAfterGlyphPadding'              , ' ')
    call s:set('g:Icons_NerdTreeGitPluginForceVAlign'           , 1)
    call s:set('g:NERDTreeUpdateOnCursorHold'                        , 1) " Obsolete: For backward compatibility
    call s:set('g:NERDTreeGitStatusUpdateOnCursorHold'               , 1)
    call s:set('g:Icons_TabAirLineBeforeGlyphPadding'           , ' ')
    call s:set('g:Icons_TabAirLineAfterGlyphPadding'            , '')


    call s:set('g:Icons_utf_DecorateFileNodesDefaultSymbol'   , '')
    call s:set('g:Icons_utf_ByteOrderMarkerDefaultSymbol'     , '')
    call s:set('g:Icons__DefaultFolderOpenSymbol'                    , '')
    call s:set('g:Icons_utf_DecorateFolderNodesDefaultSymbol' , g:Icons__FoldersOpenClose ? '' : '')
    call s:set('g:Icons_utf_DecorateFolderNodesSymlinkSymbol' , '')

" local functions
    function s:getDistro()
        if exists('s:distro')
            return s:distro
        en

        if has('bsd')
            let s:distro = ''
            return s:distro
        en

        if g:Icons__Distro && executable('lsb_release')
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

        if exists('g:Icons_OS')
            let s:is_darwin = g:Icons_OS ==? 'Darwin'
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
        "
        "\ 
            let s:file_node_extensions = {
                \ 'styl'     : '',
                \ 'htm'      : '',
                \ 'html'     : '',
                \ 'slim'     : '',
                \ 'haml'     : '',
                \ 'ejs'      : '',
                \ 'css'      : '',
                \ 'less'     : '',
                \ 'md'       : '⬇️',
                \ 'mdx'      : '⬇️',
                \ 'markdown' : '⬇️',
                \ 'rmd'      : '⬇️',
                \
                \ 'json'     : '',
                \ 'webmanifest' : '',
                \ 'js'       : '',
                \ 'mjs'      : '',
                \ 'jsx'      : '',
                \
                \ 'rb'       : '',
                \ 'gemspec'  : '',
                \ 'rake'     : '',
                \
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
                \
                \ 'conf'     : '',
                \ 'ini'      : '',
                \ 'yml'      : '',
                \ 'yaml'     : '',
                \ 'toml'     : '',
                \ 'bat'      : '',
                \ 'mk'       : '',
                \
                \ 'jpg'      : '',
                \ 'jpeg'     : '',
                \ 'bmp'      : '',
                \ 'png'      : '',
                \ 'webp'     : '',
                \ 'gif'      : '',
                \ 'ico'      : '',
                \
                \ 'twig'     : '',
                \ 'cpp'      : '',
                \ 'c++'      : '',
                \ 'cxx'      : '',
                \ 'cc'       : '',
                \ 'cp'       : '',
                \ 'c'        : '',
                \
                \ 'cs'       : '',
                \ 'h'        : '',
                \ 'hh'       : '',
                \ 'hpp'      : '',
                \ 'hxx'      : '',
                \
                \ 'hs'       : '',
                \ 'lhs'      : '',
                \ 'nix'      : '',
                \
                             "\ ☽
                \ 'lua'      : '☾',
                \ 'java'     : '',
                \ 'fish'     : '',
                \ 'sh'       : '',
                \ 'bash'     : '',
                \ 'zsh'      : '',
                \ '.zlogin'  : '',
                \ 'zshenv'   : '',
                \ 'zz'       : '',
                \ 'ksh'      : '',
                \ 'csh'      : '',
                \ 'awk'      : '',
                \ 'ps1'      : '',
                \ 'snippets' : '',
                \ 'ml'       : 'λ',
                \ 'mli'      : 'λ',
                \ 'scm'      : 'λ',
                  "\ scheme经常用lambda 表达式?, https://people.eecs.berkeley.edu/~bh/ssch9/lambda.html
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
                \ 'w'           :'🗀',
                \ 'man'         :'⚦',
                \ 'txt'         :'📄',
                \}

            if !exists('g:Icons_utf_DecorateFileNodesExtensionSymbols')
                let g:Icons_utf_DecorateFileNodesExtensionSymbols = {}
            en

            "  allow user overriding of ¿specific individual keys ¿in vimrc
            " (only gvimrc was working previously)
            for [key, val] in items(s:file_node_extensions)
                if !has_key(g:Icons_utf_DecorateFileNodesExtensionSymbols, key)
                    let g:Icons_utf_DecorateFileNodesExtensionSymbols[key] = val
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
                \ '.zshrc'                           : '',
                \ '.zshenv'                          : '',
                \ '.zprofile'                        : '',
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

            if !exists('g:Icons_utf_DecorateFileNodesExactSymbols')
                " do not remove: exact-match-case-sensitive-*
                let g:Icons_utf_DecorateFileNodesExactSymbols = {}
            en

            for [key, val] in items(s:file_node_exact_matches)
            if !has_key(g:Icons_utf_DecorateFileNodesExactSymbols, key)
                let g:Icons_utf_DecorateFileNodesExactSymbols[key] = val
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

            if !exists('g:Icons_utf_DecorateFileNodesPatternSymbols')
                let g:Icons_utf_DecorateFileNodesPatternSymbols = {}
            en


            for [key, val] in items(s:file_node_pattern_matches)
                if !has_key(g:Icons_utf_DecorateFileNodesPatternSymbols, key)
                    let g:Icons_utf_DecorateFileNodesPatternSymbols[key] = val
                en
            endfor
    endf


    fun! s:setSyntax()
        if g:icon_wf_enable_nerdtree == 1 && g:icon_wf_conceal_nerdtree_brackets == 1
        augroup icon_wf_conceal_nerdtree_brackets
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
                if g:icon_wf_enable_nerdtree
                augroup icon_wf_cursor_hold
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
            if g:icon_wf_enable_nerdtree == 1 && g:icon_wf_conceal_nerdtree_brackets == 1 && g:NERDTree.IsOpen()
            NERDTreeClose
            NERDTree
            en
        endf

        fun! s:softRefreshNerdTree()
            if g:icon_wf_enable_nerdtree == 1 && exists('g:NERDTree') && g:NERDTree.IsOpen()
            NERDTreeToggle
            NERDTreeToggle
            en
        endf


        fun! s:initialize()
            call s:setDictionaries()
            call s:setSyntax()
            call s:setCursorHold()

            if exists('g:loaded_unite') && g:icon_wf_enable_unite | call devicons#plugins#unite#init() | endif
            if exists('g:loaded_denite') && g:icon_wf_enable_denite | call devicons#plugins#denite#init() | endif
            if exists('g:loaded_startify') && g:icon_wf_enable_startify | call devicons#plugins#startify#init() | endif
        endf


" public functions


    " allow the first version of refresh to now call softRefresh
    fun! icon_wf#refresh()
        call icon_wf#softRefresh()
    endf

    fun! icon_wf#hardRefresh()
        call s:setSyntax()
        call s:hardRefreshNerdTree()
    endf

    fun! icon_wf#softRefresh()
        call s:setSyntax()
        call s:softRefreshNerdTree()
    endf

    " a:1 (bufferName), a:2 (isDirectory)
    fun! File_Icon(...) abort
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

        if isDirectory == 0 || g:Icons__FolderPatternMatching

        let symbol = g:Icons_utf_DecorateFileNodesDefaultSymbol
        let fileNodeExtension = tolower(fileNodeExtension)
        let fileNode = tolower(fileNode)

        for [pattern, glyph] in items(g:Icons_utf_DecorateFileNodesPatternSymbols)
            if match(fileNode, pattern) != -1
            let symbol = glyph
            break
            en
        endfor

        if symbol == g:Icons_utf_DecorateFileNodesDefaultSymbol
            if has_key(g:Icons_utf_DecorateFileNodesExactSymbols, fileNode)
            let symbol = g:Icons_utf_DecorateFileNodesExactSymbols[fileNode]
            elseif ((isDirectory == 1 && g:Icons__FolderExtensionPatternMatching) || isDirectory == 0) && has_key(g:Icons_utf_DecorateFileNodesExtensionSymbols, fileNodeExtension)
            let symbol = g:Icons_utf_DecorateFileNodesExtensionSymbols[fileNodeExtension]
            elseif isDirectory == 1
            let symbol = g:Icons_utf_DecorateFolderNodesDefaultSymbol
            en
        en

        el
        let symbol = g:Icons_utf_DecorateFolderNodesDefaultSymbol
        en

        let artifactFix = s:Icons__GetArtifactFix()

        return symbol . artifactFix

    endf

    " scope: local
    " Temporary (hopefully) fix for glyph issues in gvim
    " (proper fix is with the  actual font patcher)
    fun! s:Icons__GetArtifactFix()
        if g:Icons__AppendArtifactFix == 1
        let artifactFix = g:Icons__ArtifactFixChar
        el
        let artifactFix = ''
        en

        return artifactFix
    endf

    fun! Icons_GetFileFormatSymbol(...)
        let fileformat = ''
        let bomb = ''

        if (&bomb && g:Icons_utf_ByteOrderMarkerDefaultSymbol !=? '')
        let bomb = g:Icons_utf_ByteOrderMarkerDefaultSymbol . ' '
        en

        if &fileformat ==? 'dos'
        let fileformat = ''
        elseif &fileformat ==? 'unix'
        let fileformat = s:isDarwin() ? '' : s:getDistro()
        elseif &fileformat ==? 'mac'
        let fileformat = ''
        en

        let artifactFix = s:Icons__GetArtifactFix()

        return bomb . fileformat . artifactFix
    endf


    " for nerdtree plugin
        fun! NERDTreeIcons_RefreshListener(event)
            let path = a:event.subject
            let postPadding = g:Icons_NerdTreeAfterGlyphPadding
            let prePadding = g:Icons_NerdTreeBeforeGlyphPadding
            let hasGitFlags = (len(path.flagSet._flagsForScope('git')) > 0)
            let hasGitNerdTreePlugin = (exists('g:loaded_nerdtree_git_status') == 1)
            let artifactFix = s:Icons__GetArtifactFix()

            " align vertically at the same level: non git-flag nodes with git-flag nodes
            if g:Icons_NerdTreeGitPluginForceVAlign && !hasGitFlags && hasGitNerdTreePlugin
                let prePadding .= ' '
            en

            if !path.isDirectory
                " Hey we got a regular file, lets get it's proper icon
                let flag = prePadding . File_Icon(path.str()) . postPadding

            elseif path.isDirectory && g:Icons_utf_DecorateFolderNodes == 1
                " Ok we got a directory, some more tests and checks
                let directoryOpened = 0

                if g:Icons__FoldersOpenClose && len(path.flagSet._flagsForScope('icon_wf')) > 0
                    " did the user set different icons for open and close?

                    " isOpen is not available on the path listener directly
                    " but we added one via overriding particular keymappings for NERDTree
                    if has_key(path, 'isOpen') && path.isOpen == 1
                        let directoryOpened = 1
                    en
                en

                if g:Icons_utf_DecorateFolderNodesExactMatches == 1
                    " Did the user enable exact matching of folder type/names
                    " think node_modules
                    if g:Icons__FoldersOpenClose && directoryOpened
                        " the folder is open
                        let flag = prePadding . g:Icons__DefaultFolderOpenSymbol . artifactFix . postPadding
                    el
                        " the folder is not open
                        if path.isSymLink
                            " We have a symlink
                            let flag = prePadding . g:Icons_utf_DecorateFolderNodesSymlinkSymbol . artifactFix . postPadding
                        el
                            " We have a regular folder
                            let flag = prePadding . File_Icon(path.str(), path.isDirectory) . postPadding
                        en
                    en

                el
                    " the user did not enable exact matching
                    if g:Icons__FoldersOpenClose && directoryOpened
                        " the folder is open
                        let flag = prePadding . g:Icons__DefaultFolderOpenSymbol . artifactFix . postPadding
                    el
                        " the folder is not open
                        if path.isSymLink
                            " We have a symlink
                            let flag = prePadding . g:Icons_utf_DecorateFolderNodesSymlinkSymbol . artifactFix . postPadding
                        el
                            " We have a regular folder
                            let flag = prePadding . g:Icons_utf_DecorateFolderNodesDefaultSymbol . artifactFix . postPadding
                        en
                    en

                en

            el
                let flag = prePadding . ' ' . artifactFix . postPadding
            en

            call path.flagSet.clearFlags('icon_wf')

            if flag !=? ''
                call path.flagSet.addFlag('icon_wf', flag)
            en
        endf


" call setup after processing all the functions (to avoid errors)
" had some issues with ¿VimEnter,¿ for now using :
    call s:initialize()

let &cpo = s:save_cpo  | unlet s:save_cpo

