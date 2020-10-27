import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/features/movies/data/datasources/movie_data_source.dart';
import 'package:matcher/matcher.dart';
import 'package:movie_app/services/api_keys.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

main() async {
  MovieDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieDataSourceImpl(client: mockHttpClient);
  });

  final tMoviesModels = await fixtureMovies('movies.json');

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('api_response.json'), 200));
  }

  void setUpMockHttpClientSuccess404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  test(
    'should perform a GET request on a URL being the endpoint',
    () async {
      // arrange
      final movieUrl =
          'http://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=${APIKeys.apiKey}';

      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(fixture('api_response.json'), 200));
      // act
      dataSource.getMostPopularMovies();
      // assert
      verify(mockHttpClient.get(
        movieUrl,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      ));
    },
  );

  test(
    'should return List of Movies when the response code is 200 (success)',
    () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getMostPopularMovies();
      // assert
      expect(result, equals(tMoviesModels));
    },
  );

  test(
    'should throw a ServerException when the response code is 404 or other',
    () async {
      // arrange
      setUpMockHttpClientSuccess404();
      // act
      final call = dataSource.getMostPopularMovies;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    },
  );
}
