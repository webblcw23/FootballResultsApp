# Prompt for Directory Path
$directoryPath = Read-Host -Prompt "Enter the directory path"

# Check if Directory Exists and Create if Not
if (-Not (Test-Path -Path $directoryPath)) {
    New-Item -Path $directoryPath -ItemType Directory
    Write-Output "Directory created: $directoryPath"
} else {
    Write-Output "Directory already exists: $directoryPath"
}

# Prompt for File Name
$fileName = Read-Host -Prompt "Enter the file name"
$filePath = Join-Path -Path $directoryPath -ChildPath "$fileName.txt"

# Create New Text File and Write Message
$message = Read-Host -Prompt "Enter the message to write to the file"
New-Item -Path $filePath -ItemType File -Value $message
Write-Output "File created: $filePath"

# Read and Display File Content
$fileContent = Get-Content -Path $filePath
Write-Output "File content:"
Write-Output $fileContent

# Delete the Text File
Remove-Item -Path $filePath
Write-Output "File deleted: $filePath"