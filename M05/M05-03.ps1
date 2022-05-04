

# 03/17/2022 03:27 am - SSN - [20220317-0320] - [001] - M05-03 - Implementing a self-hosted agent using Docker
# 03/17/2022 12:48 pm - SSN - Using variable from automation account.  Tested OK.

param (
    $option
)

$ErrorActionPreference = "stop"


if ( $null -eq $env:vsts_token) {
    write-error "Missing vsts_token"
}





. C:\Sams\PS\Email\SendGrid_Util.ps1


$aan = "SSN-AA-GUI-20190322" 
$rgn = "default-web-centralus"


Remove-Variable obj -ErrorAction SilentlyContinue

# $obj = @{

#     url = "https://dev.azure.com/samniyazi"
#     agent = "azagent-ps-348-windows-container"
#     pool = "ps-348-agentpool-windows-container-20220317"
#     dockerImageName = "ps-348-dockeragent-windows"

# }  



# Tested OK
#new--variable -rgn $rgn -aan $aan -variableName "ps-348-AzureDevOpsAgentPool-20220317" -variableValue $obj 


Remove-Variable -ErrorAction SilentlyContinue   obj2
Remove-Variable -ErrorAction SilentlyContinue   url
Remove-Variable -ErrorAction SilentlyContinue   agent
Remove-Variable -ErrorAction SilentlyContinue   pool
Remove-Variable -ErrorAction SilentlyContinue   dockerImageName


$obj2 = Get--variable -rgn $rgn -aan $aan -variableName "ps-348-AzureDevOpsAgentPool-20220317"

$url = $obj2.url
$agent = $obj2.agent  
$pool = $obj2.pool  
$dockerImageName = $obj2.dockerImageName  

write-host ""
write-host "            url:  $url"
write-host "          agent:  $agent"
write-host "           pool:  $pool"
write-host "dockerImageName:  $dockerImageName"
write-host ""


function step1-createImage {
    
    docker image list  
    docker build  -t ps-348-dockeragent-windows:latest .
    docker image list  

}


function step2-create-self-hosted-agent {
    docker run -e AZP_URL=$url -e AZP_TOKEN=$env:vsts_token -e AZP_AGENT_NAME=$agent -e AZP_POOL=$pool $dockerImageName 
}


switch ($option) {

    1 {
        Write-Host "Create docker image..."
        step1-createImage
    }

    2 {
        write-host "Create self-hosted agent..."
        step2-create-self-hosted-agent
    }

    default {

        write-host ""

        write-host "Options:" -ForegroundColor Yellow
        write-host "1) Create Windows Docker image" -ForegroundColor Yellow
        write-host "2) Create self-hosted agent" -ForegroundColor Yellow

    }
}



# Starting from the command prompt with option 2:
 
# Option 2 results:


# C:\Sams_P\PS\microsoft-azure-implement-\WorkProject_T1\M04\M05>pwsh .\M05-03.ps1 2
# notepad $PROFILE.AllUsersAllHosts
# notepad C:\Program Files\PowerShell\7\profile.ps1
# notepad $profile:
# notepad C:\Users\sam20\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
# Create self-hosted agent...
# 1. Determining matching Azure Pipelines agent...
# https://vstsagentpackage.azureedge.net/agent/2.200.2/vsts-agent-win-x64-2.200.2.zip
# 2. Downloading and installing Azure Pipelines agent...
# 3. Configuring Azure Pipelines agent...

#   ___                      ______ _            _ _
#  / _ \                     | ___ (_)          | (_)
# / /_\ \_____   _ _ __ ___  | |_/ /_ _ __   ___| |_ _ __   ___  ___
# |  _  |_  / | | | '__/ _ \ |  __/| | '_ \ / _ \ | | '_ \ / _ \/ __|
# | | | |/ /| |_| | | |  __/ | |   | | |_) |  __/ | | | | |  __/\__ \
# \_| |_/___|\__,_|_|  \___| \_|   |_| .__/ \___|_|_|_| |_|\___||___/
#                                    | |
#         agent v2.200.2             |_|          (commit 2ebaa3d)


# >> Connect:

# Connecting to server ...

# >> Register Agent:

# Scanning for tool capabilities.
# Connecting to the server.
# Successfully added the agent
# Testing agent connection.
# 2022-03-17 09:51:44Z: Settings Saved.
# 4. Running Azure Pipelines agent...
# Scanning for tool capabilities.
# Connecting to the server.
# 2022-03-17 09:52:02Z: Listening for Jobs





# Created a pipeline SamNiyazi2.ps-348-AzureDevOps-implement-manage-pipelines
# Basic script echoing a single line during build.
# Tested OK.
