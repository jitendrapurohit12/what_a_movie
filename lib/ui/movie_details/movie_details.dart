import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:what_a_movie/helper/ui_helper.dart';
import 'package:what_a_movie/model/movie.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;

  const MovieDetails(this.movie);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie movie;

  @override
  void initState() {
    super.initState();
    movie = widget.movie;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white30,
        centerTitle: true,
        title: Text(movie.name, overflow: TextOverflow.ellipsis),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(8.0, 60.0, 8.0, 8.0),
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width / 1,
              child: Card(
                elevation: 8.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 140),
                    UIHelper.getMovieDescriptionColumn(
                        'Featuring ', movie.mainStar),
                    UIHelper.getMovieDescriptionColumn(
                        'Directed By', movie.director),
                    UIHelper.getMovieDescriptionColumn(
                        'Release Year', movie.year.toString()),
                    Wrap(
                      children: movie.gentres
                          .map((t) => Padding(
                                padding: EdgeInsets.only(left: 2.0, right: 2.0),
                                child: FilterChip(
                                    backgroundColor: Colors.amber,
                                    label: Text(t.name),
                                    onSelected: (b) {}),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: movie.description != null
                          ? Text(movie.description,
                              style: TextStyle(color: Colors.grey))
                          : Container(),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 10,
              left: MediaQuery.of(context).size.width / 2 - 90,
              child: Container(
                width: 180,
                height: 180,
                child: Card(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: movie.thumbnail != null
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: movie.thumbnail,
                              placeholder: (context, url) => Center(
                                    child: CircularProgressIndicator(),
                                  ),
                              errorWidget: (context, url, error) =>
                                  UIHelper.getImageErrorUI())
                          : UIHelper.getImageErrorUI()),
                ),
              ))
        ],
      ),
    );
  }
}
