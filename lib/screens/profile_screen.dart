import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onThemeChanged,
    required this.isDark,
  });

  final ValueChanged<bool> onThemeChanged;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Text('Profile', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          CircleAvatar(
            radius: 46,
            backgroundImage: NetworkImage(DemoData.profileAvatar),
          ),
          const SizedBox(height: 12),
          Text('Nova Pierce', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text('Creative Director', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.white70,
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _StatTile(label: 'Posts', value: '248'),
                      _StatTile(label: 'Followers', value: '12.4k'),
                      _StatTile(label: 'Following', value: '420'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode_outlined),
                    const SizedBox(width: 12),
                    Text('Dark mode',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Switch.adaptive(
                      value: isDark,
                      onChanged: onThemeChanged,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
