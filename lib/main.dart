import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Xylophone(),
      ),
    );
  }
}

class Xylophone extends StatefulWidget {
  @override
  _XylophoneState createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  final audioCache = AudioCache();
  final audioPlayer = AudioPlayer();
  void playSound(int soundNumber) {
    audioCache.play('note$soundNumber.wav');
  }

  Expanded buildKey({MaterialColor color, int soundNumber}) {
    return Expanded(
      child: FlatButton(
        color: color,
        onPressed: () {
          playSound(soundNumber);
        },
        child: Text(
          'SOUND $soundNumber',
          style: TextStyle(color: color.shade800, fontSize: 20.0),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && Platform.isIOS) {
      audioPlayer.monitorNotificationStateChanges(audioPlayerHandler);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildKey(color: Colors.red, soundNumber: 1),
          buildKey(color: Colors.orange, soundNumber: 2),
          buildKey(color: Colors.yellow, soundNumber: 3),
          buildKey(color: Colors.green, soundNumber: 4),
          buildKey(color: Colors.teal, soundNumber: 5),
          buildKey(color: Colors.blue, soundNumber: 6),
          buildKey(color: Colors.purple, soundNumber: 7),
        ],
      ),
    );
  }
}

void audioPlayerHandler(AudioPlayerState value) => print('state => $value');
