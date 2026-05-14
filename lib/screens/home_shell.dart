import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'home_screen.dart';
import 'glossary_screen.dart';
import 'challenges_screen.dart';
import 'ranking_screen.dart';
import 'shop_screen.dart';
import 'story_screen.dart';
import 'profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  late final List<Widget> _pages = const [
    HomeScreen(),
    GlossaryScreen(),
    ChallengesScreen(),
    RankingScreen(),
    ShopScreen(),
  ];

  static const _items = <_NavItem>[
    _NavItem(Icons.home_rounded, 'Inicio'),
    _NavItem(Icons.menu_book_rounded, 'Glossario'),
    _NavItem(Icons.shield_moon_rounded, 'Desafios'),
    _NavItem(Icons.emoji_events_rounded, 'Ranking'),
    _NavItem(Icons.storefront_rounded, 'Loja'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: StarryBackground(
        child: SafeArea(
          bottom: false,
          child: _pages[_index],
        ),
      ),
      drawer: _StoryDrawer(),
      bottomNavigationBar: _BottomBar(
        index: _index,
        items: _items,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _NavItem {
  const _NavItem(this.icon, this.label);
  final IconData icon;
  final String label;
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.index,
    required this.items,
    required this.onTap,
  });

  final int index;
  final List<_NavItem> items;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8 + MediaQuery.of(context).padding.bottom,
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < items.length; i++)
            _NavButton(
              item: items[i],
              selected: i == index,
              onTap: () => onTap(i),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textMuted;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: color, size: 26),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11,
                color: color,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: ChronokairoLogo(size: 32),
            ),
            const Divider(color: AppColors.border),
            _DrawerTile(
              icon: Icons.menu_book_outlined,
              title: 'Historia de Jeff',
              subtitle: 'Da Independencia em diante',
              onTap: () {
                final navigator = Navigator.of(context, rootNavigator: true);
                Navigator.pop(context);
                navigator.push(
                  MaterialPageRoute(builder: (_) => const StoryScreen()),
                );
              },
            ),
            _DrawerTile(
              icon: Icons.person_outline,
              title: 'Perfil',
              subtitle: 'Viajante do Tempo',
              onTap: () {
                final navigator = Navigator.of(context, rootNavigator: true);
                Navigator.pop(context);
                navigator.push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            _DrawerTile(
              icon: Icons.settings_outlined,
              title: 'Configuracoes',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerTile(
              icon: Icons.info_outline,
              title: 'Sobre',
              subtitle: 'Chronokairo',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.accent),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: const TextStyle(color: AppColors.textMuted),
            ),
      onTap: onTap,
    );
  }
}
