## Introduce  
This is a template for Flutter project use [Flutter Bloc](https://pub.dev/packages/flutter_bloc) library  
  
Before you continue, ensure you meet the following requirements:  
- [Cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.2/installation.html)  
  
## Install  
First, run command below:  
```  
 cookiecutter https://github.com/framgia/The-High-Template-Coding.git --checkout flutter
 ```  
Then input some information in terminal. You will be prompted to enter a bunch of project config values. Press enter if you don't want to change
```
"app_name": default is MyApp,
"app_id": default is "sun.flutter.sample",
"flutter_package_name": default is "sample",
"android_package_dir": by default it is created according to app_id (should not be changed).
```
Next, cookiecutter will generate a project from the template, using the values that you entered. It will be placed in your current directory.

## Environments
There are 3 environments in app:  **Develop, Staging and Production.**

To change, and some field for each environment, you must change in .env file.

> Develop:  **.env**

> Staging :  **.env.staging**

> Production :  **.env.production**

Example .env file:
```    
    APP_NAME=[DEV] Example  
    APP_ID=sun.flutter.sample  
    VER_CODE=1  
    VER_NAME=1.0.0  
    KEY_STORE=../keystores/develop/keystore.properties
``` 
##  Android Keystore
Config develop/staging/production keystore properties and file keystore in the corresponding directory.

## Run and build
Edit configurations

![configurations](https://i.imgur.com/W0MDB40.png)

Change *Build flavor*

Enter *develop*, *staging* or *production* then you can run or build like other Flutter projects.

![Imgur](https://imgur.com/MuV0dhi.png)

## Multi language
Add supported locales. [Supported languages in flutter](https://github.com/flutter/flutter/tree/master/packages/flutter_localizations/lib/src/l10n)
Install plugin [Flutter Intl](https://localizely.com/flutter-localization-workflow?utm_medium=ide_plugin&utm_source=androidstudio_readmore) (available on AndroidStudio, VScode)
- In `app.dart`
```dart 
supportedLocales: S.delegate.supportedLocales
```
- In lib/l10n create arb file contains translation. Example `intl_en.arb`. Or selecte Tools/Flutter Intl/Add Local
```json
   {
      "email": "Email"
   }
```
Use
```dart 
S.current.email; //or S.of(context).email ==> Email
```

Note : If plugin not auto-generate folder "generated", run command `flutter pub global run intl_utils:generate`
## Call api
- GET:

Example:
```dart
final network = locator<Network>();
network.get(url: "http://dummy.restapiexample.com/api/v1/employees", params: {});
```
- POST: 

Example:
```dart
final network = locator<Network>();
Map data = {"name":"test","salary":"123","age":"23"};
network.post(url: "http://dummy.restapiexample.com/api/v1/create", body: data);
```
## Flutter Bloc 
- Create Event:
```dart
class GetData extends BaseEvent {}
```
- Create State:
```dart
class InitState extends BaseState {}

class LoadingState extends BaseState {}

class LoadedState<T> extends BaseState {
  final T data;

  LoadedState({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];
}

class ErrorState<T> extends BaseState {
  final T data;

  ErrorState({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];
}
```
- Create bloc:
```dart
class HomeBloc extends BaseBloc {
  final HomeRepository homeRepository;

  HomeBloc({HomeRepository homeRepository}) : this.homeRepository = homeRepository ?? locator<HomeRepository>();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is GetData) {
      yield* _mapGetData();
    }
  }

  Stream<BaseState> _mapGetData() async* {
    yield LoadingState();
    try {
      //do something
      final data = await homeRepository.getData();
      yield LoadedState<String>(data: data);
    } catch (e) {
      yield ErrorState(data: e);
    }
  }
}
```
- Use bloc:
```dart
  BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(homeRepository: locator<HomeRepository>())..add(GetData()),
      child: Scaffold(
        body: Center(
          child: BlocBuilder<HomeBloc, BaseState>(
            builder: (context, state) {
              if (state is LoadingState) return CircularProgressIndicator();
              if (state is LoadedState) return Text(state.data);
              return Text(S.current.email);
            },
          ),
        ),
      ),
    );
```
Access [Flutter bloc](https://pub.dev/packages/flutter_bloc) for more information. 

## Libs use in this template
- [equatable](https://pub.dev/packages/equatable)
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [get_it](https://pub.dev/packages/get_it)
- [flutter_config](https://pub.dev/packages/flutter_config)
- [dio](https://pub.dev/packages/dio)