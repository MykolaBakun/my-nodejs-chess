#!/usr/bin/env sh
# find '/usr/share/nginx/html' -name '*.js' -exec sed -i -e 's,API_URL,'"$API_URL"',g' {} \;
echo "process.env.API_URL = \"http://test_from_file/"\" > /nodejs-app/client/src/my_url.js;
nginx -g "daemon off;"