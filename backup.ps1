if (-not (Test-Path -Path .\settings.json -PathType Leaf)) {
    Write-Host "settings.json not found"
    exit 1
}

$platform = [environment]::OSVersion.Platform
$curDir = $pwd
$zip = "$curDir\\zip.exe"
$outDir = ".\\"
if ($platform -eq "Unix") {
	$zip = "zip"
    $outDir = "./"
}
$sources = Get-Content .\settings.json -Raw | ConvertFrom-Json 

Write-Host "Backup (os: ${platform})"

ForEach ($source in $sources) {
    Write-Host "Compressing $($source.name)..."
    cd "$($source.path)"
    Invoke-Expression "${zip} -$($source.compression)r '$($source.outputZip)' $outDir"
}

cd "$curDir"
Write-Host "Done!"
