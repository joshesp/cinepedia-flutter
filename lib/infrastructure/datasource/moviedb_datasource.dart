import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

import '../mappers/movie_mapper.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.theMoviedbKey,
      'language': 'es-MX',
    }),
  );

  List<Movie> _mapResponse(Map<String, dynamic> response) {
    final MoviedbResponse moviesResponse = MoviedbResponse.fromJson(response);
    final List<Movie> movies = moviesResponse.results
        .where(
          (moviedb) => moviedb.posterPath.isNotEmpty,
        )
        .map(
          (moviedb) => MovieMapper.fromMoviedb(moviedb),
        )
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      '/movie/now_playing',
      queryParameters: {'page': page},
    );

    return _mapResponse(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      '/movie/popular',
      queryParameters: {'page': page},
    );

    return _mapResponse(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      '/movie/upcoming',
      queryParameters: {'page': page},
    );

    return _mapResponse(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      '/movie/top_rated',
      queryParameters: {'page': page},
    );

    return _mapResponse(response.data);
  }
}
