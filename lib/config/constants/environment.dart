import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMoviedbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'no_the_movie_key';
}
