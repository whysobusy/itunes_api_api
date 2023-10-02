import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itunes_api_search_app/model/song.dart';
import 'package:itunes_api_search_app/ui/favorite_list.dart';
import 'package:itunes_api_search_app/ui/search_bar.dart';
import 'package:itunes_api_search_app/ui/setting_page.dart';
import 'package:itunes_api_search_app/ui/song_list_view.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  SongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Song> songs = Provider.of<SongViewModel>(context).songs;
    return Scaffold(
      key: _key,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Fav'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => FavoriteList())));
              },
            ),
            ListTile(
              title: const Text('Setting'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => Setting())));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
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
                  child: songs.isNotEmpty
                      ? SongListView(
                          songs: songs,
                        )
                      : Text('find')),
            ],
          )
        ],
      ),
    );
  }
}
