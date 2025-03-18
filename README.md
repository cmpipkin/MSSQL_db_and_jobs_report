# MSSQL db and jobs report
### objective
generate a reports consisting of databases their sizes, owner, backup date, and file path, and any scheduled jobs and maintenance plans created with SSIS (SQL Server Integration Services).
## required powershell modules
SQLServer, ImportExcel
## usage
run *.\mssql_db_and_jobs_report -serverName \<servername\>* in powershell.
### options
*-servername* - the name of the server hosting MSSQL
*-excelFileName* - the name of the exproted Excel document.
## things to note
- There isn't an variable for the save directory. This script will exprot the excel file in the direcotry it is ran from.
- You will get errors using this script is SSIS is not installed on your MSSQL server.
