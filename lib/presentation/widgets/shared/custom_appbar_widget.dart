import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';
import '../../delegates/search_movie_delegate.dart';
import '../../providers/providers.dart';

class CustomAppbarWidget extends ConsumerWidget {
  const CustomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
              ),
              const SizedBox(width: 6),
              Text(
                'Cinemapedia',
                style: textStyles.titleMedium,
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  // final movieRepProv = ref.read(movieRepositoryProvider);
                  final searchQuery = ref.read(searchQueryProvider);
                  final searchedMovies = ref.read(searchedMoviesProvider);

                  showSearch<Movie?>(
                    context: context,
                    query: searchQuery,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      searchMovies: ref
                          .read(searchedMoviesProvider.notifier)
                          .searchMoviesByQuery,
                    ),
                  ).then((movie) {
                    if (movie != null) {
                      context.push('/home/0/movie/${movie.id}');
                    }
                  });
                },
                icon: const Icon(Icons.search_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
