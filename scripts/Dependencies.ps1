param (
    [string]
    $Repository = 'PSGallery'
)

# Runtime Modules
$data = Import-PowerShellDataFile -Path "$PSScriptRoot/../src/AzOps.psd1"
Write-Host "Installing runtime modules"
foreach ($dependency in $data.RequiredModules) {
    Install-Module -Name $dependency.ModuleName -RequiredVersion $dependency.RequiredVersion -Repository $Repository -Force
}

# Development Modules
$modules = @("Pester", "PSModuleDevelopment", "PSScriptAnalyzer")
Write-Host "Installing development modules"
foreach ($module in $modules) {
    Install-Module $module -Repository $Repository -Force
}

# List Modules
Get-InstalledModule | Select-Object Name, Version, Repository, InstalledDate | Sort-Object Name | Format-Table