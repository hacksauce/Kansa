﻿<#
Get-NetstatDistinctLocal24.ps1
Requires logparser.exe in path
Pulls distinct /24 local network addresses. Useful for building the 
filter for local addresses in other analysis scripts, so you can see
what hosts are communicating to hosts outside your environment.

This script exepcts files matching the pattern 
*netstat.tsv to be in the current working
directory
#>

if (Get-Command logparser.exe) {

    $lpquery = @"
    SELECT
        Distinct substr(ForeignAddress, 0, last_index_of(ForeignAddress, '.')) as IP/24,
    FROM
        *netstat.tsv
    ORDER BY
        Local/24
"@

    & logparser -i:tsv -fixedsep:on -dtlines:0 -rtp:-1 $lpquery

} else {
    $ScriptName = [System.IO.Path]::GetFileName($MyInvocation.ScriptName)
    "${ScriptName} requires logparser.exe in the path."
}