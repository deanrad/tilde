Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Import-Module z
$host.ui.RawUI.WindowTitle = "All your Windows..."
function gs {git status}
function gb {git branch}
function gcd ($b) { git checkout $b }
function gcm ($m) { git commit -m $m }
function gad { git add . }
function nrun ($s) { npm run $s }
function ntest { npm test }
function cdrotary { cd ~\src\rotary-site-my-rotary\sites\all\modules\custom\rotary_donate_widget\js}
function termtitle ($t) { $host.ui.RawUI.WindowTitle = $t }
function gwip { git add .; git commit -m WIP --no-verify}
function grhc { git reset HEAD^ }
function grhh { git reset --hard HEAD }
function gpull { git pull }
function gpush { git push }

