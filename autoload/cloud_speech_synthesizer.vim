" =============================================================================
" FILE: cloud-speech-synthesizer.vim
" AUTHOR: koturn 0; <jeak.koutan.apple@gmail.com>
" Last Modified: 2013 04/03
" =============================================================================
let s:save_cpo = &cpo
set cpo&vim


let s:tmp_file_list = []


function! cloud_speech_synthesizer#synthesize(...)
  if a:0 != 2 && a:0 != 3
    echoerr 'Arguments must be two or three'
    return
  endif
  if !executable('base64')
    echoerr 'Not find base64 command'
    return
  endif

  try
    let l:base64_wav_str = s:post_to_server(a:1, a:2)
  catch
    echoerr v:exception
    return
  endtry

  let l:tmp = @*
  let @* = l:base64_wav_str

  new
  setl binary bufhidden=wipe noswapfile nobuflisted fenc=utf-8 ff=unix
  silent normal! P
  exec '%!' . g:cloud_speech_synthesizer#base64_cmd_path . ' -d'

  if a:0 == 2
    let l:wavfile = tempname()
    call add(s:tmp_file_list, l:wavfile)
    if !exists('#CloudSpeechsynthesizerAutoCmd')
      augroup CloudSpeechsynthesizerAutoCmd
        au VimLeave * call s:delete_tmp_files()
      augroup END
    endif
  else
    let l:wavfile = a:3
  endif
  exec 'write! ' . l:wavfile
  bdelete

  let @* = l:tmp
  call sound#play_wav(l:wavfile)
endfunction


function! s:post_to_server(lang, text)
  let l:lang = a:lang
  let l:text = a:text
  let l:json_str =
        \   '{'
        \ .   '"params" : ['
        \ .     '"' . l:lang . '",'
        \ .     '"' . l:text . '",'
        \ .     '"*",'
        \ .     '"audio/x-wav"'
        \ .   '],'
        \ .   '"method" : "speak"'
        \ . '}'
  let l:response = webapi#http#post('http://rospeex.ucri.jgn-x.jp/nauth_json/jsServices/VoiceTraSS', json_str)
  if l:response['status'] != 200
    throw 'Bad HTTP Status: ' . l:response['status']
  endif

  let l:content_json = webapi#json#decode(l:response['content'])
  if l:content_json['error'] !=# 'null'
    throw 'Error: ' . l:content_json['error']
  endif
  return l:content_json['result']['audio']
endfunction


function! s:delete_tmp_files()
  let l:remnant_file_list = []
  for l:tmp_file in s:tmp_file_list
    if delete(l:tmp_file)
      call add(remnant_file_list, l:tmp_file)
    endif
  endfor

  for l:remnant_file in l:remnant_file_list
    echoerr 'Could not delete' l:remnant_file
  endfor
endfunction
