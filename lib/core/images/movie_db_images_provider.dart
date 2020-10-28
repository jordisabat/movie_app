class MovieDbImagesProvider {
  static const String MOVIE_DB_IMAGES_PROVIDER_URI_BASE =
      'https://image.tmdb.org/t/p/';
  static const String HIGH_QUALITY = 'original';
  static const String LOW_QUALITY = 'w500';

  static String getMovieDbImageHighQuality(String image) {
    return '$MOVIE_DB_IMAGES_PROVIDER_URI_BASE/$HIGH_QUALITY/$image';
  }

  static String getMovieDbImageThumbnail(String image) {
    return '$MOVIE_DB_IMAGES_PROVIDER_URI_BASE/$LOW_QUALITY/$image';
  }
}
