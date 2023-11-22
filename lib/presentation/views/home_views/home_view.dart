import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadnextPage();
    ref.read(popularMoviesProvider.notifier).loadnextPage();
    ref.read(upcomingMoviesProvider.notifier).loadnextPage();
    ref.read(topRatedMoviesProvider.notifier).loadnextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(initialLoadingProvider);

    if (isLoading) {
      return const FullLoaderWidget();
    }

    final moviesPlaying = ref.watch(moviesSlideshowProvider);
    final moviesNowPlaying = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return Visibility(
      visible: !isLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: CustomAppbarWidget(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    MoviesSlideshowWidget(
                      movies: moviesPlaying,
                    ),
                    MovieHorizontalListviewWidget(
                      movies: moviesNowPlaying,
                      title: 'En cines',
                      subtitle: 'Lun 20',
                      loadNextPage: () => ref
                          .read(nowPlayingMoviesProvider.notifier)
                          .loadnextPage(),
                    ),
                    MovieHorizontalListviewWidget(
                      movies: upcomingMovies,
                      title: 'Próximamente',
                      subtitle: 'Este mes',
                      loadNextPage: () => ref
                          .read(upcomingMoviesProvider.notifier)
                          .loadnextPage(),
                    ),
                    MovieHorizontalListviewWidget(
                      movies: popularMovies,
                      title: 'Populares',
                      loadNextPage: () => ref
                          .read(
                            popularMoviesProvider.notifier,
                          )
                          .loadnextPage(),
                    ),
                    MovieHorizontalListviewWidget(
                      movies: topRatedMovies,
                      title: 'Mejor calificadas',
                      subtitle: 'De la historia',
                      loadNextPage: () => ref
                          .read(topRatedMoviesProvider.notifier)
                          .loadnextPage(),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
