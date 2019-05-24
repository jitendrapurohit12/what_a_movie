import 'dart:async';

import 'package:what_a_movie/bloc/bloc_provider.dart';
import 'package:what_a_movie/helper/db_helper/db_calls.dart';
import 'package:what_a_movie/model/movie.dart';
import 'package:what_a_movie/shared_preferences/get_preferences.dart';

class MoviesBloc extends BlocBase {
  //variable for movies
  StreamController<List<Movie>> controller = StreamController();

  StreamSink<List<Movie>> get sink => controller.sink;

  Stream<List<Movie>> get stream => controller.stream;

  bool moviesFetched = false, favouritesFetched = false;
  List<Movie> movieList = List();
  List<Movie> favList = List();

  MoviesBloc() {
    fetchMovies();
    fetchFavourites();
  }

  @override
  void dispose() {
    controller.close();
  }

  void fetchMovies() async {
    DBCalls.fetchAllMovies().then((list) {
      moviesFetched = true;
      movieList.addAll(list);
      setFavourites();
    }).catchError((error) {
      sink.addError(error);
    });
  }

  void fetchFavourites() async {
    int uid = await GetPreferences.getUserId();
    DBCalls.fetchAllFavouriteMovies(uid).then((list) {
      favouritesFetched = true;
      if(list != null)
      favList.addAll(list);
      setFavourites();
    }).catchError((error){
      print(error.toString());
    });
  }

  void addFavourite(Movie movieToBeAdded){
    favList.add(movieToBeAdded);
    setFavourites();
  }

  void removeFavourite(Movie movieToBeRemoved){
    favList.removeWhere((movie)=> movie.id == movieToBeRemoved.id);
    setFavourites();
  }

  void setFavourites() {
    if(moviesFetched && favouritesFetched) {
      movieList.forEach((movie) {
        int index = movieList.indexOf(movie);
        if (favList.contains(movie)) {
          movieList[index].isFav = true;
        } else {
          movieList[index].isFav = false;
        }
      });
      sink.add(movieList);
    }
  }
}
