@echo off
FOR /F "tokens=* USEBACKQ" %%F IN (`netsh wlan show profile`) DO (
	IF "%%F" NEQ "<None>" (
		echo.%%F | findstr /C:"Profile " > nul && (
			FOR /F "tokens=1,* delims=:" %%I IN ("%%F") DO (
				FOR /F "tokens=* delims= " %%A IN ("%%J") DO (
					IF "%~1" NEQ "" (
						echo SSID: %%A >> "%~1"
						netsh wlan show profile name="%%A" key=clear | findstr Key >> "%~1"
					) ELSE (
						echo SSID: %%A
						netsh wlan show profile name="%%A" key=clear | findstr Key
					)
				)
			)
		)
	)
)

IF "%~1" EQU "" (
	echo.
	echo Press any key to continue...
	ping localhost -n 1.1>nul
	pause>nul
)