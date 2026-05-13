import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'story_screen.dart';
import 'glossary_screen.dart';
import 'challenges_screen.dart';
import 'ranking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
      children: [
        const _TopBar(),
        const SizedBox(height: 16),
        const _PlayerCard(),
        const SizedBox(height: 18),
        const _DailyMissionCard(),
        const SizedBox(height: 22),
        const _SectionTitle('CONTINUE SUA JORNADA'),
        const SizedBox(height: 12),
        _JourneyTile(
          icon: Icons.menu_book_rounded,
          title: 'GLOSSARIO',
          subtitle: 'Explore palavras e expanda seu vocabulario',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const GlossaryScreen()),
          ),
        ),
        const SizedBox(height: 12),
        _JourneyTile(
          icon: Icons.shield_moon_rounded,
          title: 'DESAFIOS',
          subtitle: 'Teste seus conhecimentos e ganhe recompensas',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ChallengesScreen()),
          ),
        ),
        const SizedBox(height: 12),
        _JourneyTile(
          icon: Icons.emoji_events_rounded,
          title: 'RANKING',
          subtitle: 'Veja sua posicao entre os melhores',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const RankingScreen()),
          ),
        ),
        const SizedBox(height: 12),
        _JourneyTile(
          icon: Icons.auto_stories_rounded,
          title: 'HISTORIA DO JEFF',
          subtitle: 'Da Independencia dos EUA ate hoje',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const StoryScreen()),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        const Expanded(
          child: Center(child: ChronokairoLogo(size: 28)),
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {},
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                width: 9,
                height: 9,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _Avatar(),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Viajante do Tempo',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6),
              GlowPill(text: 'NIVEL 12'),
              SizedBox(height: 10),
              _XpBar(),
              SizedBox(height: 4),
              Text(
                '2.450 / 3.400 XP',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ResourcePill(
              icon: Icons.monetization_on_rounded,
              color: AppColors.gold,
              value: '1.250',
            ),
            SizedBox(height: 8),
            _ResourcePill(
              icon: Icons.diamond_rounded,
              color: AppColors.gem,
              value: '120',
              showAdd: true,
            ),
          ],
        ),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF6E3DE8), Color(0xFFB14CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.accent, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.5),
            blurRadius: 16,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.person, color: Colors.white, size: 38),
    );
  }
}

class _XpBar extends StatelessWidget {
  const _XpBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: 2450 / 3400,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.6),
                blurRadius: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResourcePill extends StatelessWidget {
  const _ResourcePill({
    required this.icon,
    required this.color,
    required this.value,
    this.showAdd = false,
  });

  final IconData icon;
  final Color color;
  final String value;
  final bool showAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (showAdd) ...[
            const SizedBox(width: 6),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.add, size: 14, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}

class _DailyMissionCard extends StatelessWidget {
  const _DailyMissionCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'MISSAO DIARIA',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5,
                          color: AppColors.accent,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '15h 34m',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Estude 10 palavras',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 6 / 10,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '6 / 10',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Text(
                        'RECOMPENSA:',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                          color: AppColors.textMuted,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.star_rounded,
                          color: AppColors.gold, size: 18),
                      SizedBox(width: 2),
                      Text('50 XP',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(width: 10),
                      Icon(Icons.monetization_on_rounded,
                          color: AppColors.gold, size: 18),
                      SizedBox(width: 2),
                      Text('25',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            _ChestIcon(),
          ],
        ),
      ),
    );
  }
}

class _ChestIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            AppColors.gold.withValues(alpha: 0.35),
            Colors.transparent,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.inventory_2_rounded,
        color: AppColors.goldLight,
        size: 64,
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.6,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _JourneyTile extends StatelessWidget {
  const _JourneyTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Icon(icon, color: AppColors.accent, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.accent,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textSecondary,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
