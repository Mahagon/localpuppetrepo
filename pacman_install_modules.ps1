$puppetfilecontent=Get-Content -Path /vagrant/puppetcode/Puppetfile
$modules=[regex]::Matches($puppetfilecontent,"mod '(?<module>\w+-\w+)',\s'(?<version>[\d\.]{1,})'").captures
foreach ($module in $modules) {
    &puppet module install --version $module.groups['version'].value $module.groups['module'].value
}
