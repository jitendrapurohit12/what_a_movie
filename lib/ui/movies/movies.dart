import 'package:flutter/material.dart';
import 'package:what_a_movie/bloc/movies_bloc.dart';
import 'package:what_a_movie/helper/method_helper.dart';
import 'package:what_a_movie/listener/movie_add_remove_listener.dart';
import 'package:what_a_movie/model/movie.dart';
import 'package:what_a_movie/ui/movie_list_ui.dart';

class Movies extends StatefulWidget {
  //const Movies({Key key}) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> implements MovieAddRemoveListener{
  MoviesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MoviesBloc();
    MethodHelper.isInternetAvailable(context);
    MethodHelper.isUserValid(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return Center(
                child: MovieListUI(snapshot.data, this),
              );
            } else {
              return Center(
                child: Text('no data found'),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  void add(Movie movie) {
    _bloc.addFavourite(movie);
  }

  @override
  void remove(Movie movie) {
    _bloc.removeFavourite(movie);
  }
}
