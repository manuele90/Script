@echo off
IF NOT EXIST "C:\Program Files\Java\jre1.8.0_102" (
	IF NOT EXIST "C:\Program Files (x86)\Java\jre1.8.0_102" (
		mkdir C:\temp\Java
		copy \\10.1.1.9\netlogon\updater\java\*.* c:\temp\java\
		c:\temp\java\java.exe INSTALLCFG=C:\temp\java\java_config
		)
	)