Function Out-GVim {
    $input | Out-String -Width 1000 | gvim -
}

Function Exclude-SvnItem {
    param([System.IO.FileInfo]$item)

    Push-Location
    Set-Location $item.Directory.FullName
    svn update --set-depth=exclude $item.Name
    Pop-Location
}

Function Import-ModuleForce {
    param([Parameter(Mandatory = $true)][string[]]$Name)

    $PSBoundParameters.Force = $true
    Import-Module @PSBoundParameters
}

Function Get-ChildItemName {
    param(
        [string[]]$Path,
        [string]$Filter,
        [string[]]$Exclude,
        [Switch]$Force,
        [string[]]$Include,
        [Switch]$UseTransaction
    )

    $PSBoundParameters.Name = $True
    $PSBoundParameters.Recurse = $True
    Get-ChildItem @PSBoundParameters
}

Set-Alias imf Import-ModuleForce
Set-Alias open Invoke-Item
Set-Alias find Get-ChildItemName

# PSCX
Import-Module Pscx
$Pscx:Preferences['TextEditor'] = $env:EDITOR
$Pscx:Preferences['CD_EchoNewLocation'] = $false
$Pscx:Preferences['PageHelpUsingLess'] = $false
