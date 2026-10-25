import 'dart:math' as math;

import 'package:flutter/material.dart';

class PreviewLineChartPainter extends CustomPainter {
  PreviewLineChartPainter({required this.color, required this.gridColor});

  final Color color;
  final Color gridColor;

  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = gridColor
      ..strokeWidth = 0.7;
    for (var i = 1; i < 4; i++) {
      final y = size.height / 4 * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final points = <Offset>[
      Offset(0, size.height * 0.72),
      Offset(size.width * 0.16, size.height * 0.57),
      Offset(size.width * 0.32, size.height * 0.64),
      Offset(size.width * 0.48, size.height * 0.35),
      Offset(size.width * 0.64, size.height * 0.47),
      Offset(size.width * 0.8, size.height * 0.24),
      Offset(size.width, size.height * 0.31),
    ];

    final fill = Path()..moveTo(0, size.height);
    for (final point in points) {
      fill.lineTo(point.dx, point.dy);
    }
    fill.lineTo(size.width, size.height);
    fill.close();
    canvas.drawPath(
      fill,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.25), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );

    final line = Path()..moveTo(points.first.dx, points.first.dy);
    for (var i = 1; i < points.length; i++) {
      final previous = points[i - 1];
      final current = points[i];
      final midX = (previous.dx + current.dx) / 2;
      line.cubicTo(midX, previous.dy, midX, current.dy, current.dx, current.dy);
    }
    canvas.drawPath(
      line,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(points.last, 2.5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant PreviewLineChartPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.gridColor != gridColor;
}

class PreviewTimerPainter extends CustomPainter {
  PreviewTimerPainter({
    required this.track,
    required this.progress,
    required this.accent,
  });

  final Color track;
  final Color progress;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 5;
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = track
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 1.58,
      false,
      Paint()
        ..color = progress
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      center,
      radius - 11,
      Paint()
        ..color = accent.withValues(alpha: 0.2)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant PreviewTimerPainter oldDelegate) => false;
}

class PreviewBarChartPainter extends CustomPainter {
  PreviewBarChartPainter({required this.color, required this.muted});

  final Color color;
  final Color muted;

  @override
  void paint(Canvas canvas, Size size) {
    const values = [0.4, 0.72, 0.55, 0.9, 0.62, 0.82, 0.68];
    final gap = 4.0;
    final width = (size.width - gap * (values.length - 1)) / values.length;
    for (var i = 0; i < values.length; i++) {
      final height = size.height * values[i];
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(i * (width + gap), size.height - height, width, height),
        const Radius.circular(3),
      );
      canvas.drawRRect(rect, Paint()..color = i == 3 ? color : muted);
    }
  }

  @override
  bool shouldRepaint(covariant PreviewBarChartPainter oldDelegate) => false;
}
