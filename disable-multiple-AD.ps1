Import-Module activedirectory

$namelist=Import-Csv C:\PortalDisableFinal.csv

foreach($name in $namelist){Disable-ADAccount -Identity $name.samaccount }