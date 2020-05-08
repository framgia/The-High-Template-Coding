import 'package:get_it/get_it.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/network/network.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Network());
  locator.registerLazySingleton(() => HomeRepository(locator<Network>()));
}
