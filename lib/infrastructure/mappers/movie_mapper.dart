import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie fromMoviedb(MovieMoviebd moviedb) {
    return Movie(
      adult: moviedb.adult,
      backdropPath: moviedb.backdropPath.isNotEmpty
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : '',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount,
    );
  }
}
