import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/model/song.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Song> songs = Provider.of<SongViewModel>(context).favoriteList;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        elevation: 0,
        //systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: ListView.builder(
      itemCount: songs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          color: Colors.white,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          child: Row(
            children: [
              // Widget displaying the artwork of the song.
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: songs[index].artworkUrl100 != null
                        ? Image.network(
                            songs[index].artworkUrl100!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              'assets/no_artwork_available.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/no_artwork_available.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),

              // Widget displaying song name, artist name and album name.
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index].trackName ?? 'Unknown Track',
                        style: Theme.of(context).textTheme.subtitle1,
                        textScaleFactor: 1.1,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(songs[index].artistName ?? 'Unknown Artist',
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(songs[index].collectionName ?? 'Unknown Album',
                          style: Theme.of(context).textTheme.caption),
                          IconButton(onPressed: () {
                            Provider.of<SongViewModel>(context, listen: false).toggleFavorite(songs[index]);
                          }, icon: Icon(Icons.favorite)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ) 
    );
  }
}