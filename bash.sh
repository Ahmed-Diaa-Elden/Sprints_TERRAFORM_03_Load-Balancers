#!/bin/bash

# define the lines to be appended
# append_lines="server {\n\t# HTTP\n\tlisten 80;\n\tlisten [::]:80;\n\tserver_name ${1}; # write instance ip private or public\n\n\tlocation / {\n\t\t\tproxy_pass https://www.yahoo.com;\n\t}\n}"

append_lines="server_names_hash_bucket_size 128;\nserver {\n\t# HTTP\n\tlisten 80;\n\tlisten [::]:80;\n\tserver_name ${1}; # write instance ip private or public\n\n\tlocation / {\n\t\t\tproxy_pass http://${2};\n\t}\n}"




# append after the line
sed -i "/include \/etc\/nginx\/sites-enabled\/\*/a $append_lines" /etc/nginx/nginx.conf
