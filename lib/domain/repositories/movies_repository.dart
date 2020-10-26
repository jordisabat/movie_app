import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMostPopularMovies();
}
