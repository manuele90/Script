@echo off

IF NOT EXIST "C:\PCupdater\wsus_log.txt" (
	@echo %date% %time%: Primo avvio del PC dopo applicazione policy wsus>> C:\PCupdater\wsus_log.txt	
	)

IF EXIST "C:\PCupdater\wsus_log.txt" (
	>nul find "Windows Update ID resettato" C:\PCupdater\wsus_log.txt && (
		echo "Hello World" was found.)
		 || (
		echo "Hello World" was NOT found.
		@echo %date% %time%: Windows Update ID resettato>> C:\PCupdater\wsus_log.txt
		)	
	)

	
pause
