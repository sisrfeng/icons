" @todo fix duplicate global variable initialize here:
if !exists('g:icon_wf_enable')  | let g:icon_wf_enable = 1  | endif

if !exists('g:icon_wf_enable_nerdtree')  | let g:icon_wf_enable_nerdtree = 1  | endif

if !exists('g:Icons__FoldersOpenClose')  | let g:Icons__FoldersOpenClose = 0  | endif

if !exists('g:Icons__FolderPatternMatching')  | let g:Icons__FolderPatternMatching = 1  | endif

if !exists('g:Icons__FolderExtensionPatternMatching')  | let g:Icons__FolderExtensionPatternMatching = 0  | endif

" end @todo duplicate global variables

" Temporary (hopefully) fix for glyph issues in gvim
" (proper fix is with the  actual font patcher)
if !exists('g:icon_wf_gui_glyph_fix')
    if has('gui_running')
        let g:icon_wf_gui_glyph_fix = 1
    el
        let g:icon_wf_gui_glyph_fix = 0
    en
en

if !exists('g:Icons__NERDTreeRedraw')
    if has('gui_running')
        let g:Icons__NERDTreeRedraw = 1
    el
        let g:Icons__NERDTreeRedraw = 0
    en
en

if g:icon_wf_enable_nerdtree == 1
    if !exists('g:loaded_nerd_tree')
         echohl WarningMsg |
             \ echomsg ' requires NERDTree to be loaded before icon_wf.'
    en

    if exists('g:loaded_nerd_tree') && g:loaded_nerd_tree == 1 && !exists('g:NERDTreePathNotifier')
         let g:icon_wf_enable_nerdtree = 0
         echohl WarningMsg |
        \ echomsg 'vim-icon_wf requires a newer version of NERDTree to show glyphs in NERDTree - consider updating NERDTree.'
    en

    " @todo I don't even want this to execute UNLESS the user has the
    " 'nerdtree-git-plugin' INSTALLED (not LOADED)
    " As it currently functions this warning will display even if the user does
    " not have nerdtree-git-plugin not just if it isn't loaded yet
    " (not what we want)
    "if !exists('g:loaded_nerdtree_git_status')
    "   echohl WarningMsg |
    "     \ echomsg 'vim-icon_wf works better when 'nerdtree-git-plugin' is loaded before vim-icon_wf (small refresh issues otherwise).'
    "endif
en



fun! s:SetupListeners()
    call g:NERDTreePathNotifier.AddListener('init'         , 'NERDTreeIcons_RefreshListener')
    call g:NERDTreePathNotifier.AddListener('refresh'      , 'NERDTreeIcons_RefreshListener')
    call g:NERDTreePathNotifier.AddListener('refreshFlags' , 'NERDTreeIcons_RefreshListener')
endf

" util like helpers
" scope: local
fun! s:Refresh()
    call b:NERDTree.root.refreshFlags()
    call NERDTreeRender()
endf

" Temporary (hopefully) fix for glyph issues in gvim (proper fix is with the
" actual font patcher)

" NERDTree-C
" scope: global
fun! Icons_NERDTreeChangeRootHandler(node)
    call b:NERDTree.changeRoot(a:node)
    call NERDTreeRender()
    call a:node.putCursorHere(0, 0)
    if g:Icons__NERDTreeRedraw ==# 1
        redraw!
    en
endf

" NERDTree-u
" scope: global
fun! Icons_NERDTreeUpDirCurrentRootClosedHandler()
    call nerdtree#ui_glue#upDir(0)
    if g:Icons__NERDTreeRedraw ==# 1
        redraw!
    en
endf

