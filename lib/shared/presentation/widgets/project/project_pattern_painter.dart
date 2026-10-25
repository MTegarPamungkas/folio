import 'package:flutter/material.dart';
import 'package:folio/domain/entities/project.dart';

class ProjectPatternPainter extends CustomPainter {
  ProjectPatternPainter({
    required this.category,
    required this.color,
    required this.accent,
  });

  final ProjectCategory category;
  final Color color;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    final soft = Paint()
      ..color = color.withValues(alpha: 0.055)
      ..style = PaintingStyle.fill;
    final bright = Paint()
      ..color = accent.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    for (var x = 18.0; x < size.width; x += 30) {
      for (var y = 18.0; y < size.height; y += 30) {
        canvas.drawCircle(Offset(x, y), 0.8, soft);
      }
    }

    switch (category) {
      case ProjectCategory.travel:
        {
          canvas.drawCircle(
            Offset(size.width * 0.78, size.height * 0.3),
            size.shortestSide * 0.2,
            stroke,
          );
          canvas.drawCircle(
            Offset(size.width * 0.78, size.height * 0.3),
            size.shortestSide * 0.29,
            stroke..color = color.withValues(alpha: 0.08),
          );
          final path = Path()
            ..moveTo(-20, size.height * 0.7)
            ..cubicTo(
              size.width * 0.22,
              size.height * 0.48,
              size.width * 0.38,
              size.height * 0.9,
              size.width * 0.58,
              size.height * 0.68,
            )
            ..cubicTo(
              size.width * 0.76,
              size.height * 0.48,
              size.width * 0.86,
              size.height * 0.74,
              size.width + 20,
              size.height * 0.58,
            );
          canvas.drawPath(path, stroke);
          canvas.drawCircle(
            Offset(size.width * 0.15, size.height * 0.22),
            4,
            bright,
          );
          break;
        }
      case ProjectCategory.finance:
        {
          final path = Path()
            ..moveTo(0, size.height * 0.78)
            ..lineTo(size.width * 0.17, size.height * 0.65)
            ..lineTo(size.width * 0.32, size.height * 0.7)
            ..lineTo(size.width * 0.52, size.height * 0.48)
            ..lineTo(size.width * 0.7, size.height * 0.56)
            ..lineTo(size.width, size.height * 0.25);
          canvas.drawPath(path, stroke..strokeWidth = 1.5);
          for (var i = 0; i < 6; i++) {
            final x = size.width * (0.08 + i * 0.16);
            canvas.drawLine(
              Offset(x, size.height * 0.2),
              Offset(x, size.height * 0.88),
              stroke..color = color.withValues(alpha: 0.06),
            );
          }
          break;
        }
      case ProjectCategory.ai:
        {
          for (var i = 0; i < 3; i++) {
            canvas.drawOval(
              Rect.fromCenter(
                center: Offset(size.width * 0.75, size.height * 0.42),
                width: size.width * (0.32 + i * 0.16),
                height: size.height * (0.3 + i * 0.14),
              ),
              stroke..color = color.withValues(alpha: 0.09 + i * 0.025),
            );
          }
          final sparkle = Path()
            ..moveTo(size.width * 0.16, size.height * 0.3)
            ..quadraticBezierTo(
              size.width * 0.18,
              size.height * 0.23,
              size.width * 0.23,
              size.height * 0.21,
            )
            ..quadraticBezierTo(
              size.width * 0.18,
              size.height * 0.19,
              size.width * 0.16,
              size.height * 0.12,
            )
            ..quadraticBezierTo(
              size.width * 0.14,
              size.height * 0.19,
              size.width * 0.09,
              size.height * 0.21,
            )
            ..quadraticBezierTo(
              size.width * 0.14,
              size.height * 0.23,
              size.width * 0.16,
              size.height * 0.3,
            );
          canvas.drawPath(sparkle, bright);
          break;
        }
      case ProjectCategory.productivity:
        {
          for (var i = 1; i <= 4; i++) {
            canvas.drawCircle(
              Offset(size.width * 0.82, size.height * 0.52),
              size.shortestSide * (0.1 + i * 0.075),
              stroke..color = color.withValues(alpha: 0.13 - i * 0.02),
            );
          }
          canvas.drawArc(
            Rect.fromCircle(
              center: Offset(size.width * 0.82, size.height * 0.52),
              radius: size.shortestSide * 0.23,
            ),
            -1.35,
            2.1,
            false,
            Paint()
              ..color = accent.withValues(alpha: 0.7)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..strokeCap = StrokeCap.round,
          );
          break;
        }
      case ProjectCategory.commerce:
        {
          for (var i = 0; i < 4; i++) {
            canvas.save();
            canvas.translate(
              size.width * (0.65 + (i % 2) * 0.13),
              size.height * (0.2 + (i ~/ 2) * 0.2),
            );
            canvas.rotate(0.14);
            canvas.drawRRect(
              RRect.fromRectAndRadius(
                Rect.fromLTWH(0, 0, size.width * 0.16, size.width * 0.16),
                const Radius.circular(5),
              ),
              stroke,
            );
            canvas.restore();
          }
          break;
        }
      case ProjectCategory.food:
        {
          for (var i = 0; i < 3; i++) {
            final path = Path()
              ..moveTo(size.width * (0.16 + i * 0.12), size.height * 0.36)
              ..cubicTo(
                size.width * (0.1 + i * 0.12),
                size.height * 0.28,
                size.width * (0.23 + i * 0.12),
                size.height * 0.23,
                size.width * (0.16 + i * 0.12),
                size.height * 0.14,
              );
            canvas.drawPath(
              path,
              stroke
                ..strokeWidth = 1.4
                ..color = color.withValues(alpha: 0.13),
            );
          }
          canvas.drawCircle(
            Offset(size.width * 0.85, size.height * 0.72),
            size.shortestSide * 0.17,
            stroke,
          );
          break;
        }
      case ProjectCategory.website:
        {
          final browser = RRect.fromRectAndRadius(
            Rect.fromLTWH(
              size.width * 0.66,
              size.height * 0.2,
              size.width * 0.27,
              size.height * 0.42,
            ),
            const Radius.circular(5),
          );
          canvas.drawRRect(browser, stroke);
          canvas.drawLine(
            Offset(browser.left, browser.top + 9),
            Offset(browser.right, browser.top + 9),
            stroke,
          );
          for (var i = 0; i < 3; i++) {
            canvas.drawCircle(
              Offset(browser.left + 5 + i * 5, browser.top + 4.5),
              1,
              stroke,
            );
          }
          for (var i = 0; i < 3; i++) {
            canvas.drawLine(
              Offset(browser.left + 8, browser.top + 18 + i * 9),
              Offset(browser.right - 8 - i * 7, browser.top + 18 + i * 9),
              stroke,
            );
          }
          canvas.drawCircle(
            Offset(size.width * 0.18, size.height * 0.26),
            5,
            bright,
          );
          break;
        }
      case ProjectCategory.enterprise:
        {
          for (var row = 0; row < 3; row++) {
            for (var col = 0; col < 3; col++) {
              canvas.drawRRect(
                RRect.fromRectAndRadius(
                  Rect.fromLTWH(
                    size.width * (0.64 + col * 0.09),
                    size.height * (0.2 + row * 0.1),
                    size.width * 0.06,
                    size.height * 0.06,
                  ),
                  const Radius.circular(2),
                ),
                col == 1 && row == 1 ? bright : stroke,
              );
            }
          }
          break;
        }
      case ProjectCategory.career:
        {
          canvas.drawCircle(
            Offset(size.width * 0.78, size.height * 0.3),
            size.shortestSide * 0.09,
            stroke,
          );
          for (var i = 0; i < 3; i++) {
            canvas.drawLine(
              Offset(size.width * 0.68, size.height * (0.5 + i * 0.08)),
              Offset(
                size.width * 0.92 - i * 10,
                size.height * (0.5 + i * 0.08),
              ),
              stroke,
            );
          }
          break;
        }
      case ProjectCategory.experiment:
        {
          canvas.drawCircle(
            Offset(size.width * 0.78, size.height * 0.32),
            size.shortestSide * 0.14,
            stroke,
          );
          canvas.drawCircle(
            Offset(size.width * 0.78, size.height * 0.32),
            size.shortestSide * 0.04,
            bright,
          );
          final orbit = Path()
            ..addOval(
              Rect.fromCenter(
                center: Offset(size.width * 0.78, size.height * 0.32),
                width: size.width * 0.34,
                height: size.height * 0.18,
              ),
            );
          canvas.drawPath(orbit, stroke);
          break;
        }
    }
  }

  @override
  bool shouldRepaint(covariant ProjectPatternPainter oldDelegate) {
    return oldDelegate.category != category ||
        oldDelegate.color != color ||
        oldDelegate.accent != accent;
  }
}
