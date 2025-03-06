#Create new text file and then open it in Text Editor
New-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewTextFile.txt" -ItemType "file" -Value "This is a new text file"
# "open" needed here for Mac to open in Text Editor
Start-Process -FilePath "open" "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts/NewTextFile.txt"
#Create new textfile with input from user for filename
$fileName = Read-Host -Prompt "Enter the name of the file"
New-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\$fileName.txt" -ItemType "file" -Value "This is a new text file"
#Delete new text file
Remove-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewFile.txt"
#Create new folder
New-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewFolder" -ItemType "directory"
#Delete new folder
Remove-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewFolder" -Recurse
#Copy file to new location
Copy-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewTextFile.txt" -Destination "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewTextFileCopy.txt"
#Move file to new location
Move-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewTextFileCopy.txt" -Destination "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewTextFileCopyMoved.txt"
#Rename file
Rename-Item -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewTextFileCopyMoved.txt" -NewName "NewTextFileCopyMovedRenamed.txt"
#Get current date and time
Get-Date
#List all files in a directory
Get-ChildItem -Path "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts"

#Template for a simple for loop with exit condition after count gets to 5
$count = 0
while ($count -lt 5) {
    Write-Output "Count is $count"
    $count++
}

#Template for a loop to check if a file exists
$filePath = "/Users/lewiswebb/Documents/VSCode_Azure/PowershellScripts\NewTextFile.txt"
for (i=0; i -lt 5; i++) {
    if (!(Test-Path $filePath)) {
        Write-Output "File does not exist"
        sleep 5
    } else {
        Write-Output "File exists and found!"
        break
    }
}

#Simple addition of two numbers with input and conversion of string to integer
$number1 = [int](Read-Host -Prompt "Enter first number")
$number2 = [int](Read-Host -Prompt "Enter second number")
$sum = $number1 + $number2
Write-Output "The sum of $number1 and $number2 is $sum"