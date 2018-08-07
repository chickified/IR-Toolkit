@echo off

REM This batch fie is to be executed on a Windows workstation for the means of IR investigations.
REM Please run this batch script with administrative privileges.
REM Nestor Lee
REM Updated: August 7 2018

IF EXIST C:\IR-Logs\ (
REM 	echo The directory already exists. Will not overwrite. Aborting.
REM 	GOTO :EXIT
	rmdir /S /Q C:\IR-Logs\
	mkdir C:\IR-Logs\
) ELSE (
	mkdir C:\IR-Logs\
)

hostname > C:\IR-Logs\hostname.txt
SET /p HOSTNAME= < C:\IR-Logs\hostname.txt



echo Execution Start >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt
time /T >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt
date /T >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt
w32tm /tz >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt



REM --******************** Retrieve Hosts File ********************--
type %systemroot%\system32\drivers\etc\hosts >> C:\IR-Logs\%HOSTNAME%_hosts.txt



REM --******************** Retrieve System Information ********************--
systeminfo /FO LIST >> C:\IR-Logs\%HOSTNAME%_systeminfo.txt



REM --******************** Retrieve Network Information ********************--
echo Network Adapters (ipconfig /all) >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
ipconfig /all >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo. >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo DNS Cache (ipconfig /displaydns) >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
ipconfig /displaydns >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo. >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo ARP Cache (arp -a) >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
arp -a >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo. >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo Open Ports (netstat -naob) >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
netstat -naob >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt
echo. >> C:\IR-Logs\%HOSTNAME%_networkInformation.txt



REM --******************** Retrieve list of Administrators ********************--
net localgroup administrators >> C:\IR-Logs\%HOSTNAME%_localAdmins.txt



REM --******************** Retrieve list of shares created on the local computer ********************--
net share >> C:\IR-Logs\%HOSTNAME%_localShares.txt



REM --******************** Retrieve list of shares connected to from the local computer ********************--
net use >> C:\IR-Logs\%HOSTNAME%_sharesConnected.txt



REM --******************** Retrieve list of local users ********************--
net user >> C:\IR-Logs\%HOSTNAME%_localUsers.txt



REM --******************** Retrieve list of Services ********************--
echo Net Start >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
net start >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
echo SC QUERYEX >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
sc queryex >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startedServices.txt
echo Tasklist Verbose >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
tasklist /V >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo. >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo Tasklist Modules >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
tasklist /M >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo. >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo Tasklist Services >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
tasklist /SVC >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
echo. >> C:\IR-Logs\%HOSTNAME%_tasklist.txt
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_runningServices.txt" service where State="Running" list full
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_allServices.txt" service list full



REM --******************** Retrieve Startup Items ********************--
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_startup.txt" startup list full
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo DIR Startup Current user >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
dir "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo DIR Startup Machine >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
dir "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup" >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKLM RUN >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hklm\software\microsoft\windows\currentversion\run >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKLM RUNONCE >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hklm\software\microsoft\windows\currentversion\runonce >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKCU RUN >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hkcu\software\microsoft\windows\currentversion\run >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKCU RUNONCE >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hkcu\software\microsoft\windows\currentversion\runonce >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKLM RUN WOW6432NODE >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hklm\software\wow6432node\microsoft\windows\currentversion\run >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKLM RUNONCE WOW6432NODE >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hklm\software\wow6432node\microsoft\windows\currentversion\runonce >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKCU RUN WOW6432NODE >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hkcu\software\wow6432node\microsoft\windows\currentversion\run >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo HKCU RUNONCE WOW6432NODE >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo ================ >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
reg query hkcu\software\wow6432node\microsoft\windows\currentversion\runonce >> C:\IR-Logs\%HOSTNAME%_startupItems.txt
echo. >> C:\IR-Logs\%HOSTNAME%_startupItems.txt



REM --******************** Retrieve list of installed items ********************--
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_installedProducts.txt" product list full  



REM --******************** Retrieve list of installed drivers ********************--
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_installedDrivers.txt" sysdriver list full 



REM --******************** Retrieve list of Logon sessions ********************--
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_logonSessions.txt" logon list full



REM --******************** Retrieve diskdrive information ********************--
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_diskDrive.txt" diskdrive list full



REM --******************** Retrieve OS Information ********************--
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_OSInformation.txt" os get BootDevice, CSName, EncryptionLevel, InstallDate, LastBootUpTime, Name, Version, BuildNumber, CSDVersion /format:list



REM --******************** Retrieve Logical Disk Information ********************--
REM VALUE MEANING
REM   0   Unknown
REM   1   No root directory
REM   2   Removable Disk
REM   3   Local Disk
REM   4   Network drive
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_logicalDriveType1.txt" logicaldisk where drivetype=1 list full /format:list
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_logicalDriveType2.txt" logicaldisk where drivetype=2 list full /format:list
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_logicalDriveType3.txt" logicaldisk where drivetype=3 list full /format:list
wmic /OUTPUT:"C:\IR-Logs\%HOSTNAME%_wmic_logicalDriveType4.txt" logicaldisk where drivetype=4 list full /format:list


REM --******************** Retrieve Scheduled Tasks ********************--
schtasks /Query /V /FO LIST >> C:\IR-Logs\%HOSTNAME%_scheduledTasks.txt



REM --******************** Retrieve Hidden Files & Directories ********************--
dir /s /b /a:h C:\ >> C:\IR-Logs\%HOSTNAME%_hiddenFilesAndDirectories.txt



REM --******************** Retrieve Event Logs ********************--
wevtutil qe System /format:text >> C:\IR-Logs\%HOSTNAME%_systemEventLogs.txt
wevtutil qe Application /format:text >> C:\IR-Logs\%HOSTNAME%_ApplicationEventLogs.txt
wevtutil qe Security /format:text >> C:\IR-Logs\%HOSTNAME%_securityEventLogs.txt



echo. >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt
echo Execution Complete >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt
time /T >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt
date /T >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt
w32tm /tz >> C:\IR-Logs\%HOSTNAME%_timeOfScriptExecution.txt



REM --******************** Zip Folder ********************--
mkdir C:\IR-Logs\ZIP
powershell -Command Compress-Archive -LiteralPath C:\IR-Logs -CompressionLevel Optimal -DestinationPath C:\IR-Logs\ZIP\%HOSTNAME%_IR-Logs.zip



REM --******************** Retrieve a SHA256 Hash of Zipped Folder ********************--
powershell -Command "Get-FileHash -Path C:\IR-Logs\ZIP\%HOSTNAME%_IR-Logs.zip | Format-List" >> C:\IR-Logs\ZIP\%HOSTNAME%_Logs_SHA256.txt



:EXIT
cls
echo.
echo Execution Complete. 
pause