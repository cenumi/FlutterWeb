import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'data.dart';

enum Type { year, month, week, day }

class Item extends StatelessWidget {
  final DateTime dateTime;
  final Type type;

  const Item({
    Key key,
    this.type,
    this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conf = ColorConfigProvider.of(context).config;
    final size = MediaQuery.of(context).size;
    double ratio;
    String title;
    String suffix;
    String unit;
    switch (type) {
      case Type.year:
        title = '年';
        final total = dateTime.year % 4 == 0 ? 366 : 365;
        unit = ' ${dateTime.year} 年';
        final remain = DateTime(dateTime.year + 1).difference(dateTime).inDays;
        suffix = ' $remain 天';
        ratio = (total - remain) / total;
        break;
      case Type.month:
        title = '月';
        unit = ' ${dateTime.month} 月';
        final remain = DateTime(dateTime.year, dateTime.month + 1).difference(dateTime).inDays;
        final total =
            DateTime(dateTime.year, dateTime.month + 1).difference(DateTime(dateTime.year, dateTime.month)).inDays;
        suffix = ' $remain 天';
        ratio = (total - remain) / total;
        break;
      case Type.week:
        title = '周';
        unit = '这周';
        final remain = 7 - dateTime.weekday;
        suffix = ' $remain 天';
        ratio = (7 - remain) / 7;
        break;
      case Type.day:
        title = '天';
        unit = '今天';
        final remain = DateTime(dateTime.year, dateTime.month, dateTime.day + 1).difference(dateTime).inSeconds;
        suffix = ' $remain 秒';
        ratio = (86400 - remain) / 86400;
        break;
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.all(16),
      width: size.width / 3,
      child: DefaultTextStyle(
        style: TextStyle(color: Color(conf.textColor)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 30),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: size.width / 30,
              constraints: BoxConstraints(minHeight: 35),
              child: CustomPaint(
                painter: _ProgressPainter(Color(conf.itemBackgroundColor), Color(conf.itemForegroundColor),
                    Color(conf.itemTextColor), Radius.circular(conf.radius), ratio),
              ),
            ),
            Text('距离$unit结束还有$suffix', textAlign: TextAlign.right)
          ],
        ),
      ),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color textColor;
  final Radius radius;
  final double ratio;

  _ProgressPainter(this.backgroundColor, this.foregroundColor, this.textColor, this.radius, this.ratio);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;
    final rrect = RRect.fromLTRBR(0, 0, size.width, size.height, radius);
    final progressRRect = RRect.fromLTRBR(0, 0, size.width * ratio, size.height, radius);
    canvas.drawRRect(rrect, paint);
    canvas.drawRRect(progressRRect, paint..color = foregroundColor);
    final p = (ui.ParagraphBuilder(ui.ParagraphStyle(height: size.height / 3 * 2, textAlign: TextAlign.left))
          ..pushStyle(ui.TextStyle(color: textColor, fontSize: 20))
          ..addText('${(ratio * 100).toStringAsFixed(2)} %'))
        .build();
    p.layout(ui.ParagraphConstraints(width: 100));

    canvas.drawParagraph(p, Offset(20, (size.height - p.height) / 2));
  }

  @override
  bool shouldRepaint(_ProgressPainter oldDelegate) {
    return oldDelegate.ratio != ratio ||
        oldDelegate.radius != radius ||
        oldDelegate.textColor != textColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor;
  }
}
