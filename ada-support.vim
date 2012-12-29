if v:version < 700
    echohl WarningMsg | echo 'The plugin ada-support.vim needs Vim version >= 7 .'| echohl None
    finish
endif
"
" Prevent duplicate loading:
"
if exists("g:Ada_Version") || &cp
    finish
endif
" sqrt(5)/2-1/2
let g:Ada_Version= "0.6"

" let s:Ada_SourceCodeExtensions  = 'ada ads adb gnat gpr'

let maplocalleader ='\'

if exists("g:Ada_MapLeader")
    let maplocalleader  = g:Ada_MapLeader
endif

" Comment Conversion
let s:Ada_CommentSymbol = '^\s*--  \s*'

function Ada_Uncomment() range
    silent exe a:firstline.','.a:lastline.":s#^--  ##"
endfunction

function Ada_Comment() range
    silent exe a:firstline.','.a:lastline.":s#^#--  #"
endfunction

nnoremap   <buffer>  <silent>  <LocalLeader>cc         :call Ada_Comment()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>cc         :call Ada_Comment()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>cc    <Esc>:call Ada_Comment()<CR>a
nnoremap   <buffer>  <silent>  <LocalLeader>cu         :call Ada_Uncomment()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>cu         :call Ada_Uncomment()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>cu    <Esc>:call Ada_Uncomment()<CR>a

" Insert Header
function Ada_Header()
    let l = repeat('-',60)
    silent put =l
    let f      ='--      File   '.expand("%:t")
    silent put=f
    silent put ='--  Synopsis   '
    silent put ='--    Author   '
    let s      ='--      Date   '.strftime("%Y %b %d %X")
    silent put=s
    silent put =l
endfunction

nnoremap   <buffer>  <silent>  <LocalLeader>ih         :call Ada_Header()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ih         :call Ada_Header()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ih    <Esc>:call Ada_Header()<CR>a
" Insert Package Spec
function Ada_PackageSpec() 
    let Name =input( 'Give a package name: ' )
    if empty(Name)
        return
    endif
    let len = strlen(Name)
    let l = (60-len-4)/2
    let r = (60-len-4) - l
    let st = '--'.repeat(' ', l).Name.repeat(' ',r).'--'
    silent put ='------------------------------------------------------------'
    silent put =st
    silent put ='------------------------------------------------------------'
    silent put ='package '.Name.' is'
    silent put ='pragma pure;'
    silent put ='end '.Name.';'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ips         :call Ada_PackageSpec()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ips         :call Ada_PackageSpec()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ips    <Esc>:call Ada_PackageSpec()<CR>a

" Insert Package Body
function Ada_PackageBody() 
    let Name =input( 'Give a package name: ' )
    if empty(Name)
        return
    endif
    let len = strlen(Name)
    let l = (60-len-4)/2
    let r = (60-len-4) - l
    let st = '--'.repeat(' ', l).Name.repeat(' ',r).'--'
    silent put ='------------------------------------------------------------'
    silent put =st
    silent put ='------------------------------------------------------------'
    silent put ='package body '.Name.' is'
    silent put ='begin'
    silent put ='null;'
    silent put ='end '.Name.';'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ipb         :call Ada_PackageBody()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ipb         :call Ada_PackageBody()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ipb    <Esc>:call Ada_PackageBody()<CR>a
" Insert Function Spec
function Ada_FunctionSpec() 
    let Name =input( 'Give a function name: ' )
    if empty(Name)
        return
    endif
    let len = strlen(Name)
    let l = (60-len-4)/2
    let r = (60-len-4) - l
    let st = '--'.repeat(' ', l).Name.repeat(' ',r).'--'
    silent put ='------------------------------------------------------------'
    silent put =st
    silent put ='------------------------------------------------------------'
    silent put ='function '.Name.' (...) return ...;'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ifs         :call Ada_FunctionSpec()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ifs         :call Ada_FunctionSpec()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ifs    <Esc>:call Ada_FunctionSpec()<CR>a
" Insert Function Body
function Ada_FunctionBody() 
    let Name =input( 'Give a function name: ' )
    if empty(Name)
        return
    endif
    let len = strlen(Name)
    let l = (60-len-4)/2
    let r = (60-len-4) - l
    let st = '--'.repeat(' ', l).Name.repeat(' ',r).'--'
    silent put ='------------------------------------------------------------'
    silent put =st
    silent put ='------------------------------------------------------------'
    silent put ='function '.Name.' (...) return ... is'
    silent put ='begin'
    silent put ='return...'
    silent put ='end '.Name.';'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ifb         :call Ada_FunctionBody()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ifb         :call Ada_FunctionBody()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ifb    <Esc>:call Ada_FunctionBody()<CR>a
