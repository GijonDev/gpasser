@echo off
pushd & color & title gpasser[%processor_level%]


if NOT [%1]==[] set "target=%1"


if NOT DEFINED target set /p "target=Select exe target:" & goto mashMD5
echo Select exe target:%target%
goto mashMD5

:mashMD5
echo Working...
certutil -hashfile -v %target%
CertUtil -hashfile %target% MD5
CertUtil -hashfile %target% SHA256
echo %random%-%processor_revision%-%processor_level%-%random%>>%target%
CertUtil -hashfile %target% MD5
CertUtil -hashfile %target% SHA256
Ren %target% %processor_revision%%RANDOM%%errorlevel%%RANDOM%%highestnumanodenumber%%RANDOM%%processor_level%%RANDOM%.exe"
echo Done. & echo.
pause & exit
