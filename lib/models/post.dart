import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  const Post({
    required this.content,
    required this.owner,
    required this.ownerPhotoURL,
    required this.createdAt,
    required this.updatedAt,
    required this.postCategory,
  });

  final String content;
  final String owner;
  final String ownerPhotoURL;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final String postCategory;

  

  Post copyWith({
    String? content,
    String? owner,
    String? ownerPhotoURL,
    Timestamp? createdAt,
    Timestamp? updatedAt,
    String? postCategory,
  }) {
    return Post(
      content: content ?? this.content,
      owner: owner ?? this.owner,
      ownerPhotoURL: ownerPhotoURL ?? this.ownerPhotoURL,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      postCategory: postCategory ?? this.postCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'owner': owner,
      'ownerPhotoURL': ownerPhotoURL,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'postCategory': postCategory,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      content: map['content'] as String,
      owner: map['owner'] as String,
      ownerPhotoURL: map['ownerPhotoURL'] as String,
      createdAt: map['createdAt'] as Timestamp,
      updatedAt: map['updatedAt'] as Timestamp,
      postCategory: map['postCategory'] as String,
    );
  }

}
