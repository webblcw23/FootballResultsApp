import shutil
import os

# Copy a file
shutil.copy('data.txt', 'data_copy.txt')

# Move a file
shutil.move('data_copy.txt', 'data_copy2.txt')

# Rename a file
os.rename('data_copy2.txt', 'data_copy3.txt')

# Delete a file
os.remove('data_copy3.txt')

# Create a directory
os.mkdir('data')

# Change the current working directory
os.chdir('data')

# Get the current working directory
print(os.getcwd())

#loop through the files in the current working directory
for file in os.listdir():
    print(file)

# loop 10 times for a file in a directory to check if it exists
for i in range(10):
    if os.path.exists('data.txt'):
        print('File exists')
    else:
        print('File does not exist')
