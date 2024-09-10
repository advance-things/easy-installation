## **README for Mail Server Installation Script**

### **Description**

The `mail-server.sh` script is designed to automate the installation and configuration of a mail server using the Hestia Control Panel. This script allows for easy setup by providing options to specify domain, email, password, swap size, timezone, and other configuration details.

### **Usage**

To run the script, you can download it using `wget` or `curl` and then execute it with the necessary parameters.

#### **Download and Run the Script**

1. **Download the script:**
   ```bash
   wget -O mail-server.sh https://raw.githubusercontent.com/advance-things/easy-installation/main/hestiacp/mail-server.sh
   ```

2. **Make the script executable:**
   ```bash
   chmod +x mail-server.sh
   ```

3. **Run the script with arguments:**
   ```bash
   ./mail-server.sh --domain <your-domain> --email <your-email> --password <your-password> --swap <swap-size-in-GB> --timezone <your-timezone>
   ```

### **Command-Line Arguments**

- `--domain` : The domain name for the mail server (e.g., `example.com`).
- `--email` : Admin email address for notifications and configuration (e.g., `admin@example.com`).
- `--password` : The password for the admin user.
- `--swap` : Size of the swap file in GB (e.g., `2` for 2 GB).
- `--timezone` : Timezone to set for the server (e.g., `Asia/Kolkata`).

### **Example Usage**

```bash
./mail-server.sh --domain example.com --email admin@example.com --password mysecurepassword --swap 2 --timezone Asia/Kolkata
```

### **Features**

- **Automated Installation**: Installs and configures the Hestia Control Panel and mail server components.
- **Customizable Parameters**: Supports dynamic input for domain, email, password, swap size, and timezone.
- **Timezone Configuration**: Sets the server's timezone automatically based on user input.
- **Swap File Management**: Automatically creates a swap file with a size specified in the arguments.

### **Prerequisites**

- A fresh Linux server (Debian/Ubuntu recommended).
- Root or sudo access to run the installation.
- Internet connection to download necessary packages and scripts.

### **Requirements**

- `bash`
- `wget` or `curl`
- `sudo`

### **Installation Steps**

1. **Ensure your server is up-to-date:**
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. **Run the script using the provided command-line options.**

### **Notes**

- The script will prompt for any missing arguments if they are not provided in the command line.
- Ensure the domain name is correctly pointed to your server IP before running the script.

### **License**

This script is released under the MIT License. See the [LICENSE](https://opensource.org/licenses/MIT) file for details.

### **Contributing**

If you want to contribute to the script, fork the repository and create a pull request with your changes. Contributions are always welcome!

### **Support**

If you encounter any issues, please raise them on the [GitHub Issues](https://github.com/advance-things/easy-installation/issues) page.
