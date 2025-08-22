#!/bin/bash

# Download Flutter SDK on Netlify server
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

export PATH="$PWD/flutter/bin:$PATH"

flutter config --enable-web
flutter pub get
flutter build web
