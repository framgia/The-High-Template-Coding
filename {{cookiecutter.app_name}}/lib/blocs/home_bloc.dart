import 'package:{{cookiecutter.flutter_package_name}}/blocs/base_bloc/base.dart';
import 'package:{{cookiecutter.flutter_package_name}}/data/repository/home_repository.dart';
import 'package:{{cookiecutter.flutter_package_name}}/utils/locator.dart';

class HomeBloc extends BaseBloc {
  final HomeRepository homeRepository;

  HomeBloc({HomeRepository homeRepository})
      : this.homeRepository = homeRepository ?? locator<HomeRepository>(),
        super(InitState());

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

//Event
class GetData extends BaseEvent {}
