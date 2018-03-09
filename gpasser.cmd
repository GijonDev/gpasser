@echo off
pushd & color & title gpasser
set /p "target=Select exe target:"
echo Working...
CertUtil -hashfile %target% MD5
echo %random%-%processor_revision%-%processor_level%-%random%>>%target%
CertUtil -hashfile %target% MD5
Ren %target% %processor_revision%%RANDOM%%errorlevel%%RANDOM%%highestnumanodenumber%%RANDOM%%processor_level%%RANDOM%.exe"
echo Done.
pause
