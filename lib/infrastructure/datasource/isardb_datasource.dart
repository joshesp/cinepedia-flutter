import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsardbDatasource implements LocalStorageDatasource {
  late Future<Isar> db;

  IsardbDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationCacheDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int id) async {
    final isar = await db;

    final Movie? movie = isar.movies.filter().idEqualTo(id).findFirstSync();

    return movie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) async {
    final isar = await db;

    return isar.movies.where().offset(offset).limit(limit).findAllSync();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = isar.movies
        .filter()
        .idEqualTo(
          movie.id,
        )
        .findFirstSync();

    if (favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId));
    } else {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
    }
  }
}
