import 'dart:convert';

import 'package:what_a_movie/constants/db_constants.dart';
import 'package:http/http.dart' as http;
import 'package:what_a_movie/model/movie.dart';
import 'package:what_a_movie/model/user.dart';
import 'package:what_a_movie/model/user_register.dart';

class DBCalls {
  static Future<User> register(String username) async {
    Username userObj = Username();
    userObj.username = username;
    UserRegister userRegister = UserRegister();
    userRegister.username = userObj;

    return new http.Client()
        .post(DBConstants.getUserRegistration(),
            headers: {'Content-type': 'application/json'},
            body: json.encoder.convert(userRegister.toJson()))
        .then((http.Response r) {
      if (r.statusCode == 200) {
        return User.fromJson(json.decode(r.body));
      } else if (r.statusCode == 422) {
        return null;
      } else {
        throw Exception('Failed to register');
      }
    });
  }

  static Future<User> signIn(String username) async{
    final response = await http.get(DBConstants.getUser(username));

    if (response.statusCode == 200) {
      User user;
      if(json.decode(response.body).length > 0) {
        json.decode(response.body).forEach((json) {
          user = User.fromJson(json);
        });
      }
      return user;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load user');
    }
  }

  static Future<List<Movie>> fetchAllMovies() async {
    final response = await http.get(DBConstants.allMovies);

    if (response.statusCode == 200) {
      List<Movie> list = List();
      json.decode(response.body).forEach((json){
        list.add(Movie.fromJson(json));
      });
      return list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load movies');
    }
  }

  static Future<List<Movie>> fetchAllFavouriteMovies(int uid) async {
    final response = await http.get(DBConstants.favourites(uid));

    if (response.statusCode == 200) {
      List<Movie> list = List();
      json.decode(response.body).forEach((json){
        list.add(Movie.fromJson(json));
      });
      return list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load favourite movies');
    }
  }

  static Future<Movie> setFavourite(int uid, Movie movie) async{
    final response = await http.get(DBConstants.addToFavourite(uid, movie.id));

    if (response.statusCode == 200) {
      return movie;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to favourite given movie');
    }
  }

  static Future<Movie> removeFavourite(int uid, Movie movie) async{
    final response = await http.get(DBConstants.removeFromFavourite(uid, movie.id));

    if (response.statusCode == 200) {
      return movie;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to unfavourite given movie');
    }
  }
}
