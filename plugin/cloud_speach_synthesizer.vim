" =============================================================================
" FILE: cloud-speech-synthesizer.vim
" AUTHOR: koturn 0; <jeak.koutan.apple@gmail.com>
" Last Modified: 2014 04/03
" =============================================================================
if exists('g:loaded_cloud_speech_synthesizer')
  finish
endif
let g:loaded_cloud_speech_synthesizer = 1
let s:save_cpo = &cpo
set cpo&vim


let g:cloud_speech_synthesizer#base64_cmd_path = get(g:, 'cloud_speech_synthesizer#base64_cmd_path', 'base64')


command! -bar -nargs=* CloudSpeechSynthesize  call cloud_speech_synthesizer#synthesize(<f-args>)


let &cpo = s:save_cpo
unlet s:save_cpo
