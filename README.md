# Itunes Api Search App

A Cross-platform Flutter app with iTunes API integration. This app follows the MVVM architectural pattern.

## Requirement
- Flutter SDK
- VSCode

## How to start

1. clone project to local

    ```bash
    git clone xxx
    ```

2. install [Flutter](https://flutter.io/docs/get-started/install)


3. build & run

    ```bash
    flutter run --profile
    ```
## Mobile Preview (Android)

| ![main_playlist](https://boyan01.github.io/quiet/mobile_main_playlist.png) | ![playlist detail](https://boyan01.github.io/quiet/mobile_playlist_detail.png) | ![add to playlist](https://boyan01.github.io/quiet/mobile_add_to_playlist.png) | ![artist_detail](https://boyan01.github.io/quiet/mobile_artist_detail.png) |
|:--------------------------------------------------------------------------:|:------------------------------------------------------------------------------:|:------------------------------------------------------------------------------:|:--------------------------------------------------------------------------:|

## Features
- Search Functionality: Users can enter keywords into the search bar to find song, albumn or artist, which includes filter options for country and media type.
- List View with Cards: The app retrieves and displays information about the searched content in a scrollable List View. Each item is presented as a card, showcasing details such as the artist, album, and cover image.
- Paging: The app implements paging functionality to limit the initial number of items displayed in the List View. Additional data is retrieved from the iTunes API as the user scrolls to the end of the list, ensuring a continuous browsing experience.
- Bookmarking: Users can bookmark their favorite songs by tapping an Icon button on each List View card. 
- Multi-language Support: The app is available in English, Traditional Chinese and Simplified Chinese
- Unit test: The test cases ensure that the SongRemoteService class returns the correct data.

## Possible Improvement
- UI test
- Integration test

