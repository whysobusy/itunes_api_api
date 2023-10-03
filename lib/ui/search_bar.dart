import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/api/media_type.dart';
import 'package:itunes_api_search_app/language_constants.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late final TextEditingController _textEditingController;
  MediaType? _mediaType;
  Country? _country;
  String? _countryText;
  String? _mediaText;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  void _setCountryText(String value) {
    setState(() {
      _countryText = value;
    });
  }

  void _setMeidaText(String value) {
    setState(() {
      _mediaText = value;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(width: 0.2, color: Colors.grey))),
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
                              country: _country?.countryCode);
                      if (!context.mounted) return;

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
                              country: _country?.countryCode);
                      if (!context.mounted) return;

                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton<String>(
                  value: _mediaText,
                  hint: Text(
                    translation(context).media,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  underline: Container(
                    height: 1,
                    color: Colors.transparent,
                  ),
                  items: MediaType.values.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.name,
                      child: Text(translateButton(context, e)),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _mediaType = MediaType.values.byName(value!);
                      _setMeidaText(value);
                    });
                  }),
              TextButton(
                onPressed: () {
                  showCountryPicker(
                    context: context,
                    onSelect: (Country country) {
                      _country = country;
                      _setCountryText(_country!.nameLocalized!);
                    },
                    // Optional. Sets the theme for the country list picker.
                    countryListTheme: CountryListThemeData(
                      inputDecoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      _countryText ?? translation(context).country,
                      style:
                          const TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.brown,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(Icons.menu))
            ],
          )
        ],
      ),
    );
  }
}
