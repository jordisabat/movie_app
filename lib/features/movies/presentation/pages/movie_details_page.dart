import 'package:flutter/material.dart';

import 'package:movie_app/features/movies/domain/entities/movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailPage({
    Key key,
    this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Container(
        child: Text(movie.title),
      ),
    );
  }
}
