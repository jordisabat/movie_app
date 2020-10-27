import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/network/network_info.dart';
import 'package:movie_app/features/movies/data/datasources/movie_data_source.dart';
import 'package:movie_app/features/movies/data/repositories/movie_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockMovieDataSource extends Mock implements MovieDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() async {
  MovieRepositoryImpl repository;
  MockMovieDataSource mockMovieDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockMovieDataSource = MockMovieDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
      datasource: mockMovieDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  test(
    'should check if the device is online',
    () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      await repository.getMostPopularMovies();
      // assert
      verify(mockNetworkInfo.isConnected);
    },
  );

  group('when device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test(
      'it should return data when the call to movie data source is successful',
      () async {
        // arrange
        final tMovies = await fixtureMovies('movies.json');
        when(mockMovieDataSource.getMostPopularMovies())
            .thenAnswer((_) async => tMovies);
        // act
        final result = await repository.getMostPopularMovies();
        // assert
        verify(mockMovieDataSource.getMostPopularMovies());
        expect(result, equals(Right(tMovies)));
      },
    );
    test(
      'it should return server failure when the call to movie data source is unsuccessful',
      () async {
        // arrange
        when(mockMovieDataSource.getMostPopularMovies())
            .thenThrow(ServerException());
        // act
        final result = await repository.getMostPopularMovies();
        // assert
        verify(mockMovieDataSource.getMostPopularMovies());
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('when device is offline', () {
    test(
      'it should return network failure when the device is offline',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // act
        final result = await repository.getMostPopularMovies();
        // assert
        expect(result, equals(Left(NetworkFailure())));
      },
    );
  });
}
