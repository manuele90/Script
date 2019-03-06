@echo off
IF %computername% NEQ SEDE146 (
IF %computername% NEQ SEDE083 (
IF %computername% NEQ SEDE084 (
IF %computername% NEQ SEDE090 (
	IF NOT EXIST "C:\Program Files\Microsoft Office\Office14\MSACCESS.EXE" (
		IF NOT EXIST "C:\Program Files (x86)\Microsoft Office\Office14\MSACCESS.EXE" (
			mkdir C:\ITupdater\Access_Runtime
			xcopy /s /y \\10.1.1.9\netlogon\updater\Access_Runtime\*.* c:\ITupdater\Access_Runtime
			c:\ITupdater\Access_Runtime\setup.exe /config c:\ITupdater\Access_Runtime\config.xml
			@echo %date% %time%: MS Access Runtime 2010 Installed>> C:\ITupdater\log.txt
			)
		)
	))))
