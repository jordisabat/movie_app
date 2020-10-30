import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies/domain/usecases/get_most_popular_movies.dart';
import 'package:movie_app/features/movies/presentation/bloc/movie_bloc.dart';

import '../../../fixtures/fixture_reader.dart';

class MockGetMostPopularMovies extends Mock implements GetMostPopularMovies {}

void main() async {
  // https://github.com/felangel/bloc/issues/587
  // ignore: close_sinks
  MovieBloc bloc;
  MockGetMostPopularMovies mockGetMostPopularMovies;
  setUp(() {
    mockGetMostPopularMovies = MockGetMostPopularMovies();
    bloc = MovieBloc(getMostPopularMovies: mockGetMostPopularMovies);
  });

  final tMovies = await fixtureMovies('movies.json');

  void setUpSuccessfullRequest() {
    when(mockGetMostPopularMovies(1)).thenAnswer((_) async => Right(tMovies));
  }

  void setUpServerFailureRequest() {
    when(mockGetMostPopularMovies(1))
        .thenAnswer((_) async => Left(ServerFailure()));
  }

  void setUpNetworkFailureRequest() {
    when(mockGetMostPopularMovies(1))
        .thenAnswer((_) async => Left(NetworkFailure()));
  }

  test(
    'initial state should be [Empty] ',
    () async {
      // assert
      expect(bloc.state, equals(Empty()));
    },
  );

  test(
    'should get data from the concrete use case',
    () async {
      // arrange
      setUpSuccessfullRequest();
      // act
      bloc.add(GetMostPopularMoviesEvent(1));
      await untilCalled(mockGetMostPopularMovies(1));
      // assert
      verify(mockGetMostPopularMovies(1));
    },
  );

  test(
    'should get data from the concrete use case',
    () async {
      // arrange
      setUpSuccessfullRequest();
      // act
      bloc.add(GetMostPopularMoviesEvent(1));
      await untilCalled(mockGetMostPopularMovies(1));
      // assert
      verify(mockGetMostPopularMovies(1));
    },
  );

  test(
    'should emit [Loading, Loaded] when data is gotten successfully',
    () async {
      // arrange
      setUpSuccessfullRequest();
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Loaded(movies: tMovies),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // assert
      bloc.add(GetMostPopularMoviesEvent(1));
    },
  );

  test(
    'should emit [Loading, Error] when data is gotten successfully',
    () async {
      // arrange
      setUpServerFailureRequest();
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // assert
      bloc.add(GetMostPopularMoviesEvent(1));
    },
  );
  test(
    'should emit [Loading, Error] with a proper message for the server error when getting data fails',
    () async {
      // arrange
      setUpServerFailureRequest();
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: SERVER_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // assert
      bloc.add(GetMostPopularMoviesEvent(1));
    },
  );

  test(
    'should emit [Loading, Error] with a proper message for the network error when getting data fails',
    () async {
      // arrange
      setUpNetworkFailureRequest();
      when(mockGetMostPopularMovies(1))
          .thenAnswer((_) async => Left(NetworkFailure()));
      // assert later
      final expected = [
        Empty(),
        Loading(),
        Error(message: NETWORK_FAILURE_MESSAGE),
      ];
      expectLater(bloc, emitsInOrder(expected));
      // act
      bloc.add(GetMostPopularMoviesEvent(1));
    },
  );
}
