@echo off
REM call with path to LabVIEW-CLI. No parameter will run the installed CLI.

SET common_params="--kill"
SET delay_between_tests=3000
SET labview_cli_cmd="%1labview-cli"

SET test_name="Echo Parameters VI"
"%labview_cli_cmd%" %common_params% "Echo Parameters.vi" -- "Param 1" "Param 2" | find "Param 1	Param 2" || goto :failed
ping 127.0.0.1 -n1 -w %delay_between_tests% >NUL 

SET test_name="Large Output VI"
"%labview_cli_cmd%" %common_params% "Generate Large Output.vi" -- 10000 || goto :failed
ping 127.0.0.1 -n1 -w %delay_between_tests% >NUL 

SET test_name="Quit With Code VI"
"%labview_cli_cmd%" %common_params% "Quit With Parameter Code.vi" -- 10000
if %errorlevel% NEQ 10000 goto :failed
ping 127.0.0.1 -n1 -w %delay_between_tests% >NUL 

SET test_name="Quit With Negative Code VI"
"%labview_cli_cmd%" %common_params% "Quit With Parameter Code.vi" -- -10000
if %errorlevel% NEQ -10000 goto :failed
ping 127.0.0.1 -n1 -w %delay_between_tests% >NUL 


SET test_name="Echo Parameters EXE"
"%labview_cli_cmd%" %common_params% ".\exes\Echo CLI.exe" -- "Param 1" "Param 2" | find "Param 1	Param 2" || goto :failed
ping 127.0.0.1 -n1 -w %delay_between_tests% >NUL 

SET test_name="Large Output EXE"
"%labview_cli_cmd%" %common_params% ".\exes\LargeOutput.exe" -- 10000 || goto :failed
ping 127.0.0.1 -n1 -w %delay_between_tests% >NUL 

SET test_name="Quit With Code EXE"
"%labview_cli_cmd%" %common_params% ".\exes\QuitWithCode.exe" -- 10000
ping 127.0.0.1 -n1 -w %delay_between_tests% >NUL 


echo "All Tests Completed Successfully"
EXIT

:failed
echo "Test Failed: %test_name%"
EXIT 0

