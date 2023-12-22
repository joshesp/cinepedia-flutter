import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class IsardbDatasource implements LocalStorageDatasource {
  @override
  Future<bool> isMovieFAvorite(int id) {
    // TODO: implement isMovieFAvorite
    throw UnimplementedError();
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, int offset = 0}) {
    // TODO: implement loadMovies
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }
}
