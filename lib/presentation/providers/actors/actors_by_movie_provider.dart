import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'actors_repository_provider.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final fetchActorsByMovie = ref.watch(actorsRepositoryProvider);
  return ActorByMovieNotifier(
    getActorsByMovie: fetchActorsByMovie.getActorsByMovie,
  );
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActorsByMovie;

  ActorByMovieNotifier({
    required this.getActorsByMovie,
  }) : super({});

  Future<void> loadActorsByMovie(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActorsByMovie(movieId);

    state = {...state, movieId: actors};
  }
}
