﻿<#
Get-ProcsWMICmdLineStack.ps1

Pulls frequency of processes based on path CommandLine

Requires:
Process data matching *ProcWMI.tsv in pwd
logparser.exe in path
#>

if (Get-Command logparser.exe) {
    $lpquery = @"
    SELECT
        COUNT(CommandLine) as ct,
        CommandLine
    FROM
        *ProcsWMI.tsv
    GROUP BY
        CommandLine
    ORDER BY
        ct ASC
"@

    & logparser -i:tsv -dtlines:0 -fixedsep:on -rtp:50 "$lpquery"

} else {
    $ScriptName = [System.IO.Path]::GetFileName($MyInvocation.ScriptName)
    "${ScriptName} requires logparser.exe in the path."
}