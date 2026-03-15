import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'providers/feed_provider.dart';
import 'screens/home_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/saved_screen.dart';
import 'screens/stories_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const ZrexApp());
}

class ZrexApp extends StatefulWidget {
  const ZrexApp({super.key});

  @override
  State<ZrexApp> createState() => _ZrexAppState();
}

class _ZrexAppState extends State<ZrexApp> {
  ThemeMode _mode = ThemeMode.dark;
  bool _ready = false;

  void _toggleTheme(bool isDark) {
    setState(() {
      _mode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() => _ready = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeedProvider()),
      ],
      child: MaterialApp(
        title: 'Varsh',
        debugShowCheckedModeBanner: false,
        themeMode: _mode,
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: _ready
            ? HomeShell(
                mode: _mode,
                onThemeChanged: _toggleTheme,
              )
            : const LoadingScreen(),
      ),
    );
  }
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.pink,
        secondary: AppColors.purple,
        surface: AppColors.lightSurface,
      ),
    );
    return base.copyWith(
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme)
          .apply(bodyColor: const Color(0xFF1A1A1F), displayColor: const Color(0xFF1A1A1F))
          .copyWith(
            titleLarge: GoogleFonts.playfairDisplay(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1F),
            ),
            titleMedium: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1A1A1F),
            ),
            bodyMedium: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2B2B32),
            ),
            bodySmall: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.lightMuted,
            ),
          ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.pink,
        secondary: AppColors.purple,
        surface: AppColors.darkSurface,
      ),
    );
    return base.copyWith(
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: GoogleFonts.manropeTextTheme(base.textTheme).copyWith(
        titleLarge: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.darkText,
        ),
        titleMedium: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.darkText,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.darkText,
        ),
        bodySmall: GoogleFonts.manrope(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.darkMuted,
        ),
      ),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.mode, required this.onThemeChanged});

  final ThemeMode mode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final PageController _controller = PageController();
  int _index = 0;

  void _onTap(int index) {
    setState(() {
      _index = index;
    });
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.mode == ThemeMode.dark;
    return GradientScaffold(
      isDark: isDark,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: _GlassBottomBar(
          currentIndex: _index,
          onTap: _onTap,
        ),
        body: PageView(
          controller: _controller,
          onPageChanged: (value) => setState(() => _index = value),
          physics: const BouncingScrollPhysics(),
          children: [
            HomeScreen(onThemeChanged: widget.onThemeChanged),
            const StoriesScreen(),
            const NotificationsScreen(),
            const MessagesScreen(),
            const SavedScreen(),
            ProfileScreen(onThemeChanged: widget.onThemeChanged, isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({super.key, required this.child, required this.isDark});

  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF10101A),
                  const Color(0xFF1E1830),
                  const Color(0xFF1C1335),
                ]
              : [
                  const Color(0xFFF9F7FF),
                  const Color(0xFFFFF3F7),
                  const Color(0xFFFFF5EA),
                ],
        ),
      ),
      child: child,
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GradientScaffold(
      isDark: isDark,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.pink, AppColors.purple, AppColors.orange],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.pink.withOpacity(0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 18),
              Text(
                'Varsh',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              Text(
                'Loading your feed...',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassBottomBar extends StatelessWidget {
  const _GlassBottomBar({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? AppColors.glassDark : AppColors.glassLight,
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.white54,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                index: 0,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.play_circle_filled_rounded,
                index: 1,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.notifications_rounded,
                index: 2,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.message_rounded,
                index: 3,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.bookmark_rounded,
                index: 4,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                icon: Icons.person_rounded,
                index: 5,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  final IconData icon;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final active = index == currentIndex;
    final inactiveGradient = [
      AppColors.pink.withOpacity(0),
      AppColors.purple.withOpacity(0),
      AppColors.orange.withOpacity(0),
    ];
    final activeGradient = const [
      AppColors.pink,
      AppColors.purple,
      AppColors.orange,
    ];
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: active ? activeGradient : inactiveGradient,
          ),
          boxShadow: [
            BoxShadow(
              color:
                  active ? AppColors.pink.withOpacity(0.35) : Colors.transparent,
              blurRadius: active ? 18 : 0,
              offset: active ? const Offset(0, 6) : Offset.zero,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 22,
          color: active ? Colors.white : Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
