import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:itunes_api_search_app/api/song_remote_service.dart';
import 'package:itunes_api_search_app/model/song_dto.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fixtures/fixture_reader.dart';
import 'song_remote_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late http.Client mockHttpClient;
  late SongRemoteService songRemoteService;

  setUp(
    () {
      mockHttpClient = MockClient();
      songRemoteService = SongRemoteService(httpClient: mockHttpClient);
    },
  );

  group('fetchAlbum', () {
    const query = 'jack johnson';
    var uri = Uri.parse(
        "https://itunes.apple.com/search?term=jack+johnson&meida=music&lang=en_us&offset=20&limit=20");
    test('returns List<SongDTO> if the http call completes successfully',
        () async {
      when(mockHttpClient.get(uri)).thenAnswer(
          (_) async => http.Response(fixture("empty_body.json"), 200));

      expect(await songRemoteService.fetchSongs(query, lang: 'en_us'),
          isA<List<SongDTO>>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      when(mockHttpClient.get(uri))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      try {
        await songRemoteService.fetchSongs(query, lang: 'en_us');
      } catch (e) {
        expect(e, isInstanceOf<SongRequestException>());
      }
    });
  });
}
