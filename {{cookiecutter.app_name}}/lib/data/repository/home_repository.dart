import 'package:{{cookiecutter.flutter_package_name}}/data/network/network.dart';

class HomeRepository {
  final Network _network;

  HomeRepository(this._network);

  //example call api to get data
  Future<String> getData() async {
//    _network.get(url: "");
    await Future.delayed((Duration(seconds: 1)));
    return "Data loaded";
  }
}
