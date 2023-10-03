import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/language_constants.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  void initState() {
    super.initState();
    Provider.of<SongViewModel>(context, listen: false).updateFavList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          elevation: 0,
          //systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Consumer<SongViewModel>(builder: (context, viewModel, child) {
          final songs = viewModel.favoriteList;
          return ListView.builder(
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
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
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
                              songs[index].trackName ??
                                  translation(context).unknownArtist,
                              style: Theme.of(context).textTheme.titleMedium,
                              textScaleFactor: 1.1,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                songs[index].artistName ??
                                    translation(context).unknownArtist,
                                style: Theme.of(context).textTheme.bodyMedium),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                songs[index].collectionName ??
                                    translation(context).unknownArtist,
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Provider.of<SongViewModel>(context, listen: false)
                            .toggleFavorite(songs[index]);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color:
                            Provider.of<SongViewModel>(context, listen: false)
                                    .isExist(songs[index])
                                ? Colors.pink
                                : Colors.grey,
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }));
  }
}
