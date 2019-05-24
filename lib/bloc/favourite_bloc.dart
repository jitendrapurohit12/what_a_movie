import 'dart:async';

import 'package:what_a_movie/bloc/bloc_provider.dart';
import 'package:what_a_movie/helper/db_helper/db_calls.dart';
import 'package:what_a_movie/model/movie.dart';
import 'package:what_a_movie/shared_preferences/get_preferences.dart';

class FavouriteBloc extends BlocBase {
  StreamController<List<Movie>> controller = StreamController();

  StreamSink<List<Movie>> get sink => controller.sink;

  Stream<List<Movie>> get stream => controller.stream;

  List<Movie> favList = List();

  FavouriteBloc() {
    fetchFavourites();
  }

  void removeFavourite(Movie movieToBeDeleted){
    favList.removeWhere((movie) => movie.id == movieToBeDeleted.id);
    sink.add(favList);
  }

  void fetchFavourites() async {
    int uid = await GetPreferences.getUserId();
    DBCalls.fetchAllFavouriteMovies(uid).then((list) {
      if(list != null)
      favList.addAll(list);
      favList.forEach((movie){
        movie.isFav = true;
      });
      sink.add(favList);
    });
  }

  @override
  void dispose() {
    controller.close();
  }
}
