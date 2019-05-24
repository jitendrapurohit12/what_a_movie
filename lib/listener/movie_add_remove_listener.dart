import 'package:what_a_movie/model/movie.dart';

abstract class MovieAddRemoveListener{
  void add(Movie movie);
  void remove(Movie movie);
}