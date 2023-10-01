import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/api/media_typ.dart';
import 'package:itunes_api_search_app/api/song_remote_repository.dart';
import 'package:itunes_api_search_app/model/song.dart';

class SongViewModel with ChangeNotifier {
  final SongRemoteRepository _songRepo;

  List<Song> _songs = [];
  List<Song> get songs {
    return _songs;
  }

  SongViewModel(this._songRepo);

  Future<void> getSongs(String searchTerm, {MediaType mediaType = MediaType.all, String country = 'ca'}) async {
    final result = await  _songRepo.fetchSongs(searchTerm, mediaType: mediaType, country: country);
    result.fold((exception) => {
      print(exception)
    }, (songsList) => {
      _songs = songsList
      });
    notifyListeners();
  }
}