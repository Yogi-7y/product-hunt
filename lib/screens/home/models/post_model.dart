import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../models/user_model.dart';
import 'screenshot_model.dart';
import 'thumbnail_model.dart';
import 'topic_model.dart';

@immutable
class PostModel {
  final int id;
  final int? commentsCount;
  final String name;
  final String productState;
  final String tagline;
  final String slug;
  final int? votesCount;
  final int? categoryId;
  final DateTime createdAt;
  final String discussionUrl;
  final bool? exclusive;
  final bool? featured;
  final bool? iosFeaturedAt;
  final bool? makerInside;
  final Screenshot? screenshotUrl;
  final List<UserModel> makers;
  final String redirectUrl;
  final Thumbnail thumbnail;
  final List<Topic> topics;
  final UserModel userModel;

  const PostModel({
    required this.id,
    required this.name,
    required this.productState,
    required this.makers,
    required this.redirectUrl,
    required this.thumbnail,
    required this.topics,
    required this.userModel,
    required this.tagline,
    required this.createdAt,
    required this.discussionUrl,
    required this.slug,
    this.votesCount,
    this.categoryId,
    this.commentsCount,
    this.exclusive,
    this.featured,
    this.iosFeaturedAt,
    this.makerInside,
    this.screenshotUrl,
  });

  PostModel copyWith({
    int? id,
    int? commentsCount,
    String? name,
    String? productState,
    String? tagline,
    String? slug,
    int? votesCount,
    int? categoryId,
    DateTime? createdAt,
    String? discussionUrl,
    bool? exclusive,
    bool? featured,
    bool? iosFeaturedAt,
    bool? makerInside,
    Screenshot? screenshotUrl,
    List<UserModel>? makers,
    String? redirectUrl,
    Thumbnail? thumbnail,
    List<Topic>? topics,
    UserModel? userModel,
  }) =>
      PostModel(
        id: id ?? this.id,
        commentsCount: commentsCount ?? this.commentsCount,
        name: name ?? this.name,
        productState: productState ?? this.productState,
        tagline: tagline ?? this.tagline,
        slug: slug ?? this.slug,
        votesCount: votesCount ?? this.votesCount,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        discussionUrl: discussionUrl ?? this.discussionUrl,
        exclusive: exclusive ?? this.exclusive,
        featured: featured ?? this.featured,
        iosFeaturedAt: iosFeaturedAt ?? this.iosFeaturedAt,
        makerInside: makerInside ?? this.makerInside,
        screenshotUrl: screenshotUrl ?? this.screenshotUrl,
        makers: makers ?? this.makers,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        thumbnail: thumbnail ?? this.thumbnail,
        topics: topics ?? this.topics,
        userModel: userModel ?? this.userModel,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'comments_count': commentsCount,
        'name': name,
        'product_state': productState,
        'redirect_url': redirectUrl,
        'tagline': tagline,
        'slug': slug,
        'votes_count': votesCount,
        'category_id': categoryId,
        'created_at': createdAt.toString(),
        'discussion_url': discussionUrl,
        'exclusive': exclusive,
        'featured': featured,
        'ios_featured_at': iosFeaturedAt,
        'maker_inside': makerInside,
        'thumbnail': thumbnail.toMap(),
        'user': userModel.toMap(),
        'screenshot_url': screenshotUrl?.toMap() ?? <String, dynamic>{},
        'makers': makers.map((e) => e.toMap()).toList(),
        'topics': topics.map((e) => e.toMap()).toList(),
      };

  factory PostModel.fromMap(Map<String, dynamic> map) {
    final _categoryId = getValueOrNull<int>(map['category_id']);
    final _exclusive = getValueOrNull<bool>(map['exclusive']);
    final _featured = getValueOrNull<bool>(map['featured']);
    final _iosFeaturedAt = getValueOrNull<bool>(map['ios_featured_at']);
    final _makerInside = getValueOrNull<bool>(map['maker_inside']);

    return PostModel(
      id: map['id'] as int,
      commentsCount: map['comments_count'] as int,
      name: map['name'] as String,
      productState: map['product_state'] as String,
      redirectUrl: map['redirect_url'] as String,
      tagline: map['tagline'] as String,
      slug: map['slug'] as String,
      votesCount: map['votes_count'] as int,
      categoryId: _categoryId,
      createdAt: DateTime.parse(map['created_at'] as String),
      discussionUrl: map['discussion_url'] as String,
      exclusive: _exclusive,
      featured: _featured,
      iosFeaturedAt: _iosFeaturedAt,
      makerInside: _makerInside,
      thumbnail: Thumbnail.fromMap(map['thumbnail'] as Map<String, dynamic>),
      userModel: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      screenshotUrl:
          Screenshot.fromMap(map['screenshot_url'] as Map<String, dynamic>),
      makers: List<Map<String, dynamic>>.from(map['makers'] as Iterable)
          .map((maker) => UserModel.fromMap(maker))
          .toList(),
      topics: List<Map<String, dynamic>>.from(map['topics'] as Iterable)
          .map((topics) => Topic.fromMap(topics))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'PostModel(id: $id, commentsCount: $commentsCount, name: $name, productState: $productState, tagline: $tagline, slug: $slug, votesCount: $votesCount, categoryId: $categoryId, createdAt: $createdAt, discussionUrl: $discussionUrl, exclusive: $exclusive, featured: $featured, iosFeaturedAt: $iosFeaturedAt, makerInside: $makerInside, screenshotUrl: $screenshotUrl, makers: $makers, redirectUrl: $redirectUrl, thumbnail: $thumbnail, topics: $topics, userModel: $userModel)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PostModel &&
        o.id == id &&
        o.commentsCount == commentsCount &&
        o.name == name &&
        o.productState == productState &&
        o.tagline == tagline &&
        o.slug == slug &&
        o.votesCount == votesCount &&
        o.categoryId == categoryId &&
        o.createdAt == createdAt &&
        o.discussionUrl == discussionUrl &&
        o.exclusive == exclusive &&
        o.featured == featured &&
        o.iosFeaturedAt == iosFeaturedAt &&
        o.makerInside == makerInside &&
        o.screenshotUrl == screenshotUrl &&
        listEquals(o.makers, makers) &&
        o.redirectUrl == redirectUrl &&
        o.thumbnail == thumbnail &&
        listEquals(o.topics, topics) &&
        o.userModel == userModel;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        commentsCount.hashCode ^
        name.hashCode ^
        productState.hashCode ^
        tagline.hashCode ^
        slug.hashCode ^
        votesCount.hashCode ^
        categoryId.hashCode ^
        createdAt.hashCode ^
        discussionUrl.hashCode ^
        exclusive.hashCode ^
        featured.hashCode ^
        iosFeaturedAt.hashCode ^
        makerInside.hashCode ^
        screenshotUrl.hashCode ^
        makers.hashCode ^
        redirectUrl.hashCode ^
        thumbnail.hashCode ^
        topics.hashCode ^
        userModel.hashCode;
  }
}

T? getValueOrNull<T>(Object? data) {
  if (data != null) return data as T;
  return null;
}
