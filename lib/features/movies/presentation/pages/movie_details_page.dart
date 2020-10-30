import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/images/movie_db_images_provider.dart';

import 'package:movie_app/features/movies/domain/entities/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailPage({
    Key key,
    this.movie,
  }) : super(key: key);

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool _isFavourite = false;

  _onFavouriteSelected() {
    setState(() {
      _isFavourite = !_isFavourite;
    });
  }

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
                    Icons.favorite,
                    color: _isFavourite ? Colors.purple : Colors.white,
                  ),
                  onPressed: () {
                    // TODO: save to database
                    _onFavouriteSelected();
                  },
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
                title: Text(widget.movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Hero(
                  tag: widget.movie.id,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: MovieDbImagesProvider.getMovieDbImageHighQuality(
                        widget.movie.backdropPath),
                  ),
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
                rating: widget.movie.voteAverage / 2,
                itemBuilder: (context, index) =>
                    Icon(Icons.star, color: Colors.purple),
                itemCount: 5,
                itemSize: 30.0,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${widget.movie.voteAverage} (${widget.movie.voteCount})'),
                  Text('Release date: ${widget.movie.releaseDate}'),
                ],
              ),
              SizedBox(height: 20),
              Text(widget.movie.overview)
            ],
          ),
        ),
      ),
    );
  }
}
