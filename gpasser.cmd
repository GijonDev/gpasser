@echo off
setlocal EnableDelayedExpansion
pushd & color & title gpasser[%processor_level%]


if NOT [%1]==[] set "target=%1"


if NOT DEFINED target set /p "target=Select target:" & goto mashMD5
echo Select target:%target%


call :fileExtension %target%
goto mashMD5

:fileExtension
set targetex=%~x1
exit /b


:mashMD5
echo Working...
certutil -hashfile -v %target%
CertUtil -hashfile %target% MD5
CertUtil -hashfile %target% SHA256
echo %random%-%processor_revision%-%processor_level%-%random%>>%target%
CertUtil -hashfile %target% MD5
CertUtil -hashfile %target% SHA256


Set alphanum=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
Set string=%alphanum%987654321
:_LenLoop
IF NOT "%string:~18%"=="" SET string=%string:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%string:~9,1%
SET /A _Len=_Len+_tmp
Set count=0
SET rndalphanum=
:_loop
Set /a count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET rndalphanum=!rndalphanum!!alphanum:~%_RND%,1!
If !count! lss 8 goto _loop
Ren %target% %rndalphanum%%targetex%
echo Done. & echo.
pause & exit
