# ToneReader

**Create project**
file -> new -> project

**Add pods**
* create `Podfile`
* add the following
```
target 'ToneReader' do
  pod 'AudioKit', '~> 4.0'
end
```

**Install pods**
```
pod install
```

**Open workspace**
```
open ToneReader.xcworkspace -a Xcode
```

**Enable mic access**

You may see the following error when running

> The app’s Info.plist must contain an NSMicrophoneUsageDescription key with a string value explaining to the user how the app uses this data.

* right click on `info.plist`
* select `open as` -> `source code`
* add the following anywhere in the file:
```
<key>NSMicrophoneUsageDescription</key>
<string>Can't hear you without mic access</string>
```
