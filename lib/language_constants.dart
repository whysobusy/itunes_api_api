// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/api/media_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String CHINESE_SIMPLIFIED = 'zh_cn';
const String CHINESE_TRADITIONAL = 'zh_hk';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LAGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale('en', '');
    case CHINESE_SIMPLIFIED:
      return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans');
    case CHINESE_TRADITIONAL:
      return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
    default:
      return const Locale('en', '');
  }
}

String localeToLang(Locale locale) {
  switch (locale.languageCode) {
    case 'zh':
      if (locale.scriptCode == 'Hant') {
        return 'zh_hk';
      } else {
        return 'zh_cn';
      }
    case 'en':
    default:
      return 'en_us';
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}

String translateButton(BuildContext context, MediaType mediaType) {
  switch (mediaType) {
    case MediaType.musicArtist:
      return AppLocalizations.of(context)!.artist;
    case MediaType.musicTrack:
      return AppLocalizations.of(context)!.track;
    case MediaType.album:
      return AppLocalizations.of(context)!.album;
    case MediaType.musicVideo:
      return AppLocalizations.of(context)!.musicVideo;
    case MediaType.mix:
      return AppLocalizations.of(context)!.mix;
    case MediaType.song:
      return AppLocalizations.of(context)!.song;
    default:
      return AppLocalizations.of(context)!.all;
  }
}
