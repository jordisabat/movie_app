part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends MovieState {}

class Loading extends MovieState {}

class Loaded extends MovieState {
  final List<Movie> movies;
  Loaded({@required this.movies}) : super();
}

class Error extends MovieState {
  final String message;
  Error({@required this.message}) : super();
}
