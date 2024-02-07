import 'package:flutter/material.dart';
import 'package:souncloud_clone/controller/audio_manager.dart';
import 'package:souncloud_clone/models/song.dart';

class MusicTile extends StatefulWidget {
  MusicTile({super.key, required this.song});

  final Song song;

  @override
  State<MusicTile> createState() => _MusicTileState();
}

class _MusicTileState extends State<MusicTile> {
  final audioPlayer = AudioPlayerManager.instance;
  IconData icon = Icons.play_arrow_rounded;

  void play() async {
    try {
      await audioPlayer.stop();
      await audioPlayer.setAudioSource(widget.song.fileUrl);
      audioPlayer.play();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.song.coverUrl!,
            ),
          ),
          title: Text(widget.song.title),
          subtitle: Text(widget.song.artist),
          trailing: IconButton(
            onPressed: () {
              audioPlayer.playing ? audioPlayer.stop() : play();
              setState(() {
                icon = icon == Icons.play_arrow_rounded
                    ? Icons.stop_circle_rounded
                    : Icons.play_arrow_rounded;
              });
            },
            icon: Icon(icon),
          ),
        ),
      ),
    );
  }
}
