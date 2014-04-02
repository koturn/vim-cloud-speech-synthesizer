vim-cloud-speech-synthesizer
=====

## Summary:
This is a Vim plugin of speech synthesizer used Clound Speech Synthesis Service
of NICT.

- [http://komeisugiura.jp/software/software_jp.html](http://komeisugiura.jp/software/software_jp.html)

In consideration of the execution speed, this plug-in is not practical for
real-time processing, but is useful for generating speech synthesis wav-file.




## Usage:

Execute following commands and you can hear the result of speech synthesis.
Specifications of Vim, it is necessary to escape-character(\\) between words
of the sentence.

```VimL
:CloudSpeechSynthesize ja こんにちは
```

```VimL
:CloudSpeechSynthesize en Hello
```

```VimL
:CloudSpeechSynthesize en Good\ morning!
```

In this example, Vim makes a temporary wav-file and play it by sound.vim.
When you exit Vim, delete the temporary wav-files.
If you want to save the result of speech synthesis as a wav-file, specify
a wav-file name at the last of argument of the command.

```VimL
:CloudSpeechSynthesize ja こんにちは result.wav
```

```VimL
:CloudSpeechSynthesize en Hello result.wav
```

```VimL
:CloudSpeechSynthesize en Good\ morning! result.wav
```




## Requirement:

base64 command

[curl command](http://curl.haxx.se/ "curl")

[mattn/webapi-vim](https://github.com/mattn/webapi-vim "webapi-vim")

[Shougo/vimproc.vim](https://github.com/Shougo/vimproc.vim "vimproc.vim")

[osyo-manga/vim-sound](https://github.com/osyo-manga/vim-sound "vim-sound")




## Installation:

### For NeoBundle User

[NeoBundle](https://github.com/Shougo/neobundle.vim "NeoBundle") enables
resolving dependencies and lazy-loading.
Write following code in your .vimrc and do command :NeoBundleInstall.

```VimL
NeoBundleLazy 'koturn/vim-cloud-speech-synthesizer', {
      \ 'depends' : ['mattn/webapi-vim', 'Shougo/vimproc.vim', 'osyo-manga/vim-sound']
      \ 'autoload' : {'commands' : 'CloudSpeechSynthesize'}
      \}
```


### For Vundle User

Write following code in your .vimrc and do command :BundleInstall.

```VimL
Bundle 'mattn/webapi-vim'
Bundle 'Shougo/vimproc.vim'
Bundle 'osyo-manga/vim-sound'
Bundle 'koturn/vim-cloud-speech-synthesizer'
```

If you use other plugin manager or don't use it, I'm sorry, but please install
this plugin on your own.
