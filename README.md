
# Introduce
This is a template for react-native project

[react-native: 0.61.5]()  
[typescript: ts, tsx](https://reactnative.dev/docs/typescript)  
[redux-saga](https://redux-saga.js.org/docs/introduction/BeginnerTutorial.html)  
[reactnavigation 5x](https://reactnavigation.org/docs/navigating/)   
[react-native-config](https://github.com/luggit/react-native-config)  
[redux-logger](https://github.com/LogRocket/redux-logger)
# Environments
There are 3 environments in app: **Develop, Staging and Production.**

To change Base url, Version name, Version code, event App name,... for each environment, you must  change in .env file.

> Develop:  **.env**

> Staging : **.env.staging**

> Production : **.env.production**

Example .env file: 

```
APP_ID='com.company.app'
VER_CODE='1'
VER_NAME='1.0.0'
APP_NAME = 'App'

```
## Android Keystore
Config develop/staging keystore
```
keystore/keystore.properties
```
Config production keystore
```
keystores-production/keystore.properties
```
Config your keystore file, password, alias...

## Run and build

Run commands to remove and install node module:
```
npm rm-i
```

IOS only:
```
cd ios && pod install && cd ..
```

### ANDROID

- **Run android:**

Start server first :

```
npm start
```

Run on emulator **(emulator must be opened before)** or real device:

```
npm run android
npm run android-stg
npm run android-prod
```
                                                     
Build command:

```
npm run android-build
npm run android-build-stg
npm run android-build-prod
```

  APK file will be exported in **node-modules/android/app/build/outputs/apk/** folder


### IOS

- **Run ios (only simulator):**

```
npm run ios
npm run ios-stg
npm run ios-prod
```                                               
# Coding Rules
## Components
- **Only perform interface**
- **On render function: should not contain the entire screen interface definition, because it will make your code be ugly, not look good**

**example**
```
render(){
    return(
        // render ui a
        .....
        .....
        .....
        // render ui b
        .....
        .....
        .....
        // render ui a
        .....
        .....
        .....
        // render ui b
        .....
        .....
        .....
    )
}
```
**should be**
```
renderA = () => {
    return(
        // render ui a
        .....
        .....
        .....    
    )
}
renderB = () => {
    return(
        // render ui b
        .....
        .....
        .....    
    )
}
renderC = () => {
    return(
        // render ui c
        .....
        .....
        .....    
    )
}
renderD = () => {
    return(
        // render ui d
        .....
        .....
        .....    
    )
}
render(){
    return(
        //renderA
        //renderB
        //renderC
        //renderD    
    )
}
```
## Container 

- **Contain component logic & redux logic**
```$xslt
- Container will connect to screen
- Screen will call logic on container via prop
```

## Navigate between screen 

**Use: Navigate.ts**
```$xslt
- navigateAndRest
- navigateTo
- goBack
- popToRoot
```
## Communicate with redux-saga 
- Declare api in formation: [Config](src/networking/Config.ts) 
```$xslt
Movies: new API('/movies.json', 'get'),
```
- Declare action for active saga: [Action](src/saga/Action.ts)
```$xslt
MOVIES: new SagaAction('MOVIES'),
```
- combine your action to saga, that will run by saga middleware: [index](src/saga/index.ts)
```$xslt
yield doAsync(Actions.MOVIES, Config.API.Movies);
```
- finally dispatch action from screen container
```$xslt
dispatch({
    type: Action.MOVIES.value
})
```
after that saga will auto active and dispatch response to your reducer
