import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../../models/user_model.dart';
import 'post_model.dart';

@immutable
class CommentModel {
  final int id;
  final String body;
  final DateTime createdAt;
  final int? parentCommentId;
  final int userId;
  final int subjectId;
  final int childCommentsCount;
  final String url;
  final int postId;
  final String subjectType;
  final bool sticky;
  final int votes;
  final PostModel? post;
  final UserModel user;

  const CommentModel({
    required this.id,
    required this.body,
    required this.createdAt,
    this.parentCommentId,
    required this.userId,
    required this.subjectId,
    required this.childCommentsCount,
    required this.url,
    required this.postId,
    required this.subjectType,
    required this.sticky,
    required this.votes,
    this.post,
    required this.user,
  });

  CommentModel copyWith({
    int? id,
    String? body,
    DateTime? createdAt,
    int? parentCommentId,
    int? userId,
    int? subjectId,
    int? childCommentsCount,
    String? url,
    int? postId,
    String? subjectType,
    bool? sticky,
    int? votes,
    PostModel? post,
    UserModel? user,
  }) =>
      CommentModel(
        id: id ?? this.id,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        parentCommentId: parentCommentId ?? this.parentCommentId,
        userId: userId ?? this.userId,
        subjectId: subjectId ?? this.subjectId,
        childCommentsCount: childCommentsCount ?? this.childCommentsCount,
        url: url ?? this.url,
        postId: postId ?? this.postId,
        subjectType: subjectType ?? this.subjectType,
        sticky: sticky ?? this.sticky,
        votes: votes ?? this.votes,
        post: post ?? this.post,
        user: user ?? this.user,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'body': body,
        'created_at': createdAt.millisecondsSinceEpoch,
        'parent_comment_id': parentCommentId,
        'user_id': userId,
        'subject_id': subjectId,
        'child_comments_count': childCommentsCount,
        'url': url,
        'post_id': postId,
        'subject_type': subjectType,
        'sticky': sticky,
        'votes': votes,
        'post': post?.toMap(),
        'user': user.toMap(),
      };

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'] as int,
      body: map['body'] as String,
      createdAt: parseDateTime(map['created_at'] as Object),
      parentCommentId: getValueOrNull(map['parent_comment_id']),
      userId: map['user_id'] as int,
      subjectId: map['subject_id'] as int,
      childCommentsCount: map['child_comments_count'] as int,
      url: map['url'] as String,
      postId: map['post_id'] as int,
      subjectType: map['subject_type'] as String,
      sticky: map['sticky'] as bool,
      votes: map['votes'] as int,
      // post: PostModel.fromMap(map['post'] as Map<String, dynamic>),
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CommentModel(id: $id, body: $body, createdAt: $createdAt, parentCommentId: $parentCommentId, userId: $userId, subjectId: $subjectId, childCommentsCount: $childCommentsCount, url: $url, postId: $postId, subjectType: $subjectType, sticky: $sticky, votes: $votes, post: $post, user: $user)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CommentModel &&
        o.id == id &&
        o.body == body &&
        o.createdAt == createdAt &&
        o.parentCommentId == parentCommentId &&
        o.userId == userId &&
        o.subjectId == subjectId &&
        o.childCommentsCount == childCommentsCount &&
        o.url == url &&
        o.postId == postId &&
        o.subjectType == subjectType &&
        o.sticky == sticky &&
        o.votes == votes &&
        o.post == post &&
        o.user == user;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        body.hashCode ^
        createdAt.hashCode ^
        parentCommentId.hashCode ^
        userId.hashCode ^
        subjectId.hashCode ^
        childCommentsCount.hashCode ^
        url.hashCode ^
        postId.hashCode ^
        subjectType.hashCode ^
        sticky.hashCode ^
        votes.hashCode ^
        post.hashCode ^
        user.hashCode;
  }
}
