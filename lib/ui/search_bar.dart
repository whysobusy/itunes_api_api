import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({Key? key}) : super(key: key);

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  late final TextEditingController _textEditingController;

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              key: const Key('__searchTextField__'),
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Songs, albums or artists',
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
                  await Provider.of<SongViewModel>(context, listen: false).getSongs(song);
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
                  await Provider.of<SongViewModel>(context, listen: false).getSongs(song);
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}