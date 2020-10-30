import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getMostPopularMovies(int page);
}
