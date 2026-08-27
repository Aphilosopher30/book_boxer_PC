@echo off
setlocal

REM Pipeline Runner
REM Runs four scripts in sequence, stopping if any script fails.

echo =========================================
echo  Starting Pipeline
echo =========================================

echo.
echo [1/4] Running export_collections.py...
python export_collections.py
if errorlevel 1 goto :error
echo       Done.

echo.
echo [2/4] Running Tables/combine_csvs.py...
python Tables\combine_csvs.py .\Tables\Raw_Downloads\*.csv --output Tables\all_collections.csv
if errorlevel 1 goto :error
echo       Done.

echo.
echo [3/4] Running Tables/add_photo_column.py...
python Tables\add_photo_column.py --csv Tables\all_collections.csv --folder .\Tables\photos
if errorlevel 1 goto :error
echo       Done.

echo.
echo [4/4] Deleting all raw downloads...
del /Q ".\Tables\Raw_Downloads\*"
if errorlevel 1 goto :error
echo       Done.

echo.
echo =========================================
echo  Pipeline complete!
echo =========================================
goto :end

:error
echo.
echo =========================================
echo  Pipeline FAILED!
echo =========================================
exit /b 1

:end
endlocal
