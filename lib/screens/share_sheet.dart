import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

Future<void> showShareSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 16),
              Text('Share', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 14),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search contacts',
                  filled: true,
                  fillColor: isDark ? Colors.white10 : const Color(0xFFF4F3F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: 110,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: DemoData.storyAvatars().length,
                  itemBuilder: (context, index) {
                    final avatar = DemoData.storyAvatars()[index];
                    final name = DemoData.storyNames[index % DemoData.storyNames.length];
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(avatar),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          name,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _QuickShareChip(
                    icon: Icons.add_circle_outline,
                    label: 'Story',
                  ),
                  _QuickShareChip(
                    icon: Icons.chat_bubble_outline,
                    label: 'Chat',
                  ),
                  _QuickShareChip(
                    icon: Icons.link,
                    label: 'Copy link',
                  ),
                  _QuickShareChip(
                    icon: Icons.apps,
                    label: 'More apps',
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _QuickShareChip extends StatelessWidget {
  const _QuickShareChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.pink, AppColors.purple],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
