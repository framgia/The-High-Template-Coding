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
or alternatively using `brew cask install fastlane`

# Available Actions
### runTest
```
fastlane runTest
```

### inputNoteAndroid
```
fastlane inputNoteAndroid
```

### inputNoteIOS
```
fastlane inputNoteIOS
```

### pushChatworkDev
```
fastlane pushChatworkDev
```

### pushChatworkCus
```
fastlane pushChatworkCus
```


----

## iOS
### ios develop
```
fastlane ios develop
```
Beta Distribution
Example:  fastlane develop remote:framgia pullNumber:123 branch:571_create_register_logic  |
Or: fastlane beta branch:571_create_register_logic   |
You can skip passing value for list parameter above
### ios staging
```
fastlane ios staging
```

### ios firebaseCustomer
```
fastlane ios firebaseCustomer
```

### ios firebaseTester
```
fastlane ios firebaseTester
```

### ios buildAppDev
```
fastlane ios buildAppDev
```

### ios buildAppStaging
```
fastlane ios buildAppStaging
```


----

## Android
### android develop
```
fastlane android develop
```
Beta Distribution
	Example:  fastlane develop remote:framgia pullNumber:123 branch:571_create_register_logic  |
	Or: fastlane develop branch:571_create_register_logic   |
	You can skip passing value for list parameter above
### android staging
```
fastlane android staging
```

### android uploadFirebaseTester
```
fastlane android uploadFirebaseTester
```
Upload to Fabric.
Example:  fastlane android  uploadFabric 
### android uploadFirebaseCustomer
```
fastlane android uploadFirebaseCustomer
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
