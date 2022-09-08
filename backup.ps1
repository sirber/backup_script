if (-not (Test-Path -Path .\settings.json -PathType Leaf)) {
    Write-Host "settings.json not found"
    exit 1
}

$sources = Get-Content .\settings.json -Raw | ConvertFrom-Json 

ForEach ($source in $sources) {
    Write-Host "Compressing $($source.name)..."
    Compress-Archive -Path $source.path -DestinationPath $source.outputZip -Force
}

Write-Host "Done!"