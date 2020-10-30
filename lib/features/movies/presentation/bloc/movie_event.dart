part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetMostPopularMoviesEvent extends MovieEvent {
  final int page;

  GetMostPopularMoviesEvent(this.page) : super();

  @override
  List<Object> get props => null;
}
