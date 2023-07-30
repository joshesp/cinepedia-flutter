import '../../domain/entities/actor.dart';
import '../models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToActor(Cast cast) => Actor(
        id: cast.id,
        name: cast.name,
        profilePath: cast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
            : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fvectorified.com%2Fimages%2Ffacebook-no-profile-picture-icon-18.png&f=1&nofb=1&ipt=1982525bc5dc382d40b43ae5f13ed3849dd8c64fd1b4e184e7c193908f05319a&ipo=images',
        character: cast.character,
      );
}
