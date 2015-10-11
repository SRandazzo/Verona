workspace='Verona.xcworkspace'
scheme='Verona'
configuration='Debug'

# xctool \
# -workspace ${workspace} \
# -scheme ${scheme} \
# -configuration ${configuration} \
# -sdk iphonesimulator \
# -destination 'platform=iOS Simulator,OS=9.0,name=iPhone 6s' \
# build test

xcodebuild test \
  -workspace ${workspace} \
  -scheme ${scheme} \
  -configuration ${configuration}\
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,OS=9.0,name=iPhone 6s' \
  -enableCodeCoverage YES
