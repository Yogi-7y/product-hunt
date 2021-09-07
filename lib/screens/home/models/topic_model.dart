import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class Topic {
  final int id;
  final String name;
  final String slug;

  const Topic({
    required this.id,
    required this.name,
    required this.slug,
  });

  Topic copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      Topic(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'slug': slug,
      };

  factory Topic.fromMap(Map<String, dynamic> map) => Topic(
        id: map['id'] as int,
        name: map['name'] as String,
        slug: map['slug'] as String,
      );

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Tag(id: $id, name: $name, slug: $slug)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Topic && o.id == id && o.name == name && o.slug == slug;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ slug.hashCode;
}
