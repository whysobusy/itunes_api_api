import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/api/media_type.dart';
import 'package:itunes_api_search_app/language_constants.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late final TextEditingController _textEditingController;
  MediaType? _mediaType;
  String? _country;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 9,
                child: TextField(
                  key: const Key('__searchTextField__'),
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: translation(context).searchHint,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _textEditingController.clear();
                      },
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () async {
                    if (_textEditingController.text.isNotEmpty) {
                      final song = _textEditingController.text;
                      await Provider.of<SongViewModel>(context, listen: false)
                          .getSongs(
                              searchTerm: song,
                              mediaType: _mediaType,
                              country: _country);
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  key: const Key('__searchButton__'),
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    if (_textEditingController.text.isNotEmpty) {
                      final song = _textEditingController.text;
                      await Provider.of<SongViewModel>(context, listen: false)
                          .getSongs(
                              searchTerm: song,
                              mediaType: _mediaType,
                              country: _country);
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
              ),
            ],
          ),
          DropdownButton<String>(
              items: MediaType.values.map((e) {
                return DropdownMenuItem<String>(
                  child: Text(e.name),
                  value: e.name,
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _mediaType = MediaType.values.byName(value!);
                });
              }),
          ElevatedButton(
            onPressed: () {
              showCountryPicker(
                context: context,
                onSelect: (Country country) {
                  print('Select country: ${country.countryCode}');
                  _country = country.countryCode;
                },
                // Optional. Sets the theme for the country list picker.
                countryListTheme: CountryListThemeData(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                  inputDecoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Start typing to search',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: const Text('Show country picker'),
          ),
        ],
      ),
    );
  }
}
