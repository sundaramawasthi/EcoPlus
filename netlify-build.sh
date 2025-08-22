#!/bin/bash
# Install Flutter SDK on Netlify server
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PWD/flutter/bin:$PATH"

# Enable Flutter Web
flutter config --enable-web

# Install dependencies
flutter pub get

# Build Web
flutter build web
