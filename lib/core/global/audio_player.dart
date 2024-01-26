import 'package:audioplayers/audioplayers.dart';

class AudioPlayerSingleton {
  static final AudioPlayerSingleton _instance =
      AudioPlayerSingleton._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();

  factory AudioPlayerSingleton() {
    return _instance;
  }

  AudioPlayer get audioPlayer => _audioPlayer;

  AudioPlayerSingleton._internal();
}
