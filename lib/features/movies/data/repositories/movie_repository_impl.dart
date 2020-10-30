import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/core/error/exceptions.dart';

import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/features/movies/data/datasources/movie_data_source.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDataSource datasource;
  final NetworkInfo networkInfo;
  MovieRepositoryImpl({
    @required this.datasource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Movie>>> getMostPopularMovies(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await datasource.getMostPopularMovies(page);
        return Right(movies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
