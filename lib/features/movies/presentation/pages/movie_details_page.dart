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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                )
              ],
              elevation: 0,
              expandedHeight: MediaQuery.of(context).size.height / 1.5,
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: MovieDbImagesProvider.getMovieDbImageHighQuality(
                      movie.backdropPath),
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              RatingBarIndicator(
                rating: movie.voteAverage / 2,
                itemBuilder: (context, index) =>
                    Icon(Icons.star, color: Colors.purple),
                itemCount: 5,
                itemSize: 30.0,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${movie.voteAverage} (${movie.voteCount})'),
                  Text('Release date: ${movie.releaseDate}'),
                ],
              ),
              SizedBox(height: 20),
              Text(movie.overview)
            ],
          ),
        ),
      ),
    );
  }
}
