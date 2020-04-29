import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import 'pie_chart.dart';

class PieChartPainter extends CustomPainter {
  List<Paint> _paintList = [];
  List<double> _subParts;
  double _total = 0;
  double _totalAngle = math.pi * 2;

  final TextStyle chartValueStyle;
  final Color chartValueBackgroundColor;
  final double initialAngle;
  final bool showValuesInPercentage;
  final bool showChartValuesOutside;
  final int decimalPlaces;
  final bool showChartValueLabel;
  final ChartType chartType;
  final String chartTitle;
  final String chartText;
  final TextStyle chartTitleStyle;
  final TextStyle chartTextStyle;

  double _prevAngle = 0;

  PieChartPainter(
    double angleFactor,
    this.showChartValuesOutside,
    List<Color> colorList, {
    this.chartValueStyle,
    this.chartValueBackgroundColor,
    List<double> values,
    this.initialAngle,
    this.showValuesInPercentage,
    this.decimalPlaces,
    this.showChartValueLabel,
    this.chartType,
    this.chartTitle,
    this.chartText,
    this.chartTitleStyle,
    this.chartTextStyle,
  }) {
    for (int i = 0; i < values.length; i++) {
      final paint = Paint()..color = _getColor(colorList, i);
      if (chartType == ChartType.ring) {
        paint.style = PaintingStyle.stroke;
        paint.strokeWidth = 5;
      }
      _paintList.add(paint);
    }
    _totalAngle = angleFactor * math.pi * 2;
    _subParts = values;
    _total = values.fold(0, (v1, v2) => v1 + v2);
  }

  @override
  void paint(Canvas canvas, Size size) {
    int marginSide =
        1; // 1 or (-1) to determine the shift direction on the x axis
    final side = size.width < size.height ? size.width : size.height;
    _prevAngle = this.initialAngle;
    for (int i = 0; i < _subParts.length; i++) {
      canvas.drawArc(
        Rect.fromLTWH(0.0, 0.0, side, size.height),
        _prevAngle,
        (((_totalAngle) / _total) * _subParts[i]),
        chartType == ChartType.disc ? true : false,
        _paintList[i],
      );
      final radius = showChartValuesOutside ? side * 0.52 : side / 3;

      final x = (radius) *
              math.cos(_prevAngle +
                  ((((_totalAngle) / _total) * _subParts[i]) / 2)) +
          marginSide;
      final y = (radius) *
          math.sin(
              _prevAngle + ((((_totalAngle) / _total) * _subParts[i]) / 2));
      if (_subParts.elementAt(i).toInt() != 0) {
        final name = showValuesInPercentage
            ? (((_subParts.elementAt(i) / _total) * 100)
                    .toStringAsFixed(this.decimalPlaces) +
                '%')
            : _subParts.elementAt(i).toStringAsFixed(this.decimalPlaces);

        // if the value is too small, don't paint it
        if (_subParts.elementAt(i) / _total > 0.01)
          _drawValue(canvas, name, x, y, side);

        marginSide *=
            -1; // switch the margin side for the next label to avoid shifting in the same direction
      }
      _prevAngle = _prevAngle + (((_totalAngle) / _total) * _subParts[i]);
    }

    TextPainter title = TextPainter(
      text: TextSpan(
        style: this.chartTitleStyle,
        text: this.chartTitle,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    title.layout();
    title.paint(
      canvas,
      Offset(
        (side / 2) - (title.width / 2),
        (side / 2) - (title.height / 2) - 6,
      ),
    );

    TextPainter text = TextPainter(
      text: TextSpan(
        style: this.chartTextStyle,
        text: (this.chartText.length > 25)
            ? this.chartText.substring(0, 25) + "..."
            : this.chartText,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    text.layout();
    text.paint(
      canvas,
      Offset(
        (side / 2) - (text.width / 2),
        (side / 2) - (text.height / 2) + 16,
      ),
    );
  }

  Color _getColor(List<Color> colorList, int index) {
    if (index > (colorList.length - 1)) {
      var newIndex = index % (colorList.length - 1);
      return colorList.elementAt(newIndex);
    } else
      return colorList.elementAt(index);
  }

  void _drawValue(Canvas canvas, String name, double x, double y, double side) {
    TextSpan span = TextSpan(
      style: chartValueStyle,
      text: name,
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    tp.layout();

    tp.paint(
      canvas,
      Offset(
        (side / 2 + x / 0.865) - (tp.width / 2),
        (side / 2 + y / 0.865) - (tp.height / 2),
      ),
    );
  }

  @override
  bool shouldRepaint(PieChartPainter oldDelegate) =>
      oldDelegate._totalAngle != _totalAngle;
}
