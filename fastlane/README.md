fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## Android
### android distributeDevDebug
```
fastlane android distributeDevDebug
```
Build App Develop Debug
### android distributeStagingDebug
```
fastlane android distributeStagingDebug
```
Build App Staging Debug
### android distributeProductDebug
```
fastlane android distributeProductDebug
```
Build App Product Debug
### android writeReleaseNote
```
fastlane android writeReleaseNote
```
Write release notes
### android buildApk
```
fastlane android buildApk
```
Upload file .apk to Firebase
### android notifyCW
```
fastlane android notifyCW
```
Notification on chatwork 

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
