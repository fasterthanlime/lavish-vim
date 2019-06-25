" Language:    Lavish
" Maintainer:  Amos Wenger <amoswenger@gmail.com>
" Based On:    https://github.com/pangloss/vim-javascript
" URL:         http://github.com/lavish-lang/lavish-vim
" License:     MIT

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'lavish'
    finish
endif

if version < 600
    syntax clear
endif

syntax sync fromstart
syntax case match

" Keywords
syntax match  lavishKeyword /\<\%(server\|client\|namespace\|struct\|enum\|union\|fn\)\>/

" Built-in types
syntax match  lavishType /\<\%(i8\|i16\|i32\|i64\|u8\|u16\|u32\|u64\|bool\|data\|string\|option\|array\|timestamp\)\>/

" Namespace definitions
syntax match   lavishNamespace /\<namespace\>/ skipwhite skipempty nextgroup=lavishNamespaceName skipwhite
syntax match   lavishNamespaceName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishNamespaceBody

syntax region lavishNamespaceBody start=/{/ end=/}/ contains=@lavishTop

" Struct definitions
syntax match   lavishStruct /\<struct\>/ skipwhite skipempty nextgroup=lavishStructName skipwhite
syntax match   lavishStructName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishStructBody

syntax region lavishStructBody contained matchgroup=lavishStructBody start=/{/ end=/}/ contains=lavishStructArgCommas,lavishComment,lavishStructArgName skipwhite skipempty extend fold
syntax match  lavishStructArgName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishStructArgColon
syntax match  lavishStructArgColon contained ':' skipwhite skipempty nextgroup=lavishStructArgType
syntax match  lavishStructArgType contained contains=lavishType /\<\K\k*/ skipwhite skipempty nextgroup=lavishStructArgComma
syntax match  lavishStructArgComma contained ',' skipwhite skipempty nextgroup=lavishStructArgName

" Enum definitions
syntax match   lavishEnum /\<enum\>/ skipwhite skipempty nextgroup=lavishEnumName skipwhite
syntax match   lavishEnumName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishEnumBody

syntax region lavishEnumBody contained matchgroup=lavishEnumBody start=/{/ end=/}/ contains=lavishEnumArgCommas,lavishComment,lavishEnumArgName skipwhite skipempty extend fold
syntax match  lavishEnumArgName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishEnumArgComma
syntax match  lavishEnumArgComma contained ',' skipwhite skipempty nextgroup=lavishEnumArgName

" Union definitions
syntax match   lavishUnion /\<union\>/ skipwhite skipempty nextgroup=lavishUnionName skipwhite
syntax match   lavishUnionName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishUnionBody

syntax region lavishUnionBody contained matchgroup=lavishUnionBody start=/{/ end=/}/ contains=lavishUnionArgCommas,lavishComment,lavishUnionArgName skipwhite skipempty extend fold
syntax match  lavishUnionArgName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishUnionArgComma
syntax match  lavishUnionArgComma contained ',' skipwhite skipempty nextgroup=lavishUnionArgName

" Functions definitions
syntax match  lavishFunction /\<fn\>/ skipwhite skipempty nextgroup=lavishFuncName,lavishFuncArgs skipwhite
syntax match  lavishFuncName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishFuncArgs
syntax region lavishFuncArgs contained matchgroup=lavishFuncParens start=/(/ end=/)/ contains=lavishFuncArgCommas,lavishComment,lavishFuncArgName skipwhite skipempty nextgroup=lavishResultArrow,lavishFuncBlock extend fold
syntax match  lavishResultArrow contained /\s*->/ skipwhite skipempty nextgroup=lavishResultArgs
syntax region lavishResultArgs contained matchgroup=lavishFuncParens start=/(/ end=/)/ contains=lavishComment,lavishFuncArgName skipwhite skipempty nextgroup=lavishFuncBlock extend fold
syntax match  lavishFuncArgName contained /\<\K\k*/ skipwhite skipempty nextgroup=lavishFuncArgColon
syntax match  lavishFuncArgColon contained ':' skipwhite skipempty nextgroup=lavishFuncArgType
syntax match  lavishFuncArgType contained contains=lavishType /\<\K\k*/ skipwhite skipempty nextgroup=lavishFuncArgComma
syntax match  lavishFuncArgComma contained ',' skipwhite skipempty nextgroup=lavishFuncArgName

" Comments
syntax keyword lavishCommentTodo    contained TODO FIXME XXX TBD
syntax region  lavishComment        start=+//+ end=/$/ contains=lavishCommentTodo,@Spell extend keepend
syntax region  lavishComment        start=+/\*+  end=+\*/+ contains=lavishCommentTodo,@Spell fold extend keepend

syn cluster lavishTop contains=lavishNamespace,lavishStruct,lavishEnum,lavishUnion,lavishFunction,lavishComment,lavishKeyword

" Define the default highlighting
hi def link lavishCommentTodo Todo
hi def link lavishComment Comment
hi def link lavishKeyword Keyword
hi def link lavishType Type

hi def link lavishNamespace Keyword
hi def link lavishNamespaceName Type

hi def link lavishStruct Keyword
hi def link lavishStructName Type
hi def link lavishStructArgName Identifier
hi def link lavishStructArgType Type

hi def link lavishEnum Keyword
hi def link lavishEnumName Type
hi def link lavishEnumArgName Identifier

hi def link lavishUnion Keyword
hi def link lavishUnionName Type
hi def link lavishUnionArgName Type

hi def link lavishFunction Keyword
hi def link lavishFuncName Identifier
hi def link lavishFuncArgName Identifier
hi def link lavishFuncArgType Type

if !exists('b:current_syntax')
    let b:current_syntax = 'lavish'
endif

