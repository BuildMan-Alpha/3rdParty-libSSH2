REM @echo off
REM 
REM Invoke A5BuildLibSSH2.bat for all compilers
REM 
REM Note:  The OpenSSL version must be updated in c:\dev\a5v12\srsc\SetBuildEnvironment.bat before each run to build multiple versions of OpenSSL
REM

if '%1' == '' goto usage

cd c:\dev\3rdParty\libssh2
call A5BuildLibSSH2.bat %1 15

cd c:\dev\3rdParty\libssh2
call A5BuildLibSSH2.bat %1 16

cd c:\dev\3rdParty\libssh2
call A5BuildLibSSH2.bat %1 17

cd c:\dev\3rdParty\libssh2

goto done 

:usage

echo Usage: %0 Version
echo For example:  %0 1.11.0

:done

