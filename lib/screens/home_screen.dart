import 'package:flutter/material.dart';

import '../models/device.dart';
import '../theme/app_colors.dart';
import '../widgets/device_card.dart';
import '../widgets/room_card.dart';
import 'ac_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedRoom = 0;
  int _navIndex = 0;

  final List<Room> _rooms = const [
    Room(name: 'Sala', icon: Icons.weekend_outlined),
    Room(name: 'Baño', icon: Icons.bathtub_outlined),
    Room(name: 'Cocina', icon: Icons.kitchen_outlined),
    Room(name: 'Dormitorio', icon: Icons.bed_outlined),
  ];

  final List<Device> _devices = [
    Device(
      name: 'Aire acondicionado',
      subtitle: 'Marca AC',
      icon: Icons.ac_unit,
      isOn: true,
    ),
    Device(
      name: 'Foco',
      subtitle: 'Lámpara LED',
      icon: Icons.lightbulb_outline,
      isOn: true,
    ),
    Device(name: 'Smart TV', subtitle: 'Sala', icon: Icons.tv),
    Device(
      name: 'Router WiFi',
      subtitle: 'Internet',
      icon: Icons.router_outlined,
    ),
  ];

  String get _time {
    final now = TimeOfDay.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(),
                  const SizedBox(height: 20),
                  _sectionTitle('Habitaciones'),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _rooms.length,
                      itemBuilder: (_, i) => RoomCard(
                        room: _rooms[i],
                        selected: i == _selectedRoom,
                        onTap: () => setState(() => _selectedRoom = i),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _sectionTitle('Dispositivos'),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _devices.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.3,
                    ),
                    itemBuilder: (_, i) {
                      final d = _devices[i];
                      return DeviceCard(
                        device: d,
                        onToggle: (v) => setState(() => d.isOn = v),
                        // Solo el aire abre su pantalla de detalle
                        onTap: i == 0
                            ? () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => const AcScreen(),
                                  ),
                                )
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppColors.mainGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Bienvenido a casa,\nRoger',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _time,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
            const Text(
              'Mi casa',
              style: TextStyle(fontSize: 12, color: AppColors.textGrey),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.cloud_outlined, color: AppColors.textDark),
        const SizedBox(width: 8),
        const Text(
          '24°C',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildBottomBar() {
    const icons = [
      Icons.home_rounded,
      Icons.person_outline,
      Icons.notifications_none,
      Icons.settings_outlined,
    ];
    return SafeArea(
      top: false,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (i) {
            return IconButton(
              onPressed: () => setState(() => _navIndex = i),
              icon: Icon(
                icons[i],
                size: 26,
                color: i == _navIndex ? AppColors.primary : AppColors.textGrey,
              ),
            );
          }),
        ),
      ),
    );
  }
}
