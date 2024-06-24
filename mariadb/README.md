# MariaDB Setup Script

## Description
This script automates the setup of MariaDB on various Linux distributions. It installs MariaDB, secures the installation, and optionally creates a new database and user or changes the root password.

## Usage

### Download and Execute

1. **Download the Script**:
   ```bash
   wget https://github.com/advance-things/easy-installation/blob/main/mariadb/sql.sh
   ```

2. **Make the Script Executable**:
   ```bash
   chmod +x sql.sh
   ```

3. **Execute the Script**:
   ```bash
   ./sql.sh
   ```
  To execute a script directly via `wget` or `curl` without downloading it first, you can use the following commands:

Using `wget`:
```bash
wget -O - https://github.com/advance-things/easy-installation/blob/main/mariadb/sql.sh | bash
```

Using `curl`:
```bash
curl -sSL https://github.com/advance-things/easy-installation/blob/main/mariadb/sql.sh | bash
```

### Explanation:
- **wget**: The `-O -` option specifies that the downloaded content should be sent to standard output (`stdout`) rather than saving it to a file. This output is then piped (`|`) into `bash` to execute the script.
  
- **curl**: The `-sSL` options make `curl` operate in silent mode (`s`), follow redirects (`L`), and show errors (`S`). The downloaded content is then piped (`|`) into `bash` for execution.

### Notes:
- **Security**: Executing scripts directly from the internet via `wget` or `curl` can pose security risks if you're not sure about the source. Always verify the integrity and trustworthiness of scripts before running them.
  
- **Permissions**: Ensure that your environment allows script execution from standard input (`stdin`) for this method to work without issues.

This method allows you to run your MariaDB setup script directly from GitHub without saving it locally first. Adjust the URL to match the actual location of your script in your GitHub repository.
  

4. **Follow the Prompts**:
   - Enter the database name (`DB_NAME`).
   - Enter the database username (`DB_USER`).
   - Enter the database password (`DB_PASS`). Note: Your input for the password will not be visible during entry for security reasons.

5. **Completion**:
   The script will install MariaDB, start the service, secure the installation with the provided password, and optionally change the root password or create a new database and user.

## Notes
- Ensure your Linux distribution is supported as per the script's checks (`ubuntu`, `debian`, `kali`, `centos`, `rhel`, `fedora`, `arch`).
- Adjust script permissions (`chmod`) and ensure it is executable before running (`./sql.sh`).
- Review and modify the script as needed based on your specific requirements or security policies.
```

You can now copy this markdown text directly into your `README.md` file in your GitHub repository. It provides clear instructions for downloading, making executable, and executing your MariaDB setup script in a straightforward manner. Adjust the URLs and paths as needed for your specific repository structure.
