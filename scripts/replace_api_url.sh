#!/usr/bin/env sh
# find '/usr/share/nginx/html' -name '*.js' -exec sed -i -e 's,API_URL,'"$API_URL"',g' {} \;
# echo "process.env.API_URL = \"http://test_from_file/"\" > /nodejs-app/client/src/my_url.js;


sed -i "s+my_test_url_pivo+$API_URL+g" /usr/share/nginx/html/assets/nodejs-chess-0.1.0.js
sed -i "s+my_test_url_pivo+$API_URL+g" /usr/share/nginx/html/assets/nodejs-chess-0.1.0.js.map

# sed -i 's/my_test_url_pivo/http://work/g' test
nginx -g "daemon off;"
