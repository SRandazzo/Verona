workspace='Verona.xcworkspace'
scheme='Verona'
configuration='Debug'

set -o pipefail && xctool \
-workspace ${workspace} \
-scheme ${scheme} \
-configuration ${configuration} \
-sdk iphonesimulator \
-destination 'platform=iOS Simulator,OS=9.0,name=iPhone 6s' \
GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES \
test

#
# xcodebuild  test \
#   -workspace ${workspace} \
#   -scheme ${scheme} \
#   -configuration ${configuration}\
#   -sdk iphonesimulator \
#   -destination 'platform=iOS Simulator,OS=9.0,name=iPhone 6s' \
#   -enableCodeCoverage YES
