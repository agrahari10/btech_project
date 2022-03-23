import 'package:cloud_firestore/cloud_firestore.dart';

class StoryModel {
  final Timestamp createdAt;
  final String senderName;
  final String story;
  final String type;

  StoryModel({required this.createdAt, required this.senderName, required this.story, required this.type});
}