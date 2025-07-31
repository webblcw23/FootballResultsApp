# Copy a file
Copy-Item -Path "data.txt" -Destination "data_copy.txt"

# Move a file
Move-Item -Path "data_copy.txt" -Destination "data_copy2.txt"

# Rename a file
Rename-Item -Path "data_copy2.txt" -NewName "data_copy3.txt"

# Delete a file
Remove-Item -Path "data_copy3.txt"

# Create a directory
New-Item -Path "data" -ItemType Directory

# Change the current working directory
Set-Location -Path "data"

# Get the current working directory
Write-Output (Get-Location)


#loop through the files in the current working directory
Get-ChildItem | ForEach-Object {
    Write-Output $_.Name
}

# loop 10 times for a file in a directory to check if it exists
for ($i=0; $i -lt 10; $i++) {
    $file = "data.txt"
    if (Test-Path $file) {
        Write-Output "File exists"
    } else {
        Write-Output "File does not exist"
    }
}

