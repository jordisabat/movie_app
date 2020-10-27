import 'package:movie_app/features/movies/domain/entities/movie.dart';

abstract class MovieDataSource {
  /// Calls The Movie Database endpoint
  /// http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key={api_key}
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<Movie>> getMostPopularMovies();
}
