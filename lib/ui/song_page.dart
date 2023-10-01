import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itunes_api_search_app/model/song.dart';
import 'package:itunes_api_search_app/ui/search_bar.dart';
import 'package:itunes_api_search_app/ui/song_list_view.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Provider.of<SongViewModel>(context).songs;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Music Search',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const MySearchBar(),
              Expanded(
                child: songs.isNotEmpty ? SongListView(songs: songs,) : Text('find')
              ),
            ],
          )
        ],
      ),
    );
  }
}