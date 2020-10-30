import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_bloc.dart';

import 'movie_item_list.dart';

class MovieList extends StatefulWidget {
  final List<Movie> movies;

  const MovieList({Key key, @required this.movies}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int page = 8;

  @override
  Widget build(BuildContext context) {
    if (widget.movies == null) {
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Popular Movies'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.more),
              onPressed: () {
                print(page);
                setState(() {
                  page = page + 3;
                });
                BlocProvider.of<MovieBloc>(context)
                    .add(GetMostPopularMoviesEvent(page));
                Flushbar(
                  title: "Updating...$page",
                  message:
                      "Getting the lastest popular movies from The Movie Database platform.",
                  duration: Duration(seconds: 3),
                )..show(context);
              },
            )
          ],
        ),
        body: GridView.builder(
            padding: EdgeInsets.all(12),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.7),
            itemCount: widget.movies.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = widget.movies[index];
              return MovieItem(movie);
            }),
      );
    }
  }
}
