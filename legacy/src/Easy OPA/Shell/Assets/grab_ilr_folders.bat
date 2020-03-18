@echo off

rem this works for me...
rem to make it work for you, you will need to 'fix' the source folder lists

rem i'm built from SIX asset source folders in the ILR{year} repository
set common=..\..\..\..\..\..\ILR1718\source\ILR\Common
set artifacts=..\..\..\..\..\..\ILR1718\source\ILR.BinaryTask\Artifacts
set submission=..\..\..\..\..\..\ILR1718\source\ILR\Process Submission

set common18=..\..\..\..\..\..\ILR1819\source\ILR\Common
set artifacts18=..\..\..\..\..\..\ILR1819\source\ILR.BinaryTask\Artifacts
set submission18=..\..\..\..\..\..\ILR1819\source\ILR\Process Submission

echo %common%
echo %artifacts%
echo %submission%

if not exist "%common%\%NUL%" (
	echo The Common folder is missing, nothing to do
	pause
	exit 1
)

if not exist "%artifacts%\%NUL%" (
	echo The Artifacts folder is missing, nothing to do
	pause
	exit 1
)

if not exist "%submission%\%NUL%" (
	echo The Process Submission folder is missing, nothing to do
	pause
	exit 1
)

if not exist "%common18%\%NUL%" (
	echo The Common (1819) folder is missing, nothing to do
	pause
	exit 1
)

if not exist "%artifacts18%\%NUL%" (
	echo The Artifacts (1819) folder is missing, nothing to do
	pause
	exit 1
)

if not exist "%submission18%\%NUL%" (
	echo The Process Submission (1819) folder is missing, nothing to do
	pause
	exit 1
)

mkdir 1718\Common
mkdir 1718\Artifacts
mkdir "1718\Process Submission"
xcopy /s /q "%common%" 1718\Common
xcopy /s /q "%artifacts%" 1718\Artifacts
xcopy /s /q "%submission%" "1718\Process Submission"

mkdir 1819\Common
mkdir 1819\Artifacts
mkdir "1819\Process Submission"
xcopy /s /q "%common18%" 1819\Common
xcopy /s /q "%artifacts18%" 1819\Artifacts
xcopy /s /q "%submission18%" "1819\Process Submission"

cd %~dp0\1718
call align_common_to_wrapper.bat

cd ..
cd %~dp0\1819
call align_common_to_wrapper.bat

pause