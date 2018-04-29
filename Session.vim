let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/git/rails/sample_app
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +6 app/views/users/new.html.erb
badd +240 ~/.vimrc
badd +6 test/controllers/users_controller_test.rb
badd +4 app/controllers/users_controller.rb
badd +135 app/assets/stylesheets/custom.scss
badd +1 users/new
badd +3 app/views/shared/_error_messages
badd +1 app/views/shared/_error_messages.html.erb
badd +1 app/models/user.rb
badd +71 test/models/user_test.rb
badd +12 test/test_helper.rb
badd +32 test/integration/users_signup_test.rb
badd +13 config/routes.rb
badd +1 config/application.rb
badd +12 app/views/layouts/application.html.erb
badd +2 app/views/users/show.html.erb
badd +48 config/environments/production.rb
badd +16 config/puma.rb
badd +1 Procfile
badd +9 test/controllers/sessions_controller_test.rb
badd +18 app/views/sessions/new.html.erb
badd +18 app/controllers/sessions_controller.rb
badd +1 app/models/application_record.rb
badd +0 test/controllers/static_pages_controller_test.rb
badd +7 test/integration/users_login_test.rb
badd +7 test/integration/site_layout_test.rb
argglobal
silent! argdel *
edit test/integration/users_login_test.rb
set splitbelow splitright
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
exe '1resize ' . ((&lines * 18 + 29) / 58)
exe '2resize ' . ((&lines * 18 + 29) / 58)
exe '3resize ' . ((&lines * 17 + 29) / 58)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 4 - ((3 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 0
wincmd w
argglobal
if bufexists('test/integration/users_signup_test.rb') | buffer test/integration/users_signup_test.rb | else | edit test/integration/users_signup_test.rb | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 14 - ((1 * winheight(0) + 9) / 18)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
normal! 05|
wincmd w
argglobal
if bufexists('test/controllers/static_pages_controller_test.rb') | buffer test/controllers/static_pages_controller_test.rb | else | edit test/controllers/static_pages_controller_test.rb | endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 16 - ((13 * winheight(0) + 8) / 17)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
16
normal! 012|
wincmd w
exe '1resize ' . ((&lines * 18 + 29) / 58)
exe '2resize ' . ((&lines * 18 + 29) / 58)
exe '3resize ' . ((&lines * 17 + 29) / 58)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
