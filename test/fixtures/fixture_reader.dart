import 'dart:convert';
import 'dart:io';

import 'package:movie_app/features/movies/data/models/movie_model.dart';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync();

Future<List<MovieModel>> fixtureMovies(String name) async {
  final file = File('test/fixtures/$name').readAsStringSync();
  final d = await json.decode(file);
  return d.map<MovieModel>((e) => MovieModel.fromJson(e)).toList();
}
