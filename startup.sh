#!/bin/bash

#TODO: Add logic to retrieve world file from remote location.
#TODO: Add save and export functionality.

echo "Finding server version and download URI..."
base_uri="https://terraria.org"
server_path=$(wget -qO- "${base_uri}" | grep "dedicated_servers" | sed -n "s/^.*'\(.*\)'.*$/\1/p")
server_version=$(echo "${server_path}" | sed -n "s/^.*-\(.*\)\.zip.*$/\1/p")
complete_uri="${base_uri}${server_path}"
echo "Found server version: ${server_version}"
echo "Found server download URI: ${complete_uri}"

if [ -z "${server_version}" ]; then
echo "Server version could not be determined. Exiting now..."
exit 1
fi

echo "Downloading server..."
wget -q ${complete_uri}
echo "Download complete."
echo "Unzipping server..."
unzip -q "terraria-server*"
echo "Unzip complete."

echo "Preparing server for execution..."
cd ${server_version}
cd Linux
sudo chmod +x TerrariaServer.bin.x86_64
echo "Launching server..."
 # Currently hits fatal exception after world creation completes.
./TerrariaServer.bin.x86_64 -ip 127.0.0.1 -port 7777

echo "All done now."