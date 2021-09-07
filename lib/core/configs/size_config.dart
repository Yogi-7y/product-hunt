import 'package:flutter/material.dart';

class SizeConfig {
  SizeConfig._();
  static final SizeConfig _sizeConfig = SizeConfig._();
  static SizeConfig get instance => _sizeConfig;

  void initialize(
    BoxConstraints constraints,
    Orientation orientation,
  ) {
    if (orientation == Orientation.portrait) {
      _handlePortraitOrientation(constraints);
      return;
    }
    _handleLandscapeOrientation(constraints);
  }

  void _handlePortraitOrientation(BoxConstraints constraints) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;
    _isPortrait = true;
    if (screenWidth < 450) _isMobilePortrait = true;
  }

  void _handleLandscapeOrientation(BoxConstraints constraints) {
    _screenWidth = constraints.maxHeight;
    _screenHeight = constraints.maxWidth;
    _isPortrait = false;
    _isMobilePortrait = false;
  }

  late double _screenWidth;
  late double _screenHeight;
  bool _isPortrait = true;
  bool _isMobilePortrait = false;

  num getHeight(num width, num aspectRatio) => width / aspectRatio;

  double get screenWidth => _screenWidth;
  double get screenHeight => _screenHeight;
  double get blockWidth => screenWidth / 100;
  double get blockHeight => screenHeight / 100;
  bool get isPortrait => _isPortrait;
  bool get isMobilePortrait => _isMobilePortrait;
}
