import 'package:flutter/material.dart' hide Router;
import 'package:movie_app/features/movies/domain/entities/movie.dart';

import 'movie_item_list.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({Key key, @required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (movies == null) {
      return const CircularProgressIndicator();
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: movies.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final movie = movies[index];
          return MovieItem(movie);
        },
      );
    }
  }
}
