import 'dart:convert';

import 'package:flutter/material.dart';

class ColorConfigProvider extends InheritedWidget {
  final ColorConfig config;

  const ColorConfigProvider(
    this.config, {
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static ColorConfigProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorConfigProvider>();
  }

  @override
  bool updateShouldNotify(ColorConfigProvider old) {
    return jsonEncode(old.config) != jsonEncode(config);
  }
}

class ColorConfig {
  int backgroundColor;
  int itemBackgroundColor;
  int itemForegroundColor;
  int textColor;
  int itemTextColor;
  double radius;

  ColorConfig(
      {this.backgroundColor = 0xFF495367,
      this.itemBackgroundColor = 0xFFE2E2E2,
      this.itemForegroundColor = 0xFF7FB9B3,
      this.textColor = 0xFFFFFFFF,
      this.itemTextColor = 0xFF000000,
      this.radius = 4});

  factory ColorConfig.fromJson(Map<String, dynamic> json) => ColorConfig(
      backgroundColor: json['backgroundColor'] as int,
      itemBackgroundColor: json['itemBackgroundColor'] as int,
      itemForegroundColor: json['itemForegroundColor'] as int,
      textColor: json['textColor'] as int,
      itemTextColor: json['itemTextColor'] as int,
      radius: json['radius'] as double);

  Map toJson() => <String, dynamic>{
        'backgroundColor': backgroundColor,
        'itemBackgroundColor': itemBackgroundColor,
        'itemForegroundColor': itemForegroundColor,
        'textColor': textColor,
        'itemTextColor': itemTextColor,
        'radius': radius,
      };

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(other) {
    if (other is ColorConfig) {
      return other.toString() == this.toString();
    }
    return false;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
