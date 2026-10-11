@echo off
title SafeConvos - Threat Intelligence Cleaner
color 0A
echo ===================================================
echo     SafeConvos Threat Intelligence Cleaner
echo ===================================================
echo.
echo Wiping all past entries from Serverpod Cloud...
echo.
pushd D:\edgeguard\edgeguard_admin
call dart run bin\clean_threat_dashboard.dart
popd
echo ===================================================
echo Press any key to close this window.
pause >nul
