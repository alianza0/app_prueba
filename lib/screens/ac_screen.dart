import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/gradient_button.dart';
import '../widgets/mode_button.dart';
import '../widgets/temperature_dial.dart';

class AcScreen extends StatefulWidget {
  const AcScreen({super.key});

  @override
  State<AcScreen> createState() => _AcScreenState();
}

class _AcScreenState extends State<AcScreen> {
  double _temperature = 21;
  bool _isOn = true;
  int _mode = 1;
  double _fanSpeed = 0.4;

  static const _modes = [
    (Icons.timer_outlined, 'Timer'),
    (Icons.air, 'Ventilar'),
    (Icons.ac_unit, 'Frío'),
    (Icons.local_fire_department_outlined, 'Calor'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.textDark,
        title: const Text(
          'Aire acondicionado',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            _buildDeviceRow(),
            const SizedBox(height: 24),
            IgnorePointer(
              ignoring: !_isOn,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: _isOn ? 1 : 0.4,
                child: TemperatureDial(
                  value: _temperature,
                  onChanged: (v) => setState(() => _temperature = v),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GradientButton(
              text: _isOn ? 'APAGAR' : 'ENCENDER',
              height: 34,
              width: 120,
              fontSize: 13,
              onPressed: () => setState(() => _isOn = !_isOn),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_modes.length, (i) {
                final (icon, label) = _modes[i];
                return ModeButton(
                  icon: icon,
                  label: label,
                  selected: i == _mode,
                  onTap: () => setState(() => _mode = i),
                );
              }),
            ),
            const SizedBox(height: 20),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.primary,
                inactiveTrackColor: AppColors.card,
                thumbColor: AppColors.primary,
                overlayColor: AppColors.primary.withValues(alpha: 0.15),
                trackHeight: 4,
              ),
              child: Slider(
                value: _fanSpeed,
                onChanged:
                    _isOn ? (v) => setState(() => _fanSpeed = v) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceRow() {
    Widget outlined(IconData icon) => Icon(
          icon,
          size: 32,
          color: AppColors.textGrey,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        outlined(Icons.lightbulb_outline),
        Container(
          width: 110,
          height: 70,
          decoration: BoxDecoration(
            gradient: AppColors.mainGradient,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.ac_unit, color: Colors.white, size: 36),
        ),
        outlined(Icons.tv),
      ],
    );
  }
}
