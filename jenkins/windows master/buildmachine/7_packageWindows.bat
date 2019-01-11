@echo off


::set params
set VERSION=%1
set ARCHIVE_NAME="InstantWarWindows_%VERSION%.zip"
set ZIP_PATH="%~dp0\..\engine\Build\Windows\7z\7z.exe"
set RSYNC="%~dp0\..\sync\rsync.exe"
set BACKUP_USER=atomic
set BACKUP_PASSWORD=Buro_12
set BACKUP_HOST=192.168.1.10
set BACKUP_FOLDER=%2

echo start AtomicPlayer.exe --player --host 31.13.198.161 > "%~dp0\..\..\Build\Windows-Build\start.bat"

%ZIP_PATH% a -tzip -mx5 -r "%~dp0\..\..\Build\%ARCHIVE_NAME%" "%~dp0\..\..\Build\Windows-Build\*.*"

:: copy to backup for archive
pushd "%~dp0\..\..\Build"
set RSYNC_PASSWORD=%BACKUP_PASSWORD%
%RSYNC% -avz --progress ./%ARCHIVE_NAME% %BACKUP_USER%@%BACKUP_HOST%::%BACKUP_FOLDER%
popd
