function Exit-Shell { exit }

Set-Alias -Name q -Value Exit-Shell
Set-Alias -Name lg -Value lazygit
Set-Alias -Name n -Value nvim.exe
Set-Alias -Name so -Value refreshenv.exe
# Import-Module -Name Terminal-Icons
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode vi
Remove-Alias r

$env:PATH += ";C:\Program Files\Ablaze Floorp"


