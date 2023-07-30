import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../mappers/actor_mapper.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
      'api_key': Environment.theMoviedbKey,
      'language': 'es-MX',
    }),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final CreditsResponse creditsResponse =
        CreditsResponse.fromJson(response.data);
    final List<Actor> movies = creditsResponse.cast
        .map(
          (cast) => ActorMapper.castToActor(cast),
        )
        .toList();
    return movies;
  }
}
