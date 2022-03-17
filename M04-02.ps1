

# 03/16/2022 11:52 pm - SSN - [20220316-2352] - [001] - M04-02 - Verifying self-hosted agent requirements


function step1 {

    Get-CimInstance win32_computersystem | select caption

    Get-CimInstance Win32_OperatingSystem | select caption

}



function step2 { 

    # https://github.com/microsoft/azure-pipelines-agent/tree/master/docs/start

    # envwin.md

    $org = "samniyazi"
    $uri = "https://dev.azure.com/$org"

 

    Invoke-WebRequest -uri $uri | Select-Object statuscode


}


step1 | Out-Host
step2 | Out-Host