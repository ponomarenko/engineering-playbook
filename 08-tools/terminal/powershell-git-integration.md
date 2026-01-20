# PowerShell Git Integration

PowerShell commands and techniques for working with Git repositories.

## PowerShell File Operations

### List and Inspect Files
```powershell
# List files with details
Get-ChildItem path/to/directory

# List specific file types
Get-ChildItem -Recurse src -Include *.png,*.jpg

# Get file size
(Get-Item "path/to/file.ext").Length

# List files with sizes
Get-ChildItem -Recurse src -Include *.png | Select-Object Name, Length

# Sort by size
Get-ChildItem -Recurse src -Include *.png | Sort-Object Length -Descending
```

**Example:**
```powershell
Get-ChildItem -Recurse src -Include *.png | Select-Object FullName, @{Name="SizeKB";Expression={[math]::Round($_.Length/1KB,2)}} | Sort-Object SizeKB -Descending

# Output:
# FullName                              SizeKB
# --------                              ------
# C:\project\src\assets\logo.png        45.23
# C:\project\src\assets\icon.png        12.45
```

### Calculate Totals
```powershell
# Total size of all images
$total = (Get-ChildItem -Recurse src -Include *.png,*.jpg | Measure-Object -Property Length -Sum)
"Total: $($total.Count) files, $([math]::Round($total.Sum/1KB,2)) KB"
```

**Example output:**
```
Total: 15 files, 234.56 KB
```

### Hash Calculation
```powershell
# Calculate SHA256 hash
certutil -hashfile "path/to/file.ext" SHA256

# Calculate hash for Git object
git cat-file blob hash > temp.file
certutil -hashfile temp.file SHA256
Remove-Item temp.file
```

**Example:**
```powershell
certutil -hashfile "src/assets/logo.png" SHA256
# Output:
# SHA256 hash of src/assets/logo.png:
# 6ec04de324e0b947eb1826a3eed378b68be40033918d1ec32f2568b67cd2d07c
# CertUtil: -hashfile command completed successfully.
```

### File Content Operations
```powershell
# View file content (first lines)
Get-Content file.txt -First 10

# Save Git object to file
git show commit-hash:path/to/file.ext > temp_file.ext

# Iterate and copy files
foreach ($file in @("file1.png", "file2.png")) { 
    git show "main:$file" > $file 
}
```

## PowerShell with Git

### Filter Git Output
```powershell
# Filter git output
git status --short | Select-String -Pattern "\.png"

# Select first N lines
git log --oneline | Select-Object -First 10

# Search in git output
git diff --name-only | Select-String "component"

# Count matches
(git status --short | Select-String "\.ts").Count

# Multiple patterns
git status --short | Select-String -Pattern "(\.ts|\.js|\.tsx)"
```

### Advanced Filtering
```powershell
# Filter commits by date
git log --oneline --since="2026-01-01" | Select-Object -First 20

# Filter files by size and type
Get-ChildItem -Recurse | Where-Object {$_.Length -gt 100KB -and $_.Extension -match '\.(png|jpg)'}

# Get modified files with sizes
git status --short | ForEach-Object {
    $file = $_.Substring(3)
    if (Test-Path $file) {
        [PSCustomObject]@{
            Status = $_.Substring(0,2).Trim()
            File = $file
            SizeKB = [math]::Round((Get-Item $file).Length/1KB, 2)
        }
    }
}
```

## Git Object Analysis

### Analyze Repository Objects
```powershell
# Find large files in Git history
git rev-list --objects --all | 
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
  Select-String "blob" |
  Sort-Object { [int]($_ -split '\s+')[2] } -Descending |
  Select-Object -First 10
```

### Compare File Versions
```powershell
# Save multiple versions for comparison
$commits = @("abc1234", "def5678", "ghi9012")
foreach ($commit in $commits) {
    git show "${commit}:src/app/app.component.ts" > "app_${commit}.ts"
}

# Compare sizes
Get-ChildItem app_*.ts | Select-Object Name, Length
```

## Batch Operations

### Process Multiple Files
```powershell
# Restore multiple files from main
$filesToRestore = @(
    "src/assets/logo.png",
    "src/assets/icon.png",
    "src/assets/background.jpg"
)

foreach ($file in $filesToRestore) {
    Write-Host "Restoring $file"
    git checkout main -- $file
}
```

### Generate Reports
```powershell
# Generate file change report
git diff --name-status main | ForEach-Object {
    $parts = $_ -split '\s+'
    [PSCustomObject]@{
        Status = $parts[0]
        File = $parts[1]
        Type = [System.IO.Path]::GetExtension($parts[1])
    }
} | Group-Object Status | Select-Object Name, Count
```

## Environment Configuration

### Git Environment Variables
```powershell
# Disable Git LFS temporarily
$env:GIT_LFS_SKIP_SMUDGE=1

# Clear variable
$env:GIT_LFS_SKIP_SMUDGE=$null

# Set editor for Git
$env:GIT_EDITOR="code --wait"  # Use VS Code as editor

# Set pager
$env:GIT_PAGER="less"

# Disable pager
$env:GIT_PAGER=""
```

### PowerShell Profile Aliases
```powershell
# Add to your PowerShell profile ($PROFILE)

# Git shortcuts
function gs { git status --short }
function gl { git log --oneline --graph -10 }
function gd { git diff $args }
function ga { git add $args }
function gc { git commit -m $args }

# Git LFS
function glfs { git lfs ls-files }

# File analysis
function filesize { 
    Get-ChildItem -Recurse $args | 
    Measure-Object -Property Length -Sum | 
    Select-Object @{Name="TotalMB";Expression={[math]::Round($_.Sum/1MB,2)}}, Count
}
```

## Quick Reference

| Task | Command |
|------|---------|
| Check file size | `(Get-Item "file.ext").Length` |
| List files by size | `Get-ChildItem -Recurse | Sort-Object Length -Descending` |
| Calculate hash | `certutil -hashfile "file.ext" SHA256` |
| Filter git output | `git status \| Select-String "pattern"` |
| First N lines | `git log \| Select-Object -First 10` |
| Total size of files | `Get-ChildItem -Recurse *.png \| Measure-Object -Property Length -Sum` |

---

**Last Updated:** 2026-01-20
