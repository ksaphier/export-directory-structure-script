# Instructions to Run the Script

1. **Save the Script**
    - Save the provided script into the directory you want to export.
    - Name the script file (e.g., `ExportDirectoryStructure.ps1`).

2. **Open PowerShell**
    - Open a PowerShell window.

3. **Navigate to the Directory**
    - Use the `cd` command to navigate to the directory where you saved the script.
      ```powershell
      cd path\to\your\directory
      ```

4. **Run the Script**
    - Execute the script by running the following command:
      ```powershell
      .\ExportDirectoryStructure.ps1
      ```

5. **View the Output**
    - The script will generate a file named `directory_structure.txt` in the same directory.
    - Open `directory_structure.txt` to view the exported directory structure.


# Script Functionality Overview

1. **Read and Parse .gitignore File**
    - Reads the `.gitignore` file if it exists in the specified path.
    - Filters out comment lines and empty lines.
    - Returns an array of patterns to be ignored.

2. **Check if a Path is Ignored**
    - Takes a path and an array of ignore patterns as input.
    - Converts the ignore patterns into regular expressions.
    - Checks if the given path matches any of the ignore patterns.
    - Returns `true` if the path is ignored, `false` otherwise.

3. **Print the Directory Structure**
    - Recursively lists all directories and files in the specified path.
    - Filters out files and directories that match the ignore patterns or are the script file itself.
    - Appends a trailing slash (`/`) to directory names.
    - Formats the directory structure with appropriate indentation.

4. **Get the Directory Where the Script is Located**
    - Retrieves the path of the directory where the script is saved.

5. **Get the Script File Name**
    - Retrieves the name of the script file.

6. **Get the Root Directory Name**
    - Retrieves the name of the root directory where the script is located.

7. **Get .gitignore Patterns**
    - Reads the `.gitignore` file and retrieves the patterns to be ignored.

8. **Start the Output with the Root Directory Name**
    - Starts the directory structure output with the name of the root directory.

9. **Get the Directory Structure with an Initial Indent**
    - Calls the function to print the directory structure with an initial indent.

10. **Export the Structure to a Text File**
    - Exports the formatted directory structure to a text file in the same directory as the script.

11. **Print the Structure to the Console**
    - Prints the directory structure to the console for immediate viewing.
