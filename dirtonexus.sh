#!/usr/bin/env bash
# ---------------------------------------------------------------------------------------------------------------------
# Description: As Nexus Repository Manager community version does not support folder upload, this simple script allows
#              you uploading an entire directory with all its content (including subdirectories) to a Nexus raw repo.
#              Note that if some file contains spaces ' ' in its name, they will be replaced with underscores '_'
#
# Author: Marcelo Menendez Vazquez
#
# Usage:
# ./dirtonexusraw.sh <dir-path>
#
# Example:
# ./dirtonexusraw.sh /foo/bar
# 
# User variables:
# ----------------
# upload_dir: # Path of the directory you want to upload to Nexus. Taken from the fist argument
# Example: ./dirtonexusraw.sh foo/bar
#
# curl=Path to curl binary file. You may want to change this to swap between different curl installations
# Example: /path/to/bin/curl
#
# curl_args: Additional arguments to parse to curl call.
# Example: -v --insecure
#
# curl_http_username: User used to connect to Nexus
# curl_http_password: Password used to connect to Nexus
# curl_http_base_url: URL of the folder inside Nexus where your directory will be placed
# Example: http://mynexus.org/repository/examplerepo/myParentFolder
# ---------------------------------------------------------------------------------------------------------------------

# Variable definition
# ----------------------------------------
upload_dir="$1" 
curl_exec="curl"
curl_args=""
curl_http_username="****"
curl_http_password="****"
curl_http_base_url="https://mynexus-changethis.org/repository/myrepo/foo/bar"

# Function definition
# ----------------------------------------
function showUsage {
  echo -e "\n\tUsage:"
  echo -e "\t./dirtonexus.sh <dir-path>\n"
  exit 1
}

# Program
# ----------------------------------------

if [ $# -ne 1 ] || [ ! -d "${upload_dir}" ]; then
  showUsage
fi

upload_dir_dirname=$(dirname "${upload_dir}")
upload_dir_basename=$(basename "${upload_dir}")

cd "${upload_dir_dirname}" && find "${upload_dir_basename}" -type f | while read -r file; do

  file_replace_spaces=$(echo "${file}"|tr ' ' '_')
  destination_file_url="${curl_http_base_url}/${file_replace_spaces}"

  echo -e "Uploading ${file} to ${curl_http_base_url}/${file_replace_spaces}... \c"
 
  if "${curl_exec}" "${curl_args}" -u ''"${curl_http_username}"'':''"${curl_http_password}"'' --upload-file "${file}" "${destination_file_url}"; then
    echo "OK"
  else
    echo "ERROR"
    exit 1
  fi
done
