import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/language_constants.dart';
import 'package:itunes_api_search_app/model/song.dart';
import 'package:itunes_api_search_app/view_model/song_view_model.dart';
import 'package:provider/provider.dart';

class SongListView extends StatefulWidget {
  final List<Song> songs;
  const SongListView({
    Key? key,
    required this.songs,
  }) : super(key: key);

  @override
  State<SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<SongListView> {
  final scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (isLoading) return;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<SongViewModel>(context, listen: false).getNextPage();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: isLoading ? widget.songs.length + 1 : widget.songs.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index < widget.songs.length) {
          return Card(
            elevation: 0.5,
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
                      child: widget.songs[index].artworkUrl100 != null
                          ? Image.network(
                              widget.songs[index].artworkUrl100!,
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
                          widget.songs[index].trackName ??
                              translation(context).unknownTrack,
                          style: Theme.of(context).textTheme.titleMedium,
                          textScaleFactor: 1.1,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            widget.songs[index].artistName ??
                                translation(context).unknownArtist,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            widget.songs[index].collectionName ??
                                translation(context).unknownAlbumn,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),

                IconButton(
                    onPressed: () {
                      Provider.of<SongViewModel>(context, listen: false)
                          .toggleFavorite(widget.songs[index]);
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Provider.of<SongViewModel>(context, listen: false)
                              .isExist(widget.songs[index])
                          ? Colors.pink
                          : Colors.grey,
                    )),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
