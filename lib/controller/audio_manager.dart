import 'dart:async';
import 'package:just_audio/just_audio.dart';

class AudioPlayerManager {
  static AudioPlayerManager? _instance;
  static AudioPlayerManager get instance =>
      _instance ??= AudioPlayerManager._init();
  AudioPlayerManager._init();

  final AudioPlayer _audioPlayer = AudioPlayer();
  AudioPlayer get audioPlayer => _audioPlayer;

  Future<void> setAudioSource(String url) async {
    await _audioPlayer.setUrl(url);
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<ProcessingState> get processingStateStream =>
      _audioPlayer.processingStateStream;
  Stream<SequenceState?> get sequenceStateStream =>
      _audioPlayer.sequenceStateStream;
  Stream<LoopMode> get loopModeStream => _audioPlayer.loopModeStream;

  bool get playing => _audioPlayer.playing;

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
