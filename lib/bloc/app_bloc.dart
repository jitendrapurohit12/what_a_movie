import 'dart:async';
import 'package:what_a_movie/bloc/bloc_provider.dart';
import 'package:what_a_movie/shared_preferences/get_preferences.dart';

class AppBloc implements BlocBase {

  StreamController<bool> controller = StreamController<bool>();

  StreamSink<bool> get sink => controller.sink;

  Stream<bool> get stream => controller.stream;

  AppBloc() {
    getUser();
  }

  @override
  void dispose() {
    controller.close();
  }

  void getUser() async {
    bool isUserLoggedIn = await GetPreferences.getUserLoggedIn();
    sink.add(isUserLoggedIn);
  }
}
