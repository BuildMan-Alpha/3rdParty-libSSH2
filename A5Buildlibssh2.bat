@echo off
REM 
REM Build instructions for a new version of libssh2.
REM
REM 1. Download the zip file for the latest build.
REM 2. Unzip the file under c:\Dev\3rdParty\libssh2\x.x.x.x\.
REM	Note: Create the version folder (currently 1.9.0.0)
REM 3. Move all of the files in libssh2-master up one level to simplify the path.
REM 4. Update the environment variable in SetBuildEnvironment.bat for A5LIBSSH2 to reflect the new version.
REM 5. Do a complete rebuild.
REM 6. Add the contents of the new version folder to CVS and commit.

REM SPECIAL NOTE =============================================================================
REM SPECIAL NOTE =============================================================================
REM 
REM When using mbedTLS there is a bug in the file cmake\FindmbedTLS.cmake on Windows
REM that may or may not still need to be fixed.
REM 
REM Replace the line that is commented below with the line that follows it.
REM #    SET(MBEDTLS_LIBRARIES "-L${MBEDTLS_LIBRARY_DIR} -l${MBEDTLS_LIBRARY_FILE} -l${MBEDX509_LIBRARY_FILE} -l${MBEDCRYPTO_LIBRARY_FILE}")
REM      SET(MBEDTLS_LIBRARIES "mbedtls.lib;mbedx509.lib;mbedcrypto.lib")
REM
REM SPECIAL NOTE =============================================================================
REM SPECIAL NOTE =============================================================================

if '%1' == '' goto usage
if '%2' == '' goto usage

SET CMAKECMD=c:\dev\3rdparty\cmake\3.21.4\bin\cmake.exe
SET LIBSSH2VERSION=%1
SET COMPILERVERSIONNUMBER=%2
SET COMPILERVERSION=VS%2

SET LIBSSHPLATFORM=v141
if '%COMPILERVERSIONNUMBER%' == '15' SET COMPILERYEAR=2017
if '%COMPILERVERSIONNUMBER%' == '15' SET LIBSSHPLATFORM=v141
if '%COMPILERVERSIONNUMBER%' == '16' SET COMPILERYEAR=2019
if '%COMPILERVERSIONNUMBER%' == '16' SET LIBSSHPLATFORM=v142
if '%COMPILERVERSIONNUMBER%' == '17' SET COMPILERYEAR=2022
if '%COMPILERVERSIONNUMBER%' == '17' SET LIBSSHPLATFORM=v143

echo libssh2 Version %LIBSSH2VERSION%
echo Compiler Version %COMPILERVERSION% %COMPILERVERSIONNUMBER%
echo Platform Library %LIBSSHPLATFORM%
echo OpenSSL Path %A5OpenSSL%

cd \dev\a5v12\src
call SetBuildEnvironment.bat
echo Setting compiler version to %COMPILERVERSION%
call SetCompilerEnvironment.bat %COMPILERVERSION%
SET VCToolsVersion=

SET CRYPTOPARM=-DCRYPTO_BACKEND=OpenSSL
SET PARM=-DOPENSSL_ROOT_DIR=%A5OPENSSL% -DOPENSSL_LIBRARIES=%A5OPENSSL%/out32dll/%A5COMPILERVERSION%
SET PARM=%PARM% -DBUILD_EXAMPLES=OFF -DBUILD_TESTING=OFF
SET GPARM=Visual Studio %COMPILERVERSIONNUMBER% %COMPILERYEAR%

SET LIBSSH2VERSIONPATH=c:\dev\3rdParty\libssh2\%LIBSSH2VERSION%
SET LIBSSH2BUILDPATH=%LIBSSH2VERSIONPATH%\build\%A5COMPILERVERSION%

echo Cleaning up.
echo Removing build directory %LibSSH2BuildPath%
echo Y | rmdir %LibSSH2BuildPath% /s
md %LibSSH2BuildPath%
cd %LibSSH2BuildPath%

mkdir dll 
%CMAKECMD% %CRYPTOPARM% %PARM% -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=./dll -G "%GPARM%" -A Win32 ..\..

ECHO CMake done.  

ECHO Starting Release build
MSbuild.exe /m /p:UseEnv=true;PlatformToolset=%LIBSSHPLATFORM%;Platform=Win32;buildProjectReferences=false;Configuration="Release";ProcessorArchitecture=x86 src\libssh2_shared.vcxproj

ECHO Starting Debug build
MSbuild.exe /m /p:UseEnv=true;PlatformToolset=%LIBSSHPLATFORM%;Platform=Win32;buildProjectReferences=false;Configuration="Debug";ProcessorArchitecture=x86 src\libssh2_shared.vcxproj

REM %CMAKECMD% -G "%GPARM%" -A Win32 --build . --target install

cd %LIBSSH2VERSIONPATH%

echo a | xcopy %LIBSSH2BUILDPATH%\src\Debug\libssh2.* 	%LIBSSH2VERSIONPATH%\dll\%A5OPENSSLVER%\%A5COMPILERVERSION%\Debug\libssh2.* /s /d
echo a | xcopy %LIBSSH2BUILDPATH%\src\Release\libssh2.* %LIBSSH2VERSIONPATH%\dll\%A5OPENSSLVER%\%A5COMPILERVERSION%\Release\libssh2.* /s /d
echo a | xcopy %LIBSSH2VERSIONPATH%\include\*.*		%LIBSSH2VERSIONPATH%\dll\%A5OPENSSLVER%\%A5COMPILERVERSION%\include\*.* /s /d
echo a | xcopy %LIBSSH2BUILDPATH%\src\*.h		%LIBSSH2VERSIONPATH%\dll\%A5OPENSSLVER%\%A5COMPILERVERSION%\include\*.* /s /d

cd c:\dev\3rdParty\libssh2\
goto done 

:usage

echo Usage: %0 Version CompilerVersionNumber
echo For example:  %0 1.10.0.0 17

:done

