Param(
    [string]$puppetcodeDir
)
$puppetfilecontent=Get-Content -Path "$($puppetcodeDir)/Puppetfile"
$modules=[regex]::Matches($puppetfilecontent,"mod '(?<module>\w+-\w+)',\s'(?<version>[\d\.]{1,})'").captures
foreach ($module in $modules) {
    Write-Host Installing Module $module.groups['module'].value
    &puppet module install --version $module.groups['version'].value $module.groups['module'].value --target-dir "$($puppetcodeDir)/modules"
}
