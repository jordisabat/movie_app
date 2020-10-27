import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movies_repository.dart';
import 'package:movie_app/domain/usecases/get_most_popular_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  GetMostPopularMovies usecase;
  MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMostPopularMovies(mockMovieRepository);
  });

  final tMovieA = Movie(
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
          "A lowly utility worker is called to the future by a mysterious radio signal, he must leave his dying wife to embark on a journey that will force him to face his deepest fears in an attempt to change the fabric of reality and save humankind from its greatest environmental crisis yet.",
      releaseDate: "2020-10-01");

  final tMovieB = Movie(
    popularity: 2439.455,
    voteCount: 15,
    video: false,
    posterPath: "/ugZW8ocsrfgI95pnQ7wrmKDxIe.jpg",
    id: 724989,
    adult: false,
    backdropPath: "/86L8wqGMDbwURPni2t7FQ0nDjsH.jpg",
    originalLanguage: "en",
    originalTitle: "Hard Kill",
    genreIds: [28, 53],
    title: "Hard Kill",
    voteAverage: 3.7,
    overview:
        "The work of billionaire tech CEO Donovan Chalmers is so valuable that he hires mercenaries to protect it, and a terrorist group kidnaps his daughter just to get it.",
    releaseDate: "2020-10-23",
  );

  final tMovieC = Movie(
      popularity: 1570.599,
      voteCount: 122,
      video: false,
      posterPath: "/elZ6JCzSEvFOq4gNjNeZsnRFsvj.jpg",
      id: 741067,
      adult: false,
      backdropPath: "/aO5ILS7qnqtFIprbJ40zla0jhpu.jpg",
      originalLanguage: "en",
      originalTitle: "Welcome to Sudden Death",
      genreIds: [28, 12, 18, 53],
      title: "Welcome to Sudden Death",
      voteAverage: 6.4,
      overview:
          "Jesse Freeman is a former special forces officer and explosives expert now working a regular job as a security guard in a state-of-the-art basketball arena. Trouble erupts when a tech-savvy cadre of terrorists kidnap the team's owner and Jesse's daughter during opening night. Facing a ticking clock and impossible odds, it's up to Jesse to not only save them but also a full house of fans in this highly charged action thriller.",
      releaseDate: "2020-09-29");

  final tMovies = [tMovieA, tMovieB, tMovieC];

  test(
    'should get most popular movies from the repository',
    () async {
      // arrange
      when(mockMovieRepository.getMostPopularMovies())
          .thenAnswer((_) async => Right(tMovies));
      // act
      final movies = await usecase();
      // assert
      expect(movies, Right(tMovies));
      verify(mockMovieRepository.getMostPopularMovies());
    },
  );
}