" Insert Procedure Spec
function Ada_ProcedureSpec() 
    let Name =input( 'Give a procedure name: ' )
    if empty(Name)
        return
    endif
    let len = strlen(Name)
    let l = (60-len-4)/2
    let r = (60-len-4) - l
    let st = '--'.repeat(' ', l).Name.repeat(' ',r).'--'
    silent put ='------------------------------------------------------------'
    silent put =st
    silent put ='------------------------------------------------------------'
    silent put ='procedure '.Name.';'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>irs         :call Ada_ProcedureSpec()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>irs         :call Ada_ProcedureSpec()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>irs    <Esc>:call Ada_ProcedureSpec()<CR>a

" Insert Procedure body
function Ada_ProcedureBody() 
    let Name =input( 'Give a package name: ' )
    if empty(Name)
        return
    endif
    let len = strlen(Name)
    let l = (60-len-4)/2
    let r = (60-len-4) - l
    let st = '--'.repeat(' ', l).Name.repeat(' ',r).'--'
    silent put ='------------------------------------------------------------'
    silent put =st
    silent put ='------------------------------------------------------------'
    silent put ='procedure '.Name.' (...) is'
    silent put ='begin'
    silent put ='null;'
    silent put ='end '.Name.';'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>irb         :call Ada_ProcedureBody()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>irb         :call Ada_ProcedureBody()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>irb    <Esc>:call Ada_ProcedureBody()<CR>a

" Insert Pragma
function Ada_Pragma() 
    let Name =input( 'Give a pragma name: ' )
    if empty(Name)
        return
    endif
    let parameterList =input( 'Give Parameters: ' )
    if empty(parameterList)
        silent put ='pragma '.Name.';'
    else
        silent put ='pragma '.Name.' ('.parameterList.');'
    endif
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ig         :call Ada_Pragma()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ig         :call Ada_Pragma()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ig    <Esc>:call Ada_Pragma()<CR>a
" Insert Type Definition
function Ada_Type() 
    let Name =input( 'Give a type name: ' )
    if empty(Name)
        return
    endif
    silent put ='type '.Name.' is ...;'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>itt         :call Ada_Type()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>itt         :call Ada_Type()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>itt    <Esc>:call Ada_Type()<CR>a

" Insert SubType Definition
function Ada_SubType() 
    let Name =input( 'Give a type name: ' )
    if empty(Name)
        return
    endif
    silent put ='subtype '.Name.' is ...;'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ist         :call Ada_SubType()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ist         :call Ada_SubType()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ist    <Esc>:call Ada_SubType()<CR>a

" Insert With and Use clause
function Ada_WithUse() 
    let Name =input( 'Name is: ' )
    if empty(Name)
        return
    endif
    silent put ='with '.Name.';'
    silent put ='use  '.Name.';'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>iwu         :call Ada_WithUse()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>iwu         :call Ada_WithUse()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>iwu    <Esc>:call Ada_WithUse()<CR>a

" Insert Limited With clause
function Ada_LimitedWith() 
    let Name =input( 'Name is: ' )
    if empty(Name)
        return
    endif
    silent put ='limited with '.Name.';'
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ilw         :call Ada_LimitedWith()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ilw         :call Ada_LimitedWith()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ilw    <Esc>:call Ada_LimitedWith()<CR>a
" Insert Insert For
function Ada_For() 
    let indexname =input( 'index name is: ' )
    if empty(indexname)
        return
    endif
    let range =input( 'range is: ' )
    if empty(range)
        return
    endif
    let label =input( 'label is: ')
    if strlen(label)
        silent put =label.':'
    endif
    silent put ='for '.indexname.' in ' .range.' loop'
    silent put ='null;'
    if empty(label)
        silent put ='end loop;'
    else
        silent put ='end loop '.label.';'
    endif
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ifo         :call Ada_For()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ifo         :call Ada_For()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ifo    <Esc>:call Ada_For()<CR>a
" Insert While
function Ada_While() 
    let condition =input( 'Condition is: ' )
    if empty(condition)
        return
    endif
    let label =input( 'label is: ')
    if strlen(label)
        silent put =label.':'
    endif
    silent put ='while '.condition.' loop'
    silent put ='null;'
    if empty(label)
        silent put ='end while;'
    else
        silent put ='end while '.label.';'
    endif
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>iwl         :call Ada_For()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>iwl         :call Ada_For()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>iwl    <Esc>:call Ada_For()<CR>a

" Insert Declare
function Ada_Declare() 
    let label =input( 'Label is: ' )
    if strlen(label)
        silent put =label.':'
    endif
    silent put ='declare'
    silent put ='begin'
    silent put ='null;'
    if empty(label)
        silent put ='end;'
    else
        silent put ='end '.label.';'
    endif
endfunction;

nnoremap   <buffer>  <silent>  <LocalLeader>ide         :call Ada_Declare()<CR>
vnoremap   <buffer>  <silent>  <LocalLeader>ide         :call Ada_Declare()<CR>
inoremap   <buffer>  <silent>  <LocalLeader>ide    <Esc>:call Ada_Declare()<CR>a

