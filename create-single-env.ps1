$projectName = Read-Host -Prompt "Enter the same project name"
$adminUsername = Read-Host -Prompt "Enter the administrator User name"
$adminPassword = Read-Host -Prompt "Enter the administrator password" -AsSecureString
$templateFile = Read-Host -Prompt "Enter the full path of template file location"
$resourceGroupName = "${projectName}_rg"

New-AzResourceGroup -Name $resourceGroupName -Location "East US"

New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile -adminUsername $adminUsername -adminPassword $adminPassword -Verbose