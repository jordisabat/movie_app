import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_most_popular_movies.dart';

part 'movie_event.dart';
part 'movie_state.dart';

// Todo: add error code (ex. server_failure = 100) to localize it within the UI (widgets)
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMostPopularMovies getMostPopularMovies;

  MovieBloc({
    @required this.getMostPopularMovies,
  }) : super(Empty());

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (event is GetMostPopularMoviesEvent) {
      yield state;
      yield Loading();
      final failureOrGetMovies = await getMostPopularMovies();
      yield failureOrGetMovies.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (movies) => Loaded(movies: movies),
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
