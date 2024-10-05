$StoreToDir = "all-certificates"
$CertExtension = "pem"
$InsertLineBreaks = 1

if (Test-Path $StoreToDir) {
    Remove-Item -Path $StoreToDir -Recurse -Force
}
New-Item -Path $StoreToDir -ItemType Directory | Out-Null

Get-ChildItem -Recurse cert: |
    Where-Object { $_ -is [System.Security.Cryptography.X509Certificates.X509Certificate2] -and $_.NotAfter.Date -gt (Get-Date).Date } |
    ForEach-Object {
        Write-Output "$($_.Thumbprint);$($_.GetSerialNumberString());$($_.Archived);$($_.GetExpirationDateString());$($_.EnhancedKeyUsageList);$($_.GetName())"
        $name = "$($_.Thumbprint)--$($_.Subject)" -replace '[\W]', '_'
        $name = $name.Substring(0, [Math]::Min($name.Length, 100))
        $path = Join-Path -Path $StoreToDir -ChildPath "$name.$CertExtension"
        if (Test-Path $path) { return }
        $oPem = New-Object System.Text.StringBuilder
        [void]$oPem.AppendLine("-----BEGIN CERTIFICATE-----")
        [void]$oPem.AppendLine([System.Convert]::ToBase64String($_.RawData, $InsertLineBreaks))
        [void]$oPem.AppendLine("-----END CERTIFICATE-----")
        $oPem.ToString() | Set-Content -Path $path
    }
