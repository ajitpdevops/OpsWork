diruse -M -* .


REM Enable Scheduled Task - 
@echo off
for /F "tokens=1-3 delims=," %%a in (DR_Opti_sch_list.csv) do (
schtasks /change /enable /SD %%c /tn "%%b" /s %%a /RU <domain\username> /RP <password>
)


REM Last Shutdown of the server from CMD 
wevtutil qe system "/q:*[System [(EventID=1074)]]" /rd:true /f:text /c:1 | findstr /i "date"

REM Query whether the service is running or stopped:
SC \\computername Query servicename
REM Query the service startup type, path, display name, dependencies, and etc:
SC \\computername QC servicename
REM Start or stop a service:
SC \\computername Start|Stop servicename
REM Change the service startup type:
SC \\computername Config servicename start= Auto|Demand|Disabled
REM Read More: https://www.raymond.cc/blog/remotely-start-and-stop-applications-or-services-over-the-internet/

services.msc /computer=<servername>

