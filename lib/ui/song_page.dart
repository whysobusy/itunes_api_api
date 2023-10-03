import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/language_constants.dart';
import 'package:itunes_api_search_app/ui/favorite_list.dart';
import 'package:itunes_api_search_app/ui/search_bar.dart';
import 'package:itunes_api_search_app/ui/setting_page.dart';
import 'package:itunes_api_search_app/ui/song_list_view.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  SongPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Icon(Icons.music_note),
            ),
            ListTile(
              title: Text(translation(context).favourite),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const FavoriteList())));
              },
            ),
            ListTile(
              title: Text(translation(context).setting),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => const Setting())));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const MySearchBar(),
              Consumer<SongViewModel>(builder: (context, viewModel, child) {
                return Expanded(
                  child: viewModel.songs.isNotEmpty
                      ? SongListView(
                          songs: viewModel.songs,
                        )
                      : const Center(
                          child: Icon(Icons.bar_chart),
                        ),
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
