# Fastlane 

The easiest way to build and release mobile apps. Fastlane handles tedious tasks so you don’t have to. 

Link ref : https://fastlane.tools/ 

#### Requirements Install 
[Python](https://www.python.org/)  
[RubyGems](https://rubygems.org/) or [Homebrew](https://brew.sh/)

[Cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.0/installation.html)  
[Firebase CLI](https://firebase.google.com/docs/cli#install_the_firebase_cli)  

#### Install

+ Install Fastlne 
```
# Using RubyGems
sudo gem install fastlane -NV

# Alternatively using Homebrew
brew install fastlane 
```

+ Install Firebase  app distribution

 ```
 fastlane add_plugin firebase_app_distribution
 ```
+ Init fastlane folder 
```
cookiecutter https://github.com/framgia/The-High-Template-Coding.git --checkout fastlane 
```
Then input some informartion in terminal  . You will be prompted to enter a bunch of project config values. Next , will generate a project from the template, using the values that you entered. It will be placed in your current directory.

#### Additional some key information

In file `fastlane/.env.secret` additional some key , follow table above : 

| KEY | Mean |  Reference |
| -------- | -------- | -------- |
| `FIREBASE_ANDROID_APP_DEV FIREBASE_IOS_APP_DEV `     |  Your app's Firebase App ID. You can find the App ID in the Firebase console, on the General Settings page .For each environment there will be corresponding APP ID  |  [APP ID ](https://console.firebase.google.com/u/0/project/_/settings/general/)     |
| `FIREBASE_GROUP_TESTER`     | 	The tester groups you want to invite . Groups are specified using group aliases, which you can look up in the Firebase console. | [Manage Testers ](https://firebase.google.com/docs/app-distribution/manage-testers)     |
| `CHATWORK_API_TOKEN`     | TOKEN Account boot ChatWork   |      |
| `CHATWORK_ROOM_ID`     | RoomID ChatWork you want send notification   |      |
| `CHATWORK_SEND_TO_TESTER`     |  List UserId ChatWord you want send direct message |      |
| `BUILD_IOS_NAME`     |   |      |
| `SCHEME_NAME_IOS`     |   |      |

#### Run fastlane 
In root project , run command : 

```
fastlane 
```
Next ,in terminal will show table for some lane as image below :  

![Terminal](image/ex.png)

Then select number represent for the lane .

Description  lane 
| Lane | Mean |  Reference |
| -------- | -------- | -------- |
| develop , staging ,production | Platform iOS/Android  lane  will run build and distribute to Firebase for each environment develop ,staging,production|       |
| buildAppDevelop , buildAppStaging , buildAppProduction | Platform iOS/Android only build and generate APK/ipa file  |   |
| uploadFirebaseDevelop , uploadFirebaseStaging , uploadFirebaseProduction | Platform iOS/Android only distribute to Firebase|      |


### Các lỗi thường gặp 
1. Gradle của project không tương thích với phiên bản java mà fastlane đang chạy ( error: java.lang.NoClassDefFoundError: javax/xml/bind/JAXBException )
- Fastlane sử dụng môi trường java của môi trường cài đặt trên máy đang chạy. Nếu run fastlane bị lỗi hãy nghĩ ngay đến việc kiểm tra xem project của mình đang chạy trên java nào và install java tương ứng trên máy ( window, linux, macos)
- Khi install xong thử chạy lệnh ./gradlew clean ở terminal của project. Nếu lệnh này run thành công thì có nghĩa là fastlane đã có thể chạy được

2. Khi bị lỗi không thể tìm thấy plugin Firebase app distribution
- gỡ cài đặt firebase app distribution: sudo gem uninstall fastlane-plugin-firebase_app_distribution
- install lại sử dụng ruby gem: gem install fastlane-plugin-firebase_app_distribution --user-install

### Fastlane android with deploygate

```
desc "Push a new beta build to deploygate with development env"
  lane :beta_dev_deploygate do
  deploygate(
    api_token: DEPLOYGATE_API_TOKEN,
    user: DEPLOYGATE_USER,
    apk: "app/build/outputs/apk/dev/debug/name-#{ENV['VERSION_NAME']}-dev-debug.apk",
    message: "build new beta build to deploygate with development env for testing"
  )
  end
```

### Faslane android với Firebase app distribution
```
lane :uploadFirebaseCustomer do
	releaseNote = File.read("./temp/releaseNote.txt")
	puts "------------------- Starting distribution via Firebase Distribution  .......... "
	va = File.absolute_path("../android/app/build/outputs/apk/")
	va2 = va+'/*/*/*.apk'
	path = Dir[va2][0]
	puts "------------------- APK .......... #{path}  -------"

	firebase_app_distribution(
                               app:"#{ENV['ANDROID_APP_STG']}" ,
                               apk_path: path,
                               release_notes: "#{releaseNote}",
                               groups:"#{ENV['GROUP_CUSTOMER']}"
     )
	puts "------------------- Distribution via Fabric successfully !!  "
end
```
