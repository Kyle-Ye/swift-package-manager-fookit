#!/bin/bash

rm -rf archives

xcodebuild archive \
-project FooKit.xcodeproj \
-scheme FooKit \
-configuration Release \
-destination "generic/platform=macOS" \
-archivePath "archives/macOS" \
SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES

rm -rf archives/macOS.xcarchive/Products/Library/Frameworks/FooKit.framework/Versions/A/_CodeSignature
rm -rf archives/macOS.xcarchive/dSYMs
rm -rf archives/macOS.xcarchive/Products/Library/Frameworks/FooKit.framework/Versions/A/Modules/FooKit.swiftmodule/*.swiftdoc

xcodebuild \
-create-xcframework \
-archive archives/macOS.xcarchive -framework FooKit.framework \
-output FooKit.xcframework

zip -r -X FooKit.xcframework.zip FooKit.xcframework
