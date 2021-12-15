<#
.DESCRIPTION
  Get's the status of SMB1 Protocol
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
  Supported OS:     Windows 8.1, Windows 10
#>
$var = Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol | Select State -ExpandProperty State
if ( $var -Like 'Disabled')
{
    Write-Output "Ok"
    exit 0
} else {
  Write-Output "SMB1 is installed"
    exit 99
}