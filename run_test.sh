#! /bin/bash

project="SliderMenuDoviTests"
workspace="SliderMenuDovi.xcworkspace"
destination="platform=iOS Simulator,name=iPhone 6S,OS=9.3"

eval "cd Example"
eval "bundle install"
eval "pod install"

TEST_CMD="xcodebuild -scheme ${project} -workspace ${workspace} -sdk iphonesimulator -destination '${destination}' build test"

which -s xcpretty
XCPRETTY_INSTALLED=$?

if [[ $TRAVIS || $XCPRETTY_INSTALLED == 0 ]]; then
  eval "${TEST_CMD} | xcpretty"
else
  eval "$TEST_CMD"
fi
