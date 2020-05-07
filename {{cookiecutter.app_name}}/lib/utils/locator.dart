import 'package:{{cookiecutter.flutter_package_name}}/data/repository/repository.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HomeRepository());
}
