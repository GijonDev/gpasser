@echo off
setlocal EnableDelayedExpansion
pushd & color & title gpasser


if NOT [%1]==[] set "target=%1"


if NOT DEFINED target goto detectInput
echo Select target root:%target%
goto caller

:detectInput
set /p "target=Select target root:"

:caller
call :fileExtension %target%
goto mashMD5

:fileExtension
set targetex=%~x1
exit /b


:mashMD5
echo Working...

CertUtil -hashfile %target% MD2 > nul 2>&1
CertUtil -hashfile %target% MD4 > nul 2>&1
CertUtil -hashfile %target% SHA384 > nul 2>&1
CertUtil -hashfile %target% SHA512 > nul 2>&1
CertUtil -hashfile %target% MD5 > nul 2>&1
CertUtil -hashfile %target% SHA256 > nul 2>&1
::silently force-changes hashes

echo %processor_revision%-%random%-%processor_level%-%random%>>%target%
echo %random%-%processor_revision%-%processor_level%-%random%>>%target%
echo %processor_level%-%random%-%processor_revision%-%random%>>%target%
echo %processor_level%-%random%-%random%-%processor_revision%>>%target%
::changes the raw md5 calculation

CertUtil -hashfile %target% MD2
CertUtil -hashfile %target% MD4
CertUtil -hashfile %target% SHA384
CertUtil -hashfile %target% SHA512
CertUtil -hashfile %target% MD5
CertUtil -hashfile %target% SHA256
::reload hashes


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