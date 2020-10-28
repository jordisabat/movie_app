import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Router;

import '../../../../core/images/movie_db_images_provider.dart';
import '../../domain/entities/movie.dart';
import '../pages/movie_details_page.dart';

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
        child: GridTile(
          footer: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: Text(
                  movie.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )),
          child: Stack(children: [
            Hero(
              tag: movie.id,
              child: CachedNetworkImage(
                imageUrl: MovieDbImagesProvider.getMovieDbImageThumbnail(
                    movie.posterPath),
              ),
            ),
            Positioned(
              top: 6,
              left: 6,
              child: Text(
                movie.voteAverage.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ));
  }
}
