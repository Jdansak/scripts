
python3 -m pip install --user uploadserver
mydir= 'pwd'
cd /tmp

# Generate self-signed server certificate
if ! test -f /tmp/server.pem; then
 echo "No Cert, Creating one."
 openssl req -x509 -out /tmp/server.pem -keyout server.pem -newkey rsa:2048 -nodes -sha256 -subj '/CN=server'
fi

if ! test -d /tmp/httpd; then
 echo "No httpd directory, creating one."
 mkdir /tmp/httpd
fi

cd /tmp/httpd

# Start the Python process in the background and save its PID
sudo sh -c 'python3 -m uploadserver 443 --server-certificate /tmp/server.pem & echo $!' > /tmp/httpd/python_pid.txt

# Wait for the Python process to start
sleep 2

# Get the current time
current_time=$(date '+%Y-%m-%d %H:%M:%S')
file_name=$(basename "$0")

# Display the PID of the Python process along with the start time
cat /tmp/httpd/python_pid.txt | while read pid; do
 echo "The $file_name started PID: $pid @ $current_time"
done

if ! test -d ~/https; then
 mkdir ~/https
 ln /tmp/https ~/https

cd mydir


























