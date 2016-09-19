WORKSPACE='Verona.xcworkspace'
SCHEME='Verona'
CONFIGURATION='Debug'

set -o pipefail && xcodebuild build test \
  -workspace ${WORKSPACE} \
  -scheme ${SCHEME} \
  -configuration ${CONFIGURATION}\
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,OS=10.0,name=iPhone 7' \
  -enableCodeCoverage YES | xcpretty -c --test
