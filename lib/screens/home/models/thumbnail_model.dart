import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class Thumbnail {
  final int id;
  final String mediaType;
  final String imageUrl;

  const Thumbnail({
    required this.id,
    required this.mediaType,
    required this.imageUrl,
  });

  Thumbnail copyWith({
    int? id,
    String? mediaType,
    String? imageUrl,
  }) =>
      Thumbnail(
        id: id ?? this.id,
        mediaType: mediaType ?? this.mediaType,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'media_type': mediaType,
        'image_url': imageUrl,
      };

  factory Thumbnail.fromMap(Map<String, dynamic> map) => Thumbnail(
        id: map['id'] as int,
        mediaType: map['media_type'] as String,
        imageUrl: map['image_url'] as String,
      );

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Thumbnail(id: $id, mediaType: $mediaType, imageUrl: $imageUrl)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Thumbnail &&
        o.id == id &&
        o.mediaType == mediaType &&
        o.imageUrl == imageUrl;
  }

  @override
  int get hashCode => id.hashCode ^ mediaType.hashCode ^ imageUrl.hashCode;
}
