import 'dart:convert';

import 'package:itunes_api_search_app/model/song.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String favCode = 'favCode';

Future<void> setFav(List<Song> songs) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString(favCode, encode(songs));
}

Future<List<Song>> getFav() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  final String songjson = await _prefs.getString(favCode)!;
  final List<Song> songList = decode(songjson);
  return songList;
}

String encode(List<Song> songs) => json.encode(
      songs.map<Map<String, dynamic>>((song) => song.toMap()).toList(),
    );

List<Song> decode(String songJson) => (json.decode(songJson) as List<dynamic>)
    .map<Song>((item) => Song.fromJson(item))
    .toList();
