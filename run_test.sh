#! /bin/bash

project="SlideMenuDovi"
workspace="SlideMenuDovi.xcworkspace"
destination="platform=iOS Simulator,name=iPhone 6S,OS=9.3"

eval "cd Example"
eval "gem install bundler"
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

eval "cd .."
eval "slather"
eval "bash <(curl -s https://codecov.io/bash) -f cobertura.xml"
