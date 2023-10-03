import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'song.freezed.dart';

@freezed
class Song with _$Song {
  const Song._();
  const factory Song({
    String? artistName,
    String? collectionName,
    String? trackName,
    String? artworkUrl100,
    String? previewUrl,
  }) = _Song;

  factory Song.fromJson(Map<String, dynamic> songJson) {
    return Song(
        artistName: songJson['artistName'] ?? "",
        collectionName: songJson['collectionName'] ?? "",
        trackName: songJson['trackName'] ?? "",
        artworkUrl100: songJson['artworkUrl100'] ?? "",
        previewUrl: songJson['previewUrl'] ?? "");
  }

  Map<String, dynamic> toMap() {
    return {
      "artistName": artistName,
      "collectionName": collectionName,
      'trackName': trackName,
      'artworkUrl100': artworkUrl100,
      'previewUrl': previewUrl
    };
  }
}
