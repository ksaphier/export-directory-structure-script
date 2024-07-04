# How to Run the script 
# Open PowerShell, navigate to the location of the script, and execute it by running: 
# .\ExportDirectoryStructure.ps1.

# Function to read and parse .gitignore file
function Get-GitignorePatterns {
    param(
        [string]$Path
    )

    $gitignorePath = Join-Path -Path $Path -ChildPath ".gitignore"
    if (Test-Path -Path $gitignorePath) {
        $patterns = Get-Content -Path $gitignorePath | Where-Object { $_ -and $_ -notmatch '^\s*#' }
        return $patterns
    }
    return @()
}

# Function to check if a path matches any of the .gitignore patterns
function IsIgnored {
    param(
        [string]$Path,
        [array]$Patterns
    )

    foreach ($pattern in $Patterns) {
        $regexPattern = [regex]::Escape($pattern) -replace '\\\*', '.*' -replace '\\\?', '.'
        if ($Path -match "^$regexPattern") {
            return $true
        }
    }
    return $false
}

# Function to print the directory structure
function Get-DirectoryStructure {
    param(
        [string]$Path,
        [string]$Indent = "",
        [string]$Output = "",
        [array]$IgnorePatterns,
        [string]$ScriptFileName,
        [string]$RootDirectory
    )

    # Get directories and files in the current path
    $items = Get-ChildItem -Path $Path
    
    foreach ($item in $items) {
        $relativePath = $item.FullName.Substring($RootDirectory.Length + 1)
        if (-not (IsIgnored -Path $relativePath -Patterns $IgnorePatterns) -and $item.Name -ne $ScriptFileName) {
            # Print directory name with a trailing slash
            if ($item.PSIsContainer) {
                $Output += "$Indent$item/`n"
                $Output = Get-DirectoryStructure -Path $item.FullName -Indent "$Indent    " -Output $Output -IgnorePatterns $IgnorePatterns -ScriptFileName $ScriptFileName -RootDirectory $RootDirectory
            }
            else {
                # Print file name
                $Output += "$Indent$item`n"
            }
        }
    }

    return $Output
}

# Get the directory where the script is located
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Get the name of the script file
$scriptFileName = $MyInvocation.MyCommand.Name

# Get the name of the root directory
$rootDirectoryName = Split-Path -Leaf $scriptDirectory

# Get .gitignore patterns
$ignorePatterns = Get-GitignorePatterns -Path $scriptDirectory

# Start the output with the root directory name
$structure = "$rootDirectoryName/`n"

# Get the directory structure with an initial indent
$structure = Get-DirectoryStructure -Path $scriptDirectory -IgnorePatterns $ignorePatterns -ScriptFileName $scriptFileName -RootDirectory $scriptDirectory -Output $structure -Indent "    "

# Export the structure to a text file in the same directory as the script
$outputFilePath = Join-Path -Path $scriptDirectory -ChildPath "directory_structure.txt"
$structure | Out-File -FilePath $outputFilePath

# Print the structure to the console
Write-Output $structure