fun! Icons_NERDTreeDirUpdateFlags(node, glyph)
    let path = a:node.path
    let isOpen = a:node.isOpen
    let postPadding = g:Icons_NerdTreeAfterGlyphPadding
    let prePadding = g:Icons_NerdTreeBeforeGlyphPadding
    let hasGitFlags = (len(path.flagSet._flagsForScope('git')) > 0)
    let hasGitNerdTreePlugin = (exists('g:loaded_nerdtree_git_status') == 1)
    let collapsesToSameLine = (exists('g:NERDTreeCascadeSingleChildDir') == 1)
    let dirHasOnlyOneChildDir = 0

    if collapsesToSameLine
        " need to call to determin children:
        call a:node._initChildren(1)
        let dirHasOnlyOneChildDir = (a:node.getChildCount() ==# 1 && a:node.children[0].path.isDirectory)
    en

    " properly set collapsed/combined directory display to opened glyph
    if collapsesToSameLine && dirHasOnlyOneChildDir
        call Icons_NERDTreeDirOpen(a:node.children[0])
    en

    " align vertically at the same level: non git-flag nodes with git-flag nodes
    if g:Icons_NerdTreeGitPluginForceVAlign && !hasGitFlags && hasGitNerdTreePlugin
        let prePadding .= '  '
    en

    let flag = prePadding . a:glyph . postPadding

    call a:node.path.flagSet.clearFlags('icon_wf')

    if flag !=? ''
        call a:node.path.flagSet.addFlag('icon_wf', flag)
        "echom "added flag of " . flag
        call a:node.path.refreshFlags(b:NERDTree)
        "echom "flagset is now " . string(a:node.path.flagSet)
    en
endf

fun! Icons_NERDTreeDirClose(node)
    let a:node.path.isOpen = 0
    let glyph = g:Icons_UnicodeDecorateFolderNodesDefaultSymbol
    call Icons_NERDTreeDirUpdateFlags(a:node, glyph)
endf

fun! Icons_NERDTreeDirOpen(node)
    let a:node.path.isOpen = 1
    let glyph = g:DevIconsDefaultFolderOpenSymbol
    call Icons_NERDTreeDirUpdateFlags(a:node, glyph)
endf

fun! Icons_NERDTreeDirOpenRecursively(node)
    call Icons_NERDTreeDirOpen(a:node)
    for i in a:node.children
        if i.path.isDirectory ==# 1
            call Icons_NERDTreeDirOpenRecursively(i)
        en
    endfor
endf

fun! Icons_NERDTreeDirCloseRecursively(node)
    call Icons_NERDTreeDirClose(a:node)
    for i in a:node.children
        if i.path.isDirectory ==# 1
            call Icons_NERDTreeDirCloseRecursively(i)
        en
    endfor
endf

fun! Icons_NERDTreeDirCloseChildren(node)
    for i in a:node.children
        if i.path.isDirectory ==# 1
            call Icons_NERDTreeDirClose(i)
        en
    endfor
endf

" NERDTreeMapActivateNode and <2-LeftMouse>
" handle the user activating a tree node
" scope: global
fun! Icons_NERDTreeMapActivateNode(node)
    let isOpen = a:node.isOpen
    if isOpen
        let glyph = g:Icons_UnicodeDecorateFolderNodesDefaultSymbol
    el
        let glyph = g:DevIconsDefaultFolderOpenSymbol
    en
    let a:node.path.isOpen = !isOpen
    call Icons_NERDTreeDirUpdateFlags(a:node, glyph)
    " continue with normal activate logic
    call a:node.activate()
    " glyph change possible artifact clean-up
    if g:Icons__NERDTreeRedraw ==# 1
        redraw!
    en
endf

" NERDTreeMapActivateNodeSingleMode
" handle the user activating a tree node if NERDTreeMouseMode is setted to 3
" scope: global
fun! Icons_NERDTreeMapActivateNodeSingleMode(node)
    if g:NERDTreeMouseMode == 3
        let isOpen = a:node.isOpen
        if isOpen
            let glyph = g:Icons_UnicodeDecorateFolderNodesDefaultSymbol
        el
            let glyph = g:DevIconsDefaultFolderOpenSymbol
        en
        let a:node.path.isOpen = !isOpen
        call Icons_NERDTreeDirUpdateFlags(a:node, glyph)
        " continue with normal activate logic
        call a:node.activate()
        " glyph change possible artifact clean-up
        if g:Icons__NERDTreeRedraw ==# 1
            redraw!
        en
    en
endf

fun! Icons_NERDTreeMapOpenRecursively(node)
    " normal original logic:
    call nerdtree#echo('Recursively opening node. Please wait...')
    call Icons_NERDTreeDirOpenRecursively(a:node)
    call a:node.openRecursively()
    " continue with normal original logic:
    call b:NERDTree.render()
    " glyph change possible artifact clean-up
    if g:Icons__NERDTreeRedraw ==# 1
        redraw!
    en
    call nerdtree#echo('Recursively opening node. Please wait... DONE')
endf

fun! Icons_NERDTreeMapCloseChildren(node)
    " close children but not current node:
    call Icons_NERDTreeDirCloseChildren(a:node)
    " continue with normal original logic:
    call a:node.closeChildren()
    call b:NERDTree.render()
    call a:node.putCursorHere(0, 0)
    " glyph change possible artifact clean-up
    if g:Icons__NERDTreeRedraw ==# 1
        redraw!
    en
endf

fun! Icons_NERDTreeMapCloseDir(node)
    " continue with normal original logic:
    let parent = a:node.parent
    while g:NERDTreeCascadeOpenSingleChildDir && !parent.isRoot()
        let childNodes = parent.getVisibleChildren()
        if len(childNodes) == 1 && childNodes[0].path.isDirectory
            let parent = parent.parent
        el
            break
        en
    endwhile
    if parent ==# {} || parent.isRoot()
        call nerdtree#echo('cannot close tree root')
    el
        call parent.close()
        " update the glyph
        call Icons_NERDTreeDirClose(parent)
        call b:NERDTree.render()
        call parent.putCursorHere(0, 0)
        " glyph change possible artifact clean-up
        if g:Icons__NERDTreeRedraw ==# 1
            redraw!
        en
    en
endf

fun! Icons_NERDTreeMapUpdirKeepOpen()
    call Icons_NERDTreeDirOpen(b:NERDTree.root)
    " continue with normal logic:
    call nerdtree#ui_glue#upDir(1)
    call s:Refresh()
    " glyph change possible artifact clean-up
    if g:Icons__NERDTreeRedraw ==# 1
        redraw!
    en
endf

if g:icon_wf_enable == 1 && g:icon_wf_enable_nerdtree == 1
    call s:SetupListeners()

    if g:Icons__FoldersOpenClose

        " These overrides are needed because we cannot
        " simply use AddListener for reliably updating
        " the folder open/close glyphs because the event
        " path has no access to the 'isOpen' property
        " some of these are a little more brittle/fragile
        " than others
        " TODO FIXME better way to reliably update
        " open/close glyphs in NERDTreeIcons_RefreshListener

        " NERDTreeMapActivateNode
        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapActivateNode,
            \ 'callback': 'Icons_NERDTreeMapActivateNode',
            \ 'override': 1,
            \ 'scope': 'DirNode' })

        " NERDTreeMapCustomOpen
        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapCustomOpen,
            \ 'callback': 'Icons_NERDTreeMapActivateNode',
            \ 'override': 1,
            \ 'scope': 'DirNode' })

        " NERDTreeMapOpenRecursively
        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapOpenRecursively,
            \ 'callback': 'Icons_NERDTreeMapOpenRecursively',
            \ 'override': 1,
            \ 'scope': 'DirNode' })

        " NERDTreeMapCloseChildren
        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapCloseChildren,
            \ 'callback': 'Icons_NERDTreeMapCloseChildren',
            \ 'override': 1,
            \ 'scope': 'DirNode' })

        " NERDTreeMapCloseChildren
        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapCloseDir,
            \ 'callback': 'Icons_NERDTreeMapCloseDir',
            \ 'override': 1,
            \ 'scope': 'Node' })

        " <2-LeftMouse>
        call NERDTreeAddKeyMap({
            \ 'key': '<2-LeftMouse>',
            \ 'callback': 'Icons_NERDTreeMapActivateNode',
            \ 'override': 1,
            \ 'scope': 'DirNode' })

        " <LeftRelease>
        call NERDTreeAddKeyMap({
            \ 'key': '<LeftRelease>',
            \ 'callback': 'Icons_NERDTreeMapActivateNodeSingleMode',
            \ 'override': 1,
            \ 'scope': 'DirNode' })

        " NERDTreeMapUpdirKeepOpen
        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapUpdirKeepOpen,
            \ 'callback': 'Icons_NERDTreeMapUpdirKeepOpen',
            \ 'override': 1,
            \ 'scope': 'all' })

    en

    " Temporary (hopefully) fix for glyph issues in gvim (proper fix is with the
    " actual font patcher)
    if g:icon_wf_gui_glyph_fix ==# 1
        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapChangeRoot,
            \ 'callback': 'Icons_NERDTreeChangeRootHandler',
            \ 'override': 1,
            \ 'quickhelpText': "change tree root to the\n\"    selected dir\n\"    plus devicons redraw\n\"    hack fix",
            \ 'scope': 'Node' })

        call NERDTreeAddKeyMap({
            \ 'key': g:NERDTreeMapUpdir,
            \ 'callback': 'Icons_NERDTreeUpDirCurrentRootClosedHandler',
            \ 'override': 1,
            \ 'quickhelpText': "move tree root up a dir\n\"    plus devicons redraw\n\"    hack fix",
            \ 'scope': 'all' })
    en

en

"
