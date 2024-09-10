apt install -y sudo htop
mkdir test && cd test
wget -O swap.sh https://raw.githubusercontent.com/advance-things/linux-swap/main/swap.sh
chmod +x swap.sh

./swap.sh -s 2048 -f /swapfile -F true


wget https://raw.githubusercontent.com/hestiacp/hestiacp/release/install/hst-install.sh

bash hst-install.sh --hostname hcp.durbhasigurukulam.com --email info@durbhasigurukulam.com --password vikaskumawat012356 --apache no --phpfpm no --vsftpd no --sieve yes --clamav no --spamassassin no
