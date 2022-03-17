
# 03/17/2022 12:52 am - SSN - [20220317-0052] - [001] - M04-03 - Implementing a Windows self-hosted agent

$downloadedAgentFile = ".\vsts-agent-win-x64-2.200.2.zip"
$localAgentDirectory = "c:\azagent_ps_348"

function step1 {


    $org = "samniyazi"
    $uri = "https://dev.azure.com/$org"

    $uri = "https://vstsagentpackage.azureedge.net/agent/2.200.2/vsts-agent-win-x64-2.200.2.zip"

    Invoke-WebRequest -uri $uri -OutFile  $downloadedAgentFile

}

function step2 {

    new-item -ItemType Directory -path $localAgentDirectory
    Expand-Archive -LiteralPath $downloadedAgentFile -DestinationPath $localAgentDirectory

    Get-ChildItem -Path $localAgentDirectory
}


function step3 {

    # we didn't install as a service
    Write-Host ""
    write-host "List of current services *ssn* and *ps-*" -ForegroundColor Yellow

    get-service -name "*ssn*" | ft -Wrap
    get-service -name "*ps-*" | ft -Wrap

    Write-Host ""


}

step3