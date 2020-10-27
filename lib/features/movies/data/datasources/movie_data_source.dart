import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/features/movies/data/models/api_response.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/services/api_keys.dart';

abstract class MovieDataSource {
  /// Calls The Movie Database endpoint
  /// http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key={api_key}
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<MovieModel>> getMostPopularMovies();
}

class MovieDataSourceImpl implements MovieDataSource {
  final http.Client client;
  MovieDataSourceImpl({
    @required this.client,
  });

  static const _url =
      "http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=";

  @override
  Future<List<MovieModel>> getMostPopularMovies() async {
    final url = '$_url${APIKeys.apiKey}';

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      final apiResponse = ApiResponse.fromJson(json.decode(response.body));
      return apiResponse.results;
    } else {
      throw ServerException();
    }
  }
}
