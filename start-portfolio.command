#!/bin/bash
cd "$(dirname "$0")" || exit 1
PORT=8000
echo "Serving $(pwd) at http://localhost:$PORT/index.html"
(sleep 2; open "http://localhost:$PORT/index.html") &
if command -v python3 >/dev/null 2>&1 && python3 -c "import http.server" 2>/dev/null; then
  python3 -m http.server $PORT
elif command -v npx >/dev/null 2>&1; then
  npx --yes serve -l $PORT .
elif command -v ruby >/dev/null 2>&1; then
  ruby -run -e httpd . -p $PORT
elif command -v php >/dev/null 2>&1; then
  php -S localhost:$PORT
else
  echo "No web server found (python3, npx, ruby, php)."
fi
echo; echo "Server stopped. Press Enter to close."; read
