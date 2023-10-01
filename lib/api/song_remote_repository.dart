import 'package:itunes_api_search_app/api/media_typ.dart';
import 'package:itunes_api_search_app/api/song_remote_service.dart';
import 'package:itunes_api_search_app/model/song.dart';

import 'package:dartz/dartz.dart';
import 'package:itunes_api_search_app/model/song_failure.dart';

class SongRemoteRepository {
  final SongRemoteService _songRemoteService;

  SongRemoteRepository(this._songRemoteService);

  Future<Either<SongFailure, List<Song>>> fetchSongs(String searchTerm, {MediaType mediaType = MediaType.all, String country = 'ca'}) async {
    try {
      var songDTOs = await _songRemoteService.fetchSongs(searchTerm, mediaType: mediaType,
      country: country);
      var songs = songDTOs.map((song) => song.toDomain()).toList();

      return right(songs);
    } catch (e) {
      //* log error or return error message
      return left(SongFailure.api(e.toString()));
    }
  }
}