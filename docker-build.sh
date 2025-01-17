#!/usr/bin/env bash

VERSION=1.2.0

rm -fr build/web

flutter build web --web-renderer canvaskit --release --dart-define=API_SERVER_URL=/
cd scripts && go run main.go ../build/web/main.dart.js && cd ..
rm -fr build/web/fonts/ && mkdir build/web/fonts
cp -r scripts/s build/web/fonts/s

docker buildx build --platform=linux/amd64 -t holygeek/ai-assist-client:$VERSION . --load

