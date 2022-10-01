if (-not (Test-Path -Path .\settings.json -PathType Leaf)) {
    Write-Host "settings.json not found"
    exit 1
}

$platform = [environment]::OSVersion.Platform
$zip = "zip.exe"
if ($platform = "Unix") {
	$zip = "zip"
}
$sources = Get-Content .\settings.json -Raw | ConvertFrom-Json 

ForEach ($source in $sources) {
    Write-Host "Compressing $($source.name)..."
    & $zip -9r $source.outputZip $source.path
}

Write-Host "Done!"
