@echo off
echo This will install Group Policy editor (gpedit.msc) and Local Security Policy (secpol.msc)

net session >nul 2>&1
if %errorLevel% == 0 (

  echo This file is intended for use on Windows 10 Home edition only.

  echo Press any key to continue or Ctrl+C to exit.
  pause > nul

  pushd "%~dp0" 

  dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum > Install-GPEdit.txt 
  dir /b %SystemRoot%\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >> Install-GPEdit.txt 

  for /f %%i in ('findstr /i . Install-GPEdit.txt 2^>nul') do (
    dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i" 
  )

  pushd "%~dp0" 

  del /Q Install-GPEdit.txt

  echo Press any key to exit.

  pause > nul

) else (
  echo -------------------------------
  echo Run this file As Administrator!
  echo -------------------------------
  echo Press any key to exit.
  pause > nul
)
