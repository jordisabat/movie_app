import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/core/images/movie_db_images_provider.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.all(3.0),
          width: 210.0,
          //color: Colors.red,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                bottom: 5.0,
                child: Container(
                  height: 400.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: movie.voteAverage / 2,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '(${movie.voteCount})',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ]),
                child: Stack(
                  children: [
                    Hero(
                      tag: movie.id,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            MovieDbImagesProvider.getMovieDbImageThumbnail(
                                movie.backdropPath),
                            height: 150,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Positioned(
                      left: 6.0,
                      top: 6.0,
                      child: Text(
                        movie.voteAverage.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        // Container(
        //   child: Stack(
        //     children: [
        //       Container(
        //         height: MediaQuery.of(context).size.width,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(30.0),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black26,
        //               offset: Offset(0.0, 2.0),
        //               blurRadius: 6.0,
        //             ),
        //           ],
        //         ),
        //         child: Hero(
        //           tag: movie.id,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(12.0),
        //             child: CachedNetworkImage(
        //               imageUrl: MovieDbImagesProvider.getMovieDbImageThumbnail(
        //                   movie.posterPath),
        //               fit: BoxFit.cover,
        //             ),
        //           ),
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 5.0,
        //           vertical: 5.0,
        //         ),
        //         child: Text(
        //           movie.voteAverage.toString(),
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontWeight: FontWeight.bold,
        //           ),
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //       Positioned(
        //         bottom: 20.0,
        //         left: 20.0,
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text(
        //               movie.title,
        //               style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 35.0,
        //                 fontWeight: FontWeight.w600,
        //                 letterSpacing: 1.2,
        //               ),
        //             ),
        //             Text(
        //               movie.releaseDate,
        //               style: TextStyle(
        //                 color: Colors.white70,
        //                 fontSize: 20.0,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
