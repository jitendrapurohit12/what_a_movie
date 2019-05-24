import 'package:flutter/material.dart';
import 'package:what_a_movie/model/movie.dart';
import 'package:what_a_movie/ui/home.dart';
import 'package:what_a_movie/ui/movie_details/movie_details.dart';
import 'package:what_a_movie/ui/sign_in/sign_in.dart';

class Navigation {
  static void homeAndClearBackStack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false);
  }

  static void signInAndClearBackStack(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
        (Route<dynamic> route) => false);
  }

  static void movieDetails(BuildContext context, Movie movie) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MovieDetails(movie)));
  }
}
