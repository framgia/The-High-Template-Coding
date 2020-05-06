class HomeRepository {
  //example call api to get data
  Future<String> getData() async {
    await Future.delayed((Duration(seconds: 3)));
    return "Data loaded";
  }
}
