import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Reusable starry-night gradient backdrop used across the app to evoke the
/// "time travel through space" vibe.
class StarryBackground extends StatelessWidget {
  const StarryBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.6),
          radius: 1.2,
          colors: [
            Color(0xFF1B0B45),
            Color(0xFF0A0420),
            Color(0xFF030010),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _StarsPainter()),
          ),
          child,
        ],
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.6);
    // Deterministic pseudo-random stars (no dart:math import needed).
    const positions = <Offset>[
      Offset(0.05, 0.10), Offset(0.18, 0.04), Offset(0.32, 0.12),
      Offset(0.47, 0.07), Offset(0.62, 0.03), Offset(0.78, 0.09),
      Offset(0.92, 0.14), Offset(0.10, 0.22), Offset(0.25, 0.30),
      Offset(0.55, 0.27), Offset(0.74, 0.35), Offset(0.88, 0.42),
      Offset(0.05, 0.50), Offset(0.20, 0.60), Offset(0.40, 0.70),
      Offset(0.60, 0.80), Offset(0.85, 0.65), Offset(0.95, 0.90),
      Offset(0.30, 0.95), Offset(0.50, 0.05), Offset(0.15, 0.85),
      Offset(0.70, 0.55), Offset(0.05, 0.75), Offset(0.45, 0.45),
    ];
    for (var i = 0; i < positions.length; i++) {
      final p = positions[i];
      final r = (i % 3 == 0) ? 1.6 : (i % 3 == 1 ? 1.0 : 0.6);
      paint.color = Colors.white.withValues(alpha: 0.3 + (i % 5) * 0.12);
      canvas.drawCircle(Offset(p.dx * size.width, p.dy * size.height), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// The Chronokairo diamond logo. Renders the `</>` + hourglass mark and an
/// optional "CHRONOKAIRO" wordmark.
class ChronokairoLogo extends StatelessWidget {
  const ChronokairoLogo({
    super.key,
    this.size = 28,
    this.showWordmark = true,
    this.color = Colors.white,
  });

  final double size;
  final bool showWordmark;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(painter: _ChronokairoMarkPainter(color: color)),
        ),
        if (showWordmark) ...[
          const SizedBox(width: 8),
          Text(
            'CHRONOKAIRO',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              letterSpacing: 2.2,
              fontSize: size * 0.55,
            ),
          ),
        ],
      ],
    );
  }
}

class _ChronokairoMarkPainter extends CustomPainter {
  _ChronokairoMarkPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = size.width * 0.05;

    // Outer diamond
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.48;
    final diamond = Path()
      ..moveTo(cx, cy - r)
      ..lineTo(cx + r, cy)
      ..lineTo(cx, cy + r)
      ..lineTo(cx - r, cy)
      ..close();
    canvas.drawPath(diamond, stroke);

    // Left half: </>
    final code = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final lx = cx - r * 0.45;
    final ly = cy;
    final s = r * 0.18;
    final left = Path()
      ..moveTo(lx + s, ly - s)
      ..lineTo(lx - s * 0.4, ly)
      ..lineTo(lx + s, ly + s);
    canvas.drawPath(left, code);

    // Right half: hourglass
    final hx = cx + r * 0.45;
    final hy = cy;
    final hs = r * 0.22;
    final hourglass = Path()
      ..moveTo(hx - hs, hy - hs)
      ..lineTo(hx + hs, hy - hs)
      ..lineTo(hx - hs, hy + hs)
      ..lineTo(hx + hs, hy + hs)
      ..close();
    canvas.drawPath(hourglass, code);
    // Sand line in the middle
    canvas.drawLine(
      Offset(hx - hs * 0.55, hy),
      Offset(hx + hs * 0.55, hy),
      code,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Small glowing pill used for "NIVEL 12" badges, etc.
class GlowPill extends StatelessWidget {
  const GlowPill({
    super.key,
    required this.text,
    this.color = AppColors.primary,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
