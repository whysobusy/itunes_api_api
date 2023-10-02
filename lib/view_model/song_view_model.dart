import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/api/media_typ.dart';
import 'package:itunes_api_search_app/api/song_remote_repository.dart';
import 'package:itunes_api_search_app/model/song.dart';

class SongViewModel with ChangeNotifier {
  final SongRemoteRepository _songRepo;

  int page = 1;

  String? _searchTerm;
  MediaType? _mediaType;
  String? _country;

  List<Song> _songs = [];
  List<Song> get songs {
    return _songs;
  }

  List<Song> _favoriteList = [];
  List<Song> get favoriteList => _favoriteList;

  SongViewModel(this._songRepo);

  Future<void> getSongs({String? searchTerm, MediaType mediaType = MediaType.all, String country = 'ca'}) async {
    if (searchTerm == null) return;
    setSearchParam(searchTerm, mediaType, country);
    initPage();

    final result = await  _songRepo.fetchSongs(searchTerm, mediaType: mediaType, country: country);
    result.fold((exception) => {
      print(exception)
    }, (songsList) => {
      _songs = songsList
      });
    notifyListeners();
    increasePage();
  }

  Future<void> getNextPage() async {
    print('next');
    final result = await  _songRepo.fetchSongs(_searchTerm!, mediaType: _mediaType, country: _country, page: page);
    result.fold((exception) => {
      print(exception)
    }, (songsList) => {
      _songs.addAll(songsList),
      print(_songs.length)
      });
    notifyListeners();
    increasePage();
  }

  void toggleFavorite(Song fav) {
    final isExist = _favoriteList.contains(fav);
    if (isExist) {
      _favoriteList.remove(fav);
    } else {
      _favoriteList.add(fav);
    }
    notifyListeners();
  }

  bool isExist(Song fav) {
    final isExist = _favoriteList.contains(fav);
    return isExist;
  }

  void clearFavorite() {
    _favoriteList = [];
    notifyListeners();
  }

  void setSearchParam(String searchTerm, MediaType mediaType, String country) {
    _searchTerm = searchTerm;
    _mediaType = mediaType;
    _country = country;
  }

  void initPage() {
    page = 1;
  }

  void increasePage() {
    page += 1;
  }

}