import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Dial circular de temperatura. Se arrastra con el dedo para cambiar el valor.
class TemperatureDial extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double size;
  final ValueChanged<double> onChanged;

  const TemperatureDial({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 16,
    this.max = 30,
    this.size = 240,
  });

  // El arco empieza abajo a la izquierda (135°) y recorre 270° en sentido horario.
  static const double _start = math.pi * 3 / 4;
  static const double _sweep = math.pi * 3 / 2;

  void _update(Offset pos) {
    final center = Offset(size / 2, size / 2);
    final angle = math.atan2(pos.dy - center.dy, pos.dx - center.dx);
    double a = (angle - _start) % (2 * math.pi);
    if (a > _sweep) {
      // Zona muerta de abajo: se pega al extremo más cercano.
      a = (a - _sweep) < (2 * math.pi - a) ? _sweep : 0;
    }
    final v = (min + (a / _sweep) * (max - min)).roundToDouble();
    if (v != value) onChanged(v);
  }

  @override
  Widget build(BuildContext context) {
    final progress = ((value - min) / (max - min)).clamp(0.0, 1.0);
    final inner = size * 0.55;

    return SizedBox(
      width: size,
      height: size,
      child: GestureDetector(
        onPanDown: (d) => _update(d.localPosition),
        onPanUpdate: (d) => _update(d.localPosition),
        child: CustomPaint(
          painter: _DialPainter(progress: progress),
          child: Center(
            child: Container(
              width: inner,
              height: inner,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${value.round()}°C',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Text(
                    'Temp',
                    style: TextStyle(fontSize: 12, color: AppColors.textGrey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  final double progress;

  _DialPainter({required this.progress});

  static const double _start = TemperatureDial._start;
  static const double _sweep = TemperatureDial._sweep;

  Offset _point(Offset center, double angle, double r) =>
      center + Offset(math.cos(angle), math.sin(angle)) * r;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    // Rayitas alrededor
    final tickOff = Paint()
      ..color = const Color(0xFFDDDDDD)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    final tickOn = Paint()
      ..color = AppColors.primaryLight
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    const ticks = 60;
    for (int i = 0; i <= ticks; i++) {
      final t = i / ticks;
      final a = _start + _sweep * t;
      canvas.drawLine(
        _point(center, a, radius - 12),
        _point(center, a, radius - 4),
        t <= progress ? tickOn : tickOff,
      );
    }

    // Arco de fondo
    final arcRadius = radius - 26;
    final rect = Rect.fromCircle(center: center, radius: arcRadius);
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..color = AppColors.card;
    canvas.drawArc(rect, _start, _sweep, false, track);

    // Arco con degradado
    if (progress > 0) {
      final arc = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..shader = const SweepGradient(
          startAngle: 0,
          endAngle: _sweep,
          colors: [Color(0xFFFFD3B8), AppColors.primary],
          transform: GradientRotation(_start),
        ).createShader(rect);
      canvas.drawArc(rect, _start, _sweep * progress, false, arc);
    }

    // Perilla
    final knob = _point(center, _start + _sweep * progress, arcRadius);
    canvas.drawCircle(
      knob,
      13,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(knob, 11, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_DialPainter old) => old.progress != progress;
}
