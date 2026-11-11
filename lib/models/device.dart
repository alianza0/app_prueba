import 'package:flutter/material.dart';

class Device {
  final String name;
  final String subtitle;
  final IconData icon;
  bool isOn;

  Device({
    required this.name,
    required this.subtitle,
    required this.icon,
    this.isOn = false,
  });
}

class Room {
  final String name;
  final IconData icon;

  const Room({required this.name, required this.icon});
}
