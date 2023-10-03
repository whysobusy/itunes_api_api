import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:itunes_api_search_app/model/song.dart';

part 'song_dto.freezed.dart';
part 'song_dto.g.dart';

@freezed
class SongDTO with _$SongDTO {
  const SongDTO._();
  const factory SongDTO({
    String? artistName,
    String? collectionName,
    String? trackName,
    String? artworkUrl100,
    String? previewUrl,
  }) = _SongDTO;

  Song toDomain() => Song(
        artistName: artistName,
        collectionName: collectionName,
        trackName: trackName,
        artworkUrl100: artworkUrl100,
        previewUrl: previewUrl,
      );

  factory SongDTO.fromJson(Map<String, dynamic> json) =>
      _$SongDTOFromJson(json);
}
