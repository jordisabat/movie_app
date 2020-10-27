import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMovieModel = MovieModel(
    popularity: 2700.167,
    voteCount: 178,
    video: false,
    posterPath: "/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg",
    id: 528085,
    adult: false,
    backdropPath: "/5UkzNSOK561c2QRy2Zr4AkADzLT.jpg",
    originalLanguage: "en",
    originalTitle: "2067",
    genreIds: [18, 878, 53],
    title: "2067",
    voteAverage: 5.6,
    overview:
        'A lowly utility worker is called to the future by a mysterious radio signal...',
    releaseDate: "2020-10-01",
  );

  test(
    'should be a subclass of Movie entity',
    () async {
      // assert
      expect(tMovieModel, isA<Movie>());
    },
  );

  test(
    'should return a valid model',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('movie.json'));
      // act
      final result = MovieModel.fromJson(jsonMap);
      // assert
      expect(result, tMovieModel);
    },
  );

  test(
    'should return a JSON map containing the proper data',
    () async {
      // arrange
      final expectedMap = {
        "popularitaty": 2700.167,
        "voteCount": 178,
        "video": false,
        "posterPath": "/7D430eqZj8y3oVkLFfsWXGRcpEG.jpg",
        "id": 528085,
        "adult": false,
        "backdropPath": "/5UkzNSOK561c2QRy2Zr4AkADzLT.jpg",
        "originalLanguage": "en",
        "originalTitle": "2067",
        "genreIds": [18, 878, 53],
        "title": "2067",
        "voteAverage": 5.6,
        "overview":
            "A lowly utility worker is called to the future by a mysterious radio signal...",
        "releaseDate": "2020-10-01"
      };
      // act
      final result = tMovieModel.toJson();
      // assert
      expect(result, expectedMap);
    },
  );
}
