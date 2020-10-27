import 'package:movie_app/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    double popularity,
    int voteCount,
    bool video,
    String posterPath,
    int id,
    bool adult,
    String backdropPath,
    String originalLanguage,
    String originalTitle,
    List<int> genreIds,
    String title,
    double voteAverage,
    String overview,
    String releaseDate,
  }) : super(
          popularity: popularity,
          voteCount: voteCount,
          video: video,
          posterPath: posterPath,
          id: id,
          adult: adult,
          backdropPath: backdropPath,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          genreIds: genreIds,
          title: title,
          voteAverage: voteAverage,
          overview: overview,
          releaseDate: releaseDate,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      popularity: json['popularity'].toDouble(),
      voteCount: json['vote_count'],
      video: json['video'],
      posterPath: json['poster_path'],
      id: json['id'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      genreIds: json['genre_ids'] != null
          ? new List<int>.from(json['genre_ids'])
          : [],
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
      overview: json['overview'],
      releaseDate: json['release_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'popularitaty': popularity,
      'voteCount': voteCount,
      'video': video,
      'posterPath': posterPath,
      'id': id,
      'adult': adult,
      'backdropPath': backdropPath,
      'originalLanguage': originalLanguage,
      'originalTitle': originalTitle,
      'genreIds': genreIds,
      'title': title,
      'voteAverage': voteAverage,
      'overview': overview,
      'releaseDate': releaseDate,
    };
  }
}
