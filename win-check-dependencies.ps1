# 检查 Windows 依赖
$dependencies = @("git", "make", "curl", "gcc")

Write-Host "`n温馨提示: 如果您追求更好的nvim体验, 您可以使用wsl (建议arch 因为软件包永远是最新的)"

# 检查包管理器
$packageManager = $null
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    $packageManager = "scoop"
} elseif (Get-Command choco -ErrorAction SilentlyContinue) {
    $packageManager = "choco"
} elseif (Get-Command winget -ErrorAction SilentlyContinue) {
    $packageManager = "winget"
}

if (-not $packageManager) {
    Write-Host "❌ 需要 Scoop 或 Chocolatey 或 Winget 包管理器" -ForegroundColor Red
    Write-Host "安装 Scoop(推荐包管理):"
    Write-Host "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
    $choice = Read-Host "是否安装？(默认回车安装)[Y/n]"

    if ($choice -eq "y" -or $choice -eq "Y" -or $choice -eq "") {
        Write-Host "`n正在安装 Scoop..." -ForegroundColor Green
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
        $packageManager = "scoop"
    } elseif ($choice -eq "n", -or $choice -eq "N") {
        Write-Host "安装已取消"
        exit 1
    }
    exit 1
}

# 重新检测包管理器安装结果
if (-not $packageManager) {
    Write-Host "`n⚠️ 包管理器安装失败，请手动安装后重新运行脚本" -ForegroundColor Red
    exit 1
}

$missing = @()

Write-Host "正在检查 Windows 依赖..." -ForegroundColor Yellow

foreach ($dep in $dependencies) {
    if (Get-Command $dep -ErrorAction SilentlyContinue) {
        Write-Host "✓ $dep 已安装" -ForegroundColor Green
    } else {
        Write-Host "✗ $dep 未安装" -ForegroundColor Red
        $missing += $dep
    }
}

if ($missing.Count -gt 0) {
    Write-Host "`n需要安装以下依赖：" -ForegroundColor Yellow
    foreach ($item in $missing) {
        switch ($packageManager) {
            "scoop" { 
                # 处理特殊包名
                $package = switch ($item) {
                    "gcc" { "mingw" }
                    default { $item }
                }
                Write-Host "scoop install $package -y" 
            }
            "choco" { Write-Host "choco install $item -y --confirm" }
            "winget" { Write-Host "winget install --id $item --accept-package-agreements" }
        }
    }
    
    # 管理员权限提醒
    if ($packageManager -eq "choco") {
        Write-Host "`n⚠️ Chocolatey 需要管理员权限，请以管理员身份运行 PowerShell 后执行上述命令" -ForegroundColor Red
    }
} else {
    Write-Host "`n✅ 所有依赖已安装，准备就绪！" -ForegroundColor Green
}
