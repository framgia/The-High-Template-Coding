# RxSwift-Template
## Introduction
RxSwift-Template is a starter project which implements MVVM Pattern and RxSwift.

## Architecture
- MVVM
- RxSwift

## Install
1. Clone: https://github.com/framgia/native-app-skeletons
2. Checkout branch ios-unit2
3. run "pod install" in terminal of repo direction path
4. open project in Xcode and run

## Libraries
[Alamofire](https://github.com/Alamofire/Alamofire)

[NSObject-Rx](https://github.com/RxSwiftCommunity/NSObject-Rx)

[RxCocoa](https://github.com/ReactiveX/RxSwift)

[RxSwift](https://github.com/ReactiveX/RxSwift)

[RxRealm](https://github.com/RxSwiftCommunity/RxRealm)

[Reusable](https://cocoapods.org/pods/Reusable)

[Then](https://cocoapods.org/pods/Then)

[Validator](https://cocoapods.org/pods/Validator)

[MBProgressHUD](https://github.com/jdg/MBProgressHUD)

[SDWebImage](https://github.com/SDWebImage/SDWebImage)

## Environments
There are 3 environments in app: Development, Staging and Production.  Scheme depend on configurations:
> Development

> Staging

> Production

## How to use?
### Example call api
#### Define object conform Codable
```
struct Repo: Codable {
    var id: Int
    var name: String
    var fullname: String
    var urlString: String
    var starCount: Int
    var folkCount: Int
    var owner: Owner
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case fullname = "full_name"
        case urlString = "url"
        case starCount = "stargazers_count"
        case folkCount = "forks_count"
        case owner = "owner"
    }
}
```
#### Define API in APIClient.swift
```
static func getRepositories(page: Int, perPage: Int) -> Observable<ResponseData<[Repo]>> {
    return NetworkingManager.request(APIRouter.getRepositories(page, perPage))
}
```

#### Using
```
APIClient.getRepositories(page: page, perPage: perPage)
```
