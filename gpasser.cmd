@echo off
pushd & color & title gpasser
setlocal EnableDelayedExpansion

set alphanum=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
set string=%alphanum%987654321

if [%1]==[] exit
set "target=%1"


echo Selected target root: %target%
call :fileExtension %target%
goto mashMD5

:fileExtension
set targetex=%~x1
exit /b


:mashMD5
echo Working...

echo %processor_revision%-%random%-%processor_level%-%random%>>%target%
CertUtil -hashfile %target% MD2
CertUtil -hashfile %target% MD4
CertUtil -hashfile %target% SHA384
CertUtil -hashfile %target% SHA512
CertUtil -hashfile %target% MD5
CertUtil -hashfile %target% SHA256




:_LenLoop
IF NOT "%string:~18%"=="" SET string=%string:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%string:~9,1%
SET /A _Len=_Len+_tmp
SET count=0
SET rndalphanum=
:_loop
SET /a count+=1
SET _RND=%Random%
SET /A _RND=_RND%%%_Len%
SET rndalphanum=!rndalphanum!!alphanum:~%_RND%,1!
If !count! lss 8 goto _loop
Ren %target% %rndalphanum%%targetex%
echo Done