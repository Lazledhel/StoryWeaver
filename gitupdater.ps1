param(
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Info($msg) { Write-Host $msg }
function Write-Warn($msg) { Write-Warning $msg }
function Write-Fail($msg) { Write-Error $msg }

try {
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    Set-Location $scriptDir

    if (-not (Test-Path ".git")) {
        Write-Fail "No .git directory found. Run this script from the repository root."
        exit 1
    }

    $gitVersion = & git --version 2>$null
    if (-not $gitVersion) {
        Write-Fail "git is not available in PATH."
        exit 1
    }

    $status = & git status --porcelain
    if ($status -and -not $Force) {
        Write-Fail "Working tree is not clean. Commit or stash changes, or re-run with -Force."
        exit 1
    }

    Write-Info "Fetching updates from origin..."
    & git fetch origin --prune --tags

    $originHead = & git symbolic-ref --quiet refs/remotes/origin/HEAD
    if (-not $originHead) {
        Write-Fail "Could not determine origin default branch."
        exit 1
    }

    $remoteRef = $originHead.Trim()
    $branch = $remoteRef -replace "^refs/remotes/origin/", ""

    $localSha = (& git rev-parse HEAD).Trim()
    $remoteSha = (& git rev-parse $remoteRef).Trim()

    if ($localSha -eq $remoteSha) {
        Write-Info "Already up to date with origin/$branch."
    } else {
        Write-Info "Updating to latest origin/$branch..."
        & git pull --ff-only origin $branch

        $lfsAvailable = & git lfs version 2>$null
        if ($lfsAvailable) {
            Write-Info "Syncing Git LFS files..."
            & git lfs pull
        }
    }

    $versionPath = Join-Path $scriptDir "release/editor/version.txt"
    if (Test-Path $versionPath) {
        $version = (Get-Content $versionPath -TotalCount 1).Trim()
        if ($version) {
            Write-Info "Current release version: $version"
        }
    }

    exit 0
} catch {
    Write-Fail $_.Exception.Message
    exit 1
}
