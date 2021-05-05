import 'package:bloc_test/bloc_test.dart';
import 'package:{{cookiecutter.flutter_package_name}}/blocs/blocs.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

main() {
  final String successData = "Data loaded";
  final dynamic errorData = "Data error";

  group("HomeBloc", () {
    late HomeBloc homeBloc;
    late MockHomeRepository repository;
    setUp(() {
      repository = MockHomeRepository();
      homeBloc = HomeBloc(homeRepository: repository);
    });
    tearDown(() {
      homeBloc.close();
    });
    test("initial state is InitState", () {
      expect(homeBloc.state, InitState());
    });
    group("test event GetData", () {
      blocTest<HomeBloc, BaseState>(
        "emits [LoadingState, LoadedState] when GetData success",
        build: () {
          when(repository.getData()).thenAnswer((_) => Future.value(successData));
          return homeBloc;
        },
        act: (bloc) => bloc.add(GetData()),
        expect: () => [LoadingState(), LoadedState<String>(data: successData)],
      );
      blocTest<HomeBloc, BaseState>(
        "emits [LoadingState, ErrorState] when GetData failure",
        build: () {
          when(repository.getData()).thenThrow(errorData);
          return homeBloc;
        },
        act: (bloc) => bloc.add(GetData()),
        expect: () => [LoadingState(), ErrorState(data: errorData)],
      );
    });
  });
}
