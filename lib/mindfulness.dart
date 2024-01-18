import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'models/audio.dart';

class Mindfulness extends StatefulWidget {
  const Mindfulness({super.key});

  @override
  State<Mindfulness> createState() => _MindfulnessState();
}

class _MindfulnessState extends State<Mindfulness> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isplaying = false;
  String currentTitle = '';
  String currentCreator = '';
  String currentImageurl = '';
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  String FormatTime(Duration duration) {
    String TwoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = TwoDigits(duration.inHours);
    final minutes = TwoDigits(duration.inMinutes.remainder(60));
    final seconds = TwoDigits(duration.inSeconds.remainder(60));
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void initState() {
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
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio(
      String url, String title, String creator, String Imageurl) async {
    await audioPlayer.stop();
    await audioPlayer.play(UrlSource(url));
    setState(() {
      isplaying = true;
      currentCreator = creator;
      currentTitle = title;
      currentImageurl = Imageurl;
    });
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
    setState(() {
      isplaying = false;
    });
  }

  Future<void> pauseAudio() async {
    if (isplaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }

    setState(() {
      isplaying = !isplaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mindfulness"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 5.0),
              itemCount: audioList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await stopAudio();
                    await playAudio(
                        audioList[index].audioUrl,
                        audioList[index].title,
                        audioList[index].creator,
                        audioList[index].imageUrl);
                  },
                  child: GridTile(
                      child: Card(
                    elevation: 5.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(audioList[index].imageUrl,
                            height: 40, width: 40),
                        SizedBox(height: 8),
                        Text(audioList[index].title),
                        Text(audioList[index].creator)
                      ],
                    ),
                  )),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
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
                      max: duration.inSeconds.toDouble()),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(FormatTime(position))),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(FormatTime(duration))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => pauseAudio(),
                          icon: isplaying
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow)),
                      SizedBox(width: 75),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [Text(currentTitle), Text(currentCreator)],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
