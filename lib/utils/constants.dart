import 'package:flutter/material.dart';

class AppColors {
  static const pink = Color(0xFFFF4D8D);
  static const purple = Color(0xFF8B5CFF);
  static const orange = Color(0xFFFF9F43);
  static const neon = Color(0xFFFE3DFF);

  static const lightSurface = Color(0xFFF8F7FB);
  static const darkSurface = Color(0xFF14131B);
  static const lightMuted = Color(0xFF6B6B74);
  static const darkMuted = Color(0xFF9FA0AB);
  static const darkText = Color(0xFFEDECF2);

  static const glassLight = Color(0x66FFFFFF);
  static const glassDark = Color(0x331E1D2A);

  static const shimmerBase = Color(0xFFD9D6E7);
  static const shimmerHighlight = Color(0xFFF7F5FF);
}

class DemoData {
  static const profileAvatar = 'https://i.pravatar.cc/150?img=32';

  static const storyNames = [
    'Luna',
    'Theo',
    'Ariel',
    'Nova',
    'Mila',
    'Ezra',
    'Iris',
    'Milo',
    'Kira',
    'Sage',
  ];

  static List<String> storyAvatars() {
    return List.generate(10, (index) => 'https://i.pravatar.cc/150?img=${index + 6}');
  }

  static const notifications = [
    {
      'avatar': 'https://i.pravatar.cc/150?img=11',
      'message': 'Ava liked your post.',
      'time': 'Just now',
      'type': 'like',
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=20',
      'message': 'Milo commented: "Stunning palette".',
      'time': '10m ago',
      'type': 'comment',
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=7',
      'message': 'Noah started following you.',
      'time': '1h ago',
      'type': 'follow',
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=30',
      'message': 'Sage mentioned you in a story.',
      'time': '2h ago',
      'type': 'mention',
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=28',
      'message': 'Eden reacted to your story.',
      'time': '4h ago',
      'type': 'story',
    },
  ];

  static const chats = [
    {
      'avatar': 'https://i.pravatar.cc/150?img=19',
      'name': 'Sora',
      'preview': 'Are we still on for the shoot tomorrow?',
      'time': '2m',
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=22',
      'name': 'Jules',
      'preview': 'Sent the gradient pack you asked for.',
      'time': '32m',
    },
    {
      'avatar': 'https://i.pravatar.cc/150?img=24',
      'name': 'Kira',
      'preview': 'Moodboard is live. Take a look.',
      'time': '1h',
    },
  ];

  static List<String> savedPosts() {
    return List.generate(8, (index) => 'https://picsum.photos/seed/s$index/600/800');
  }
}
