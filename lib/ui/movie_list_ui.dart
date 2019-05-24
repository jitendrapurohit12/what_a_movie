import 'package:flutter/material.dart';
import 'package:what_a_movie/dialogs/generic_dialogs.dart';
import 'package:what_a_movie/helper/db_helper/db_calls.dart';
import 'package:what_a_movie/helper/method_helper.dart';
import 'package:what_a_movie/helper/ui_helper.dart';
import 'package:what_a_movie/listener/movie_add_remove_listener.dart';
import 'package:what_a_movie/model/movie.dart';
import 'package:what_a_movie/navigation/navigation.dart';
import 'package:what_a_movie/shared_preferences/get_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieListUI extends StatefulWidget {
  final List<Movie> list;
  final MovieAddRemoveListener listener;

  const MovieListUI(this.list, this.listener);

  @override
  _MovieListUIState createState() => _MovieListUIState();
}

class _MovieListUIState extends State<MovieListUI> {
  List<Movie> list = List();

  @override
  void initState() {
    super.initState();

    list = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigation.movieDetails(context, list[index]),
            child: Container(
              margin:
                  EdgeInsets.only(top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
              height: MediaQuery.of(context).size.height / 3,
              child: Card(
                elevation: 8.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: list[index].thumbnail != null
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: list[index].thumbnail,
                                  placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      UIHelper.getImageErrorUI())
                              : UIHelper.getImageErrorUI()),
                    ),
                    list[index].thumbnail != null
                        ? Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black, Colors.black12])),
                            ),
                          )
                        : Container(),
                    Positioned(
                        bottom: 8.0,
                        left: 8.0,
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      list[index].name,
                                      style: TextStyle(
                                          color: list[index].thumbnail != null
                                              ? Colors.white
                                              : Colors.black45,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async{
                                        list[index].isFav
                                            ? removeFavourite(list[index])
                                            : setFavourite(list[index]);
                                    },
                                    child: Icon(
                                      list[index].isFav
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 24,
                                      color: list[index].thumbnail != null
                                          ? Colors.white
                                          : Colors.black45,
                                    ),
                                  ))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }

  setFavourite(Movie movie) async {

    bool isConnected = await MethodHelper.isInternetAvailable(context);
    bool isUserValid = await MethodHelper.isUserValid(context);

    if(isConnected && isUserValid) {
      GenericDialogs.progressDialog(context);
      int uid = await GetPreferences.getUserId();
      DBCalls.setFavourite(uid, movie).then((result) {
        widget.listener.add(movie);
        Navigator.pop(context);
      }).catchError((error) {
        Navigator.pop(context);
        GenericDialogs.errorDialog(context, error.toString());
      });
    }
  }

  removeFavourite(Movie movie) async {

    bool isConnected = await MethodHelper.isInternetAvailable(context);
    bool isUserValid = await MethodHelper.isUserValid(context);

    if(isConnected && isUserValid) {
      GenericDialogs.progressDialog(context);
      int uid = await GetPreferences.getUserId();
      DBCalls.removeFavourite(uid, movie).then((result) {
        widget.listener.remove(movie);
        Navigator.pop(context);
      }).catchError((error) {
        Navigator.pop(context);
        GenericDialogs.errorDialog(context, error.toString());
      });
    }
  }
}
