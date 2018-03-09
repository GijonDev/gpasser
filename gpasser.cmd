@echo off
pushd & color & title gpasser


if NOT [%1]==[] set "target=%1"


if NOT DEFINED target set /p "target=Select exe target:" & goto mashMD5
echo Select exe target:%target%
goto mashMD5

:mashMD5
echo Working...
CertUtil -hashfile %target% MD5
echo %random%-%processor_revision%-%processor_level%-%random%>>%target%
CertUtil -hashfile %target% MD5
Ren %target% %processor_revision%%RANDOM%%errorlevel%%RANDOM%%highestnumanodenumber%%RANDOM%%processor_level%%RANDOM%.exe"
echo Done. & echo.
pause & exit
