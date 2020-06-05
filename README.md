# Android Kotlin MVVM Starter

## Introduction
[![Platform](https://img.shields.io/badge/platform-Android-green.svg)](http://developer.android.com/index.html)

Android Kotlin Starter is a starter project which implements MVVM Pattern.  

## Install

**Requirements Install**

To set project's infomation automatically (app_name, package_name, package_dir), please install libraries below:

[python](https://www.python.org/)  
[cookiecutter](https://cookiecutter.readthedocs.io/en/1.7.0/installation.html)  

Run command below to clone project: 
```
 cookiecutter https://github.com/framgia/The-High-Template-Coding.git --checkout android 
```
Then input some informartion in terminal  . You will be prompted to enter a bunch of project config values. Next , will generate a project from the template, using the values that you entered. It will be placed in your current directory.
```
"app_name": MyApplication (default),
"package_name": com.sun.myapp (default)",
"package_dir": .../com/sun/myapp (default)"
```

## Libraries
[Koin](https://insert-koin.io/)

[Retrofit2](https://github.com/square/retrofit)

[Logging](https://github.com/square/okhttp/tree/master/okhttp-logging-interceptor)

[Gson](https://github.com/google/gson)

[Coroutines](https://kotlinlang.org/docs/reference/coroutines-overview.html)

[AndroidX](https://developer.android.com/topic/libraries/support-library/androidx-overview)

[Lifecycle](https://developer.android.com/jetpack/androidx/releases/lifecycle)

[Databiding](https://developer.android.com/topic/libraries/data-binding/)

## Environments
There are 3 environments in app: Develop, Staging and Product. ApplicationIdSuffix depend on environment:
> Develop: .dev

> Staing: .staging

> Product: <Not append suffix>

## How to use

### build.gradle (Module:app)
Update path of it here if you have keystore properties file.
```kotlin
/**
 * The path of keystore.properties file
 */
def keystorePropertiesFile = rootProject.file("keystore.properties")
def keystoreProperties = new Properties()
```

Config/add environment's information your here
```kotlin
productFlavors {
      def URL_END_POINT = "URL_END_POINT";
      develop {
          versionNameSuffix = "-dev"
          applicationIdSuffix = ".dev"
          buildConfigField "String", URL_END_POINT, '""'
      }
      ...
}
```

### Call Api

```kotlin

fun createOkHttpClient(...){...}

fun createRetrofit(okHttpClient: OkHttpClient): Retrofit =
        Retrofit.Builder()
            .baseUrl(BuildConfig.URL_END_POINT) //Update your url_end_point here
            .client(okHttpClient)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
```

### Inject components
Then, init them in `NetworkModule.kt`. And you can name your own file depend on your intention.
```kotlin
...
single { ApiService.createRetrofit(get()) }
single { createApiService<ApiServiceInterface>(get()) } //ApiServiceInterface is an interface declare api request methods
```

or with `ViewModelModule.kt`
```kotlin
viewModel { SampleViewModel() }
or
viewModel { SampleViewModel(get()) } //if have a parameter and the parameter is created, the same to n parameters is n get() params
```
For detail in [koin dependency injection](https://insert-koin.io/)

### Implement
For example with `Activity` implement BaseActivity: 
```kotlin
class SampleActivity : BaseActivity<ActivitySampleBinding, SampleViewModel>() {
    override val viewModel: SampleViewModel by viewModel()
    override val bindingVariable = BR.viewModel
    override val layoutId = R.layout.activity_sample
```
apply the same with `Fragment`

