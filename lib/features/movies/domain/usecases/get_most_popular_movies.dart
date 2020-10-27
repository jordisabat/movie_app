import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

class GetMostPopularMovies {
  final MovieRepository repository;

  GetMostPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getMostPopularMovies();
  }
}
