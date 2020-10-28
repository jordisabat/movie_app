import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/images/movie_db_images_provider.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_outline),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: 250,
              child: Hero(
                tag: movie.id,
                child: CachedNetworkImage(
                  imageUrl: MovieDbImagesProvider.getMovieDbImageHighQuality(
                      movie.backdropPath),
                  placeholder: (context, url) => Stack(
                    children: [
                      Image.asset('assets/images/placeholder_image.png'),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: 20,
                        child: Container(
                            child: Center(child: CircularProgressIndicator())),
                      ),
                    ],
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    RatingBarIndicator(
                      rating: movie.voteAverage / 2,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 30.0,
                    ),
                    SizedBox(height: 10),
                    Text('${movie.voteAverage} (${movie.voteCount})'),
                    SizedBox(height: 20),
                    Text(movie.overview)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
