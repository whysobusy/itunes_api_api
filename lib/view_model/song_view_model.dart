// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:itunes_api_search_app/api/media_type.dart';
import 'package:itunes_api_search_app/api/song_remote_repository.dart';
import 'package:itunes_api_search_app/favourite_share_pref.dart';
import 'package:itunes_api_search_app/language_constants.dart';
import 'package:itunes_api_search_app/model/song.dart';

class SongViewModel with ChangeNotifier {
  final SongRemoteRepository _songRepo;

  int page = 1;

  String? _searchTerm;
  MediaType? _mediaType;
  String? _country;

  String lang = 'en_US';

  List<Song> _songs = [];
  List<Song> get songs {
    return _songs;
  }

  List<Song> _favoriteList = [];
  List<Song> get favoriteList => _favoriteList;

  SongViewModel(this._songRepo);

  Future<void> getSongs(
      {String? searchTerm, MediaType? mediaType, String? country}) async {
    if (searchTerm == null) return;
    setSearchParam(searchTerm, mediaType, country);
    initPage();

    final result = await _songRepo.fetchSongs(searchTerm,
        mediaType: mediaType, country: country, lang: lang);
    result.fold(
        (exception) => {print(exception)}, (songsList) => {_songs = songsList});
    notifyListeners();
    increasePage();
  }

  Future<void> getNextPage() async {
    final result = await _songRepo.fetchSongs(_searchTerm!,
        mediaType: _mediaType, country: _country, page: page, lang: lang);
    result.fold((exception) => {print(exception)},
        (songsList) => {_songs.addAll(songsList), print(_songs.length)});
    notifyListeners();
    increasePage();
  }

  void toggleFavorite(Song fav) {
    final isExist = _favoriteList.contains(fav);
    if (isExist) {
      _favoriteList.remove(fav);
      setFav(_favoriteList);
    } else {
      _favoriteList.add(fav);
      setFav(_favoriteList);
    }
    notifyListeners();
  }

  void updateFavList() async {
    _favoriteList = await getFav();
    notifyListeners();
  }

  bool isExist(Song fav) {
    final isExist = _favoriteList.contains(fav);
    return isExist;
  }

  void setSearchParam(
      String searchTerm, MediaType? mediaType, String? country) {
    _searchTerm = searchTerm;
    _mediaType = mediaType;
    _country = country;
  }

  void setLang(Locale locale) {
    lang = localeToLang(locale);
  }

  void initPage() {
    page = 1;
  }

  void increasePage() {
    page += 1;
  }
}
