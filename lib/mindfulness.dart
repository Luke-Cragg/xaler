import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/audio.dart';
import 'package:firebase_core/firebase_core.dart';

class Mindfulness extends StatefulWidget {
  const Mindfulness({Key? key}) : super(key: key);

  @override
  State<Mindfulness> createState() => _MindfulnessState();
}

class _MindfulnessState extends State<Mindfulness> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTitle = '';
  String currentCreator = '';
  String currentImageUrl = '';
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late Future<List<Audio>> _audioStream;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  Future<void> setMindfulnessChallenge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentChallenge = prefs.getString('lastChallenge') ?? '';
    if (currentChallenge == "View the mindfulness audios") {
      await prefs.setBool('ChallengeStatus', true);
    }
  }

  @override
  void initState() {
    Firebase.initializeApp(); // Initialize Firebase
    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
    super.initState();

    _audioStream = fetchAudioList();
    setMindfulnessChallenge();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  FutureBuilder<List<Audio>> _audioStreamBuilder() {
    return FutureBuilder(
        future: _audioStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error Streaming Data'));
          } else {
            List<Audio> audioList = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: audioList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await stopAudio();
                    await playAudio(
                      audioList[index].audioUrl,
                      audioList[index].title,
                      audioList[index].creator,
                      audioList[index].imageUrl,
                    );
                  },
                  child: GridTile(
                    child: Card(
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            audioList[index].imageUrl,
                            height: 100,
                            width: 140,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            audioList[index].title,
                            style: GoogleFonts.quicksand(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            audioList[index].creator,
                            style: GoogleFonts.quicksand(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        });
  }

  Future<void> playAudio(
      String url, String title, String creator, String imageUrl) async {
    await audioPlayer.stop();
    await audioPlayer.play(UrlSource(url)); // Play audio from URL
    setState(() {
      isPlaying = true;
      currentTitle = title;
      currentCreator = creator;
      currentImageUrl = imageUrl;
    });
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> pauseAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mindfulness"),
      ),
      body: Column(
        children: [
          Expanded(
            child: _audioStreamBuilder(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 130,
              width: double.infinity,
              child: Column(
                children: [
                  Slider(
                    value: position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final position = Duration(seconds: value.toInt());
                      await audioPlayer.seek(position);
                    },
                    min: 0,
                    max: duration.inSeconds.toDouble(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(formatTime(position)),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text(formatTime(duration)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => pauseAudio(),
                        icon: isPlaying
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                      ),
                      const SizedBox(width: 75),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(currentTitle),
                            Text(currentCreator),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
