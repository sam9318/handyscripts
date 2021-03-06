#Script to Ping IPs in batches and dump output 

$servers = Get-Content C:\ips.txt
$collection = $()
foreach ($server in $servers)
{
    $status = @{"DateofChecking" = (Get-Date -f s);"IPs_in_Scope" = $server }
    if (Test-Connection $server -Count 1 -ea 0 -Quiet)
    { 
        $status["Results"] = "Up"
    } 
    else 
    { 
        $status["Results"] = "Down" 
    }
    New-Object -TypeName PSObject -Property $status -OutVariable serverStatus
    $collection += $serverStatus

}
$collection | Export-Csv C:\output.csv -NoTypeInformation
