import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifierProvider, List<Movie>>((ref) {
  final fetchMovie = ref.watch(movieRepositoryProvider);
  return MoviesNotifierProvider(fetchMovies: fetchMovie.getNowPlaying);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifierProvider, List<Movie>>((ref) {
  final fetchMovie = ref.watch(movieRepositoryProvider);
  return MoviesNotifierProvider(fetchMovies: fetchMovie.getPopular);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifierProvider, List<Movie>>((ref) {
  final fetchMovie = ref.watch(movieRepositoryProvider);
  return MoviesNotifierProvider(fetchMovies: fetchMovie.getUpcoming);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifierProvider, List<Movie>>((ref) {
  final fetchMovie = ref.watch(movieRepositoryProvider);
  return MoviesNotifierProvider(fetchMovies: fetchMovie.getTopRated);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifierProvider extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMovies;

  MoviesNotifierProvider({required this.fetchMovies}) : super([]);

  Future<void> loadnextPage() async {
    if (isLoading) {
      return;
    }

    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMovies(page: currentPage);

    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
