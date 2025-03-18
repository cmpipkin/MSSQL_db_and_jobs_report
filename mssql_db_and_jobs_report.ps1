##################################################################
# SQL Server Report
# Required PS Modules: SQLServer, ImportExcel
#
# Reports on databases name, owner,size, backup, and location
# Reports on MSSQLs maintenance plans
# Reports on MSSQLs scheduled jobs
##################################################################


# get basic sql database information
param (
    [Parameter(Mandatory)]$serverName,
    [string]$excelFileName = "SQL Report"
)

$date = Get-Date -Format "MM-dd-yyyy"
$path = ".\" + $serverName + " " + $excelFileName + "_" + $date + ".xlsx"

# import modules
Import-Module -Name SqlServer

#create sql smo object
$sqlServer = New-Object Microsoft.SqlServer.Management.Smo.Server("$serverName")

#retrieve database properties
$sqlServer.Databases | Select Name,Owner,Size,LastBackupDate,PrimaryFilePath `
    | Export-Excel -Path $path -WorksheetName "Databases"

#retrieve system jobs
Read-SqlTableData $sqlserver.Databases['msdb'].Tables['sysjobs'] `
    | Select date_created,enabled,name,description,date_modified `
    | Export-Excel -Path $path -WorksheetName "Jobs"

#retrieve system maintenance plans
Read-SqlTableData $sqlserver.Databases['msdb'].Tables['sysssispackages'] `
    | Select date_created,name,description `
    | Export-Excel -Path $path -WorksheetName "Maintenance Plans"
