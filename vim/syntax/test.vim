" Just to test some aspects of vim highlighting engine
":syntax region GpuProgramBlock start=+\(vertex_program\)\|\(fragment_program\)\|(geometry_program)+ end="}"

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endi

":syn match ifstart "\<if.*"	  nextgroup=ifline skipwhite skipempty
":syn match ifline  "[^ \t].*" nextgroup=ifstart,endif skipwhite skipempty contained
":syn match endif  "endif"	contained
""
""
"hi link ifstart Conditional
"hi link ifline Structure
"hi link endif Conditional

" Basic elements definition
"syntax region  Identifier			start="\<\i" end="\i\>"			

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"definition of a primitive datatype
let floatPatt='\<[0-9]\+\.[0-9]*\(e[-+]\=[0-9]\+\)\=\>'

execute 'syntax match Float " ' . floatPatt . '" contained'
let floatQuadPatt = printf( '%s %s %s %s', floatPatt, floatPatt, floatPatt, floatPatt )

execute 'syntax match   FloatQuad "' . floatQuadPatt . '"'
echo floatPatt floatPatt floatPatt floatPatt
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"syntax match   Float		        "\<[0-9]\+\.[0-9]*\(e[-+]\=[0-9]\+\)\=\>" contained

syntax region  String				start=+"+ end=+"+ skip=+\\"+ contains=@Spell

syntax region  Comment 				start="/\*" end="\*/"
syntax region  Comment 				start="//"	end="$"
syntax keyword Boolean				on off contained 

" syntax keyword BlockName			material technique pass texture_unit
""syntax keyword GpuProgramBlock 		vertex_program fragment_program geometry_program
"syntax keyword GpuProgramRefBlock	vertex_program_ref fragment_program_ref geometry_program_ref shadow_receiver_fragment_program_ref shadow_caster_vertex_program_ref shadow_receiver_vertex_program_ref 

syntax region MaterialBlockBegin	matchgroup=MaterialBlock start="\<material\>" end="{"me=e-1 transparent contains=Comment nextgroup=MaterialBlockEnd 
syntax region MaterialBlockEnd		matchgroup=MaterialBlock start="{" end="}" transparent contained contains=MaterialAttribute,Comment skipempty

"syntax keyword MaterialAttributeKeyword 	lod_values lod_strategy lod_distances receive_shadows transparency_casts_shadows set_texture_alias 
" if then else elseif end
syntax region 	Error 				start="\S" end="$" contained 

syntax keyword 	MaterialLodStrategy Distance PixelCount contained 
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*lod_strategy\>" end="$"  contained skipwhite contains=MaterialLodStrategy,Comment,Error

" lod_distances is a deprecated feature right now, so just skip it
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*lod_distances\>" end="$" contained skipwhite contains=Comment,Error
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*receive_shadows\>" end="$" contained skipwhite contains=Boolean,Comment,Error
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*receive_shadows\>" end="$" contained skipwhite contains=Boolean,Comment,Error
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*transparency_casts_shadows\>" end="$" contained skipwhite contains=Boolean,Comment,Error
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*lod_values\>" end="$" contained skipwhite contains=Boolean,Comment,Error



"syntax region MaterialAttribute 
if version >= 508 || !exists("did_test_syntax_inits")
	if version < 508
		let did_lua_syntax_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi link <args>
	endif

	HiLink String String
	HiLink FloatQuad Type
	HiLink MaterialBlock Structure
	HiLink Comment Comment
	HiLink MaterialAttribute Statement
	HiLink MaterialLodStrategy Identifier
	delcommand HiLink
endif

let b:current_syntax = "test"

