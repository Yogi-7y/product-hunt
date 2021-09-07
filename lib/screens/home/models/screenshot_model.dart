import 'dart:convert';

import 'package:flutter/cupertino.dart';

@immutable
class Screenshot {
  final String? threeHundredPixels;
  final String? eightHundredAndFiftyPixels;

  const Screenshot({
    this.threeHundredPixels,
    this.eightHundredAndFiftyPixels,
  });

  Screenshot copyWith({
    String? threeHundredPixels,
    String? eightHundredAndFiftyPixels,
  }) =>
      Screenshot(
        threeHundredPixels: threeHundredPixels ?? this.threeHundredPixels,
        eightHundredAndFiftyPixels:
            eightHundredAndFiftyPixels ?? this.eightHundredAndFiftyPixels,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        '300px': threeHundredPixels,
        '850px': eightHundredAndFiftyPixels,
      };

  factory Screenshot.fromMap(Map<String, dynamic> map) => Screenshot(
        threeHundredPixels: map['300px'] as String,
        eightHundredAndFiftyPixels: map['850px'] as String,
      );

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Screenshot(threeHundredPixels: $threeHundredPixels, eightHundredAndFiftyPixels: $eightHundredAndFiftyPixels)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Screenshot &&
        o.threeHundredPixels == threeHundredPixels &&
        o.eightHundredAndFiftyPixels == eightHundredAndFiftyPixels;
  }

  @override
  int get hashCode =>
      threeHundredPixels.hashCode ^ eightHundredAndFiftyPixels.hashCode;
}
