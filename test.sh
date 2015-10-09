workspace='Verona.xcworkspace'
scheme='Verona'
configuration='Debug'

set -o pipefail && xctool \
-workspace ${workspace} \
-scheme ${scheme} \
-configuration ${configuration} \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,OS=9.0,name=iPhone 6s' \
test

#
# xcodebuild  test \
#   -workspace ${workspace} \
#   -scheme ${scheme} \
#   -configuration ${configuration}\
#   -sdk iphonesimulator \
#   -destination 'platform=iOS Simulator,OS=9.0,name=iPhone 6s' \
#   -enableCodeCoverage YES
