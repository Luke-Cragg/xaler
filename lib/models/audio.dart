import 'package:cloud_firestore/cloud_firestore.dart';

class Audio {
  final String id;
  final String creator;
  final String title;
  final String imageUrl;
  final String? audioPath;
  final String audioUrl;
  final bool isRecommended;

  Audio({
    this.id = '',
    required this.creator,
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
    this.audioPath,
    this.isRecommended = false,
  }) : assert(audioUrl != null || audioPath != null);

  factory Audio.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Audio(
      id: data['id'] ?? '',
      creator: data['creator'] ?? '',
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      audioUrl: data['audioUrl'] ?? '',
      isRecommended: data['isRecommended'] ?? false,
    );
  }
}

Future<List<Audio>> fetchAudioList() async {
  List<Audio> audioList = [];
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Audio').get();
    for (var doc in querySnapshot.docs) {
      audioList.add(Audio.fromFirestore(doc));
    }
  } catch (e) {
    print('Error fetching audio list from DB: $e');
  }
  return audioList;
}
