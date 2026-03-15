import 'dart:math';

class Post {
  Post({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.location,
    required this.caption,
    required this.images,
    required this.timeAgo,
    required this.likes,
    this.isLiked = false,
    this.isSaved = false,
  });

  final String id;
  final String username;
  final String userAvatar;
  final String location;
  final String caption;
  final List<String> images;
  final String timeAgo;
  int likes;
  bool isLiked;
  bool isSaved;

  Post copyWith({
    int? likes,
    bool? isLiked,
    bool? isSaved,
  }) {
    return Post(
      id: id,
      username: username,
      userAvatar: userAvatar,
      location: location,
      caption: caption,
      images: images,
      timeAgo: timeAgo,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  static Post random(Random random) {
    final seed = random.nextInt(1000);
    final name = _names[random.nextInt(_names.length)];
    return Post(
      id: 'post-extra-$seed',
      username: name.toLowerCase(),
      userAvatar: 'https://i.pravatar.cc/150?img=${seed % 60}',
      location: _locations[random.nextInt(_locations.length)],
      caption: 'Fresh frames with a soft gradient glow.',
      images: [
        'https://picsum.photos/seed/$seed/900/1200',
        'https://picsum.photos/seed/${seed + 1}/900/1200',
      ],
      timeAgo: '${random.nextInt(12) + 1}h ago',
      likes: random.nextInt(5000) + 300,
    );
  }
}

class Story {
  Story({required this.name, required this.avatarUrl});

  final String name;
  final String avatarUrl;
}

class AppNotification {
  AppNotification({
    required this.avatarUrl,
    required this.message,
    required this.time,
    required this.type,
  });

  final String avatarUrl;
  final String message;
  final String time;
  final NotificationType type;
}

enum NotificationType { like, comment, follow, mention, story }

class Profile {
  Profile({required this.avatarUrl});

  final String avatarUrl;
}

const _names = [
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

const _locations = [
  'Paris, France',
  'Seoul, South Korea',
  'Reykjavik, Iceland',
  'Tulum, Mexico',
  'Marrakesh, Morocco',
];
