$envyroot = split-path $(split-path $myinvocation.mycommand.path)
$vimroot = "$envyroot\Dotfiles\vim"

[Environment]::SetEnvironmentVariable("REPOS_ROOT", $(split-path $envyroot), "User")
[Environment]::SetEnvironmentVariable("VIMINIT", "source $($vimroot)\vimrc", "User")
[Environment]::SetEnvironmentVariable("EDITOR", (Get-Command gvim).Definition, "User")

Set-Content $PROFILE ". $($envyroot)\Dotfiles\ps1\PowerShellProfile.ps1"
