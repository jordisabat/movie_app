import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/services/api_keys.dart';

import '../../domain/entities/movie.dart';

abstract class MovieDataSource {
  /// Calls The Movie Database endpoint
  /// http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key={api_key}
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<Movie>> getMostPopularMovies();
}

class MovieDataSourceImpl implements MovieDataSource {
  final http.Client client;
  MovieDataSourceImpl({
    @required this.client,
  });

  static const _url =
      "http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=";

  @override
  Future<List<Movie>> getMostPopularMovies() async {
    final url = '$_url${APIKeys.apiKey}';

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      return json
          .decode(response.body)
          .map<MovieModel>((e) => MovieModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
