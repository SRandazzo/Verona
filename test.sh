workspace='Verona.xcworkspace'
scheme='Verona'
configuration='Debug'

xcodebuild -workspace ${workspace} -scheme ${scheme} -configuration ${configuration} -sdk iphonesimulator -destination 'platform=iOS Simulator,OS=9.0,name=iPhone 6' test
