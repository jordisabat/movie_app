import 'package:dartz/dartz.dart';
import 'package:movie_app/core/failures.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';

class GetMostPopularMovies {
  final MovieRepository repository;

  GetMostPopularMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() async {
    return await repository.getMostPopularMovies();
  }
}
