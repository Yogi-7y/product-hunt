import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class UserModel {
  final int id;
  final DateTime createdAt;
  final String name;
  final String username;
  final String twitterUsername;
  final String headline;
  final String websiteUrl;
  final String profileUrl;
  final String imageUrl;

  const UserModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.twitterUsername,
    required this.username,
    required this.headline,
    required this.websiteUrl,
    required this.profileUrl,
    required this.imageUrl,
  });

  UserModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    String? twitterUsername,
    String? headline,
    String? websiteUrl,
    String? username,
    String? profileUrl,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      twitterUsername: twitterUsername ?? this.twitterUsername,
      username: username ?? this.username,
      headline: headline ?? this.headline,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      profileUrl: profileUrl ?? this.profileUrl,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'name': name,
        'username': username,
        'twitterUsername': twitterUsername,
        'headline': headline,
        'websiteUrl': websiteUrl,
        'profileUrl': profileUrl,
        'imageUrl': imageUrl,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      createdAt: DateTime.parse(map['created_at'] as String),
      name: map['name'] as String,
      username: map['username'] as String,
      twitterUsername: map['twitter_username'] as String,
      headline: map['headline'] as String,
      websiteUrl: map['website_url'] as String,
      profileUrl: map['profile_url'] as String,
      imageUrl: map['image_url']['original'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, createdAt: $createdAt, name: $name, twitterUsername: $twitterUsername, headline: $headline, websiteUrl: $websiteUrl, profileUrl: $profileUrl, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserModel &&
        o.id == id &&
        o.createdAt == createdAt &&
        o.name == name &&
        o.twitterUsername == twitterUsername &&
        o.headline == headline &&
        o.websiteUrl == websiteUrl &&
        o.profileUrl == profileUrl &&
        o.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        name.hashCode ^
        twitterUsername.hashCode ^
        headline.hashCode ^
        websiteUrl.hashCode ^
        profileUrl.hashCode ^
        imageUrl.hashCode;
  }
}
