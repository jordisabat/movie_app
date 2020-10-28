import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_bloc.dart';

import 'movie_item_list.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({Key key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies == null) {
      return const CircularProgressIndicator();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Popular Movies'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                BlocProvider.of<MovieBloc>(context)
                    .add(GetMostPopularMoviesEvent());
                Flushbar(
                  title: "Updating...",
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
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final movie = movies[index];
              return MovieItem(movie);
            }),
      );
    }
  }
}
