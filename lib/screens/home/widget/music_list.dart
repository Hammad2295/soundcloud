import 'package:provider/provider.dart';
import 'package:souncloud_clone/models/song.dart';
import 'music_tile.dart';
import 'package:flutter/material.dart';

class MusicView extends StatefulWidget {
  const MusicView({super.key});

  @override
  State<MusicView> createState() => _MusicViewState();
}

class _MusicViewState extends State<MusicView> {
  @override
  Widget build(BuildContext context) {
    final songs = Provider.of<List<Song>>(context);
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return MusicTile(
          song: songs[index],
        );
      },
    );
  }
}
