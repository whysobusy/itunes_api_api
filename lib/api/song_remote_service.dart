import 'package:itunes_api_search_app/api/media_type.dart';
import 'package:itunes_api_search_app/model/song_dto.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SongRequestException implements Exception {}

class SongRemoteService {
  final http.Client _httpClient;
  static const _baseUrl = 'itunes.apple.com';

  SongRemoteService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  Future<List<SongDTO>> fetchSongs(String searchTerm,
      {MediaType? mediaType,
      String? country,
      int page = 1,
      int offset = 20,
      required String lang}) async {
    try {
      var songRequest = Uri.https(
        _baseUrl,
        'search',
        <String, String>{
          'term': searchTerm,
          'meida': 'music',
          if (mediaType != null) 'entity': mediaType.name,
          if (country != null) 'country': country,
          'lang': lang,
          'offset': (offset * page).toString(),
          'limit': '20',
        },
      );

      var songResponse = await _httpClient.get(songRequest);

      if (songResponse.statusCode != 200) {
        throw SongRequestException();
      }

      var songJson = json.decode(songResponse.body);
      final List<dynamic> results = songJson['results'];
      return results.map((json) => SongDTO.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
