import 'package:cloud_firestore/cloud_firestore.dart';

class ReflectModel {
  final String? id;
  final String? email;
  final String? title;
  final String? category;
  final String? content;
  final String? content_response;

  final String? address;
  final List<dynamic>? media;

  // final List<dynamic>? likes;

  final bool? accept;
  final int? handle;
  final Timestamp? createdAt;

  const ReflectModel({
    this.id,
    required this.email,
    // required this.likes,
    required this.title,
    required this.category,
    required this.content,
    required this.address,
    required this.media,
    required this.accept,
    required this.handle,
    required this.createdAt,
    required this.content_response,
  });

  toJson() {
    return {
      "email": email,
      "title": title,
      "category": category,
      "content": content,
      "address": address,
      "media": media,
      "accept": accept,
      "handle": handle,
      // "Likes": likes,
      "createdAt": createdAt,
      "contentfeedback": content_response
    };
  }

  factory ReflectModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReflectModel(
        id: document.id,
        email: data["email"],
        title: data["title"],
        category: data["category"],
        content: data["content"],
        address: data["address"],
        media: data["media"],
        accept: data["accept"],
        handle: data["handle"],
        createdAt: data["createdAt"],
        // likes: data["Likes"],
        content_response: data["contentresponse"]);
  }
}