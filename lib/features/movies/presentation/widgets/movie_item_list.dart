import 'package:flutter/material.dart' hide Router;
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/presentation/pages/movie_details_page.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  const MovieItem(
    this.movie,
  ) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetailPage(
                  movie: movie,
                )),
      ),
      child: Container(
        width: 20,
        padding: const EdgeInsets.all(6),
        child: Card(
          child: ListTile(
            title: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              movie.releaseDate,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
