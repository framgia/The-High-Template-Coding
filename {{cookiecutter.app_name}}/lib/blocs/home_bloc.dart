import 'package:flutter_template/blocs/base_bloc/base.dart';
import 'package:flutter_template/data/repository/home_repository.dart';
import 'package:flutter_template/utils/locator.dart';

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

//Event
class GetData extends BaseEvent {}
