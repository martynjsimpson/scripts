<#
.DESCRIPTION
  Detects OS in a useful way across many version
.PARAMETER <Parameter_Name>
    None
.INPUTS
  None
.OUTPUTS
  Exit Code 0 = Not installed
  Exit Code 99 = SMB 1 Feature installed
.NOTES
  Version:          1.0
  Author:           Martyn Simpson
  Creation Date:    2021/09/2021
  Supported OS:     
#>

$osMaj = environment]::OSVersion.Version | Select-Object Major -ExpandProperty Major
$osMin = environment]::OSVersion.Version | Select-Object Minor -ExpandProperty Minor


switch ($osMaj) {
    10 { Write-Output "Win 10/ server 2016/ server 2019" }
    6 { 
        switch ($osMin) {
            0 { Write-Output "Vista or Server 2008 SP2" }
            1 { Write-Output "Win 7 or 2008 r2"}
            Default {}
        }
        Write-Output "Win 8, 8.1, 7 server 2012 inc R2," 
    }
    Default { Write-Output "Nope" }
}



If ($ver -eq (new-object 'Version' 6,1)){
    Write-Output "Win 7 / 2008 R2"
}

If ($ver -eq (new-object 'Version' 10,0)){
    Write-Output "Win 10"
}