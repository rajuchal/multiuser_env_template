$projectName = Read-Host -Prompt "Enter the some project/Resource Group name"
$templateFile = Read-Host -Prompt "Enter the full path of template file location"
$parameterFile = Read-Host -Prompt "Enter the full path of parameter file location"
$noOfUsers = Read-Host -Prompt "Enter the number of Users"
$resourceGroupName = "${projectName}_rg"

New-AzResourceGroup -Name $resourceGroupName -Location "East US"

New-AzResourceGroupDeployment `
	-ResourceGroupName $resourceGroupName `
	-TemplateFile $templateFile `
	-TemplateParameterFile $parameterFile `
	-no_of_win_vm $noOfUsers `
	-no_of_linux_vm $noOfUsers `
	-Verbose
