import 'package:flutter/material.dart';

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
}

final List<Audio> audioList = [
  Audio(
    id: '1',
    creator: 'Kieran Fleck',
    title: 'Sitting Meditation',
    audioUrl:
        'https://drive.google.com/uc?export=view&id=1Ip7JEkmvZetfK6SJgAtjm2rUC0RRH9Nz',
    imageUrl:
        'https://images.unsplash.com/photo-1702277854835-0f25f1565ae1?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    isRecommended: true,
  ),
  Audio(
    id: '2',
    creator: "Melbourne Mindfulness Centre",
    title: '4 Minute Body Scan',
    audioUrl:
        'https://drive.google.com/uc?export=view&id=1kt-ORI3Kkf2onwpnLoIzwGKxkIEh7W6L',
    imageUrl:
        'https://images.unsplash.com/photo-1575275400619-80ea3bb088b6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  ),
  Audio(
    id: '3',
    creator: 'Vidyamala Burch',
    title: 'Tension Release Meditation',
    audioUrl:
        'https://drive.google.com/uc?export=view&id=1dcsW9byG8G4Gyb1hFvtFS27LnrBdfvDA',
    imageUrl:
        'https://images.unsplash.com/photo-1528715471579-d1bcf0ba5e83?q=80&w=2093&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  )
];
