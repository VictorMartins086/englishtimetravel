import 'package:flutter/material.dart';

import '../models/campaign.dart';
import '../models/player_progress.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

/// Profile screen featuring Jeff's character art on a vibrant cosmic backdrop.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmReset(BuildContext context) async {
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Resetar progresso?'),
        content: const Text(
          'Isso vai apagar XP, moedas, gemas e todas as conquistas. '
          'A acao nao pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Resetar'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await PlayerProgress.instance.resetAll();
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Perfil'),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Resetar progresso',
            icon: const Icon(Icons.restart_alt_rounded, color: Colors.white),
            onPressed: () => _confirmReset(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _CosmicBackdrop()),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                const SizedBox(height: 24),
                const _HeroAvatar(),
                const SizedBox(height: 20),
                const _IdentityCard(),
                const SizedBox(height: 18),
                _StatsRow(),
                const SizedBox(height: 18),
                const _AchievementsCard(),
                const SizedBox(height: 18),
                const _StoryProgressCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated cosmic backdrop: deep purple gradient + glowing orbs + stars.
class _CosmicBackdrop extends StatefulWidget {
  const _CosmicBackdrop();

  @override
  State<_CosmicBackdrop> createState() => _CosmicBackdropState();
}

class _CosmicBackdropState extends State<_CosmicBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        final t = _controller.value;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.lerp(const Color(0xFF2A0F5C),
                    const Color(0xFF1A0846), t)!,
                Color.lerp(const Color(0xFF0A0420),
                    const Color(0xFF120636), t)!,
                const Color(0xFF030010),
              ],
              stops: const [0.0, 0.55, 1.0],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -80 + 20 * t,
                left: -60,
                child: _GlowOrb(
                  color: AppColors.gem.withValues(alpha: 0.35),
                  size: 260,
                ),
              ),
              Positioned(
                bottom: -100 - 20 * t,
                right: -80,
                child: _GlowOrb(
                  color: AppColors.primary.withValues(alpha: 0.30),
                  size: 320,
                ),
              ),
              Positioned(
                top: 220,
                right: -40,
                child: _GlowOrb(
                  color: AppColors.accent.withValues(alpha: 0.18),
                  size: 160,
                ),
              ),
              Positioned.fill(child: CustomPaint(painter: _StarsPainter(t))),
            ],
          ),
        );
      },
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  _StarsPainter(this.t);
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    const positions = <Offset>[
      Offset(0.05, 0.08), Offset(0.20, 0.04), Offset(0.35, 0.14),
      Offset(0.50, 0.06), Offset(0.66, 0.10), Offset(0.80, 0.05),
      Offset(0.92, 0.16), Offset(0.10, 0.28), Offset(0.30, 0.36),
      Offset(0.58, 0.24), Offset(0.76, 0.40), Offset(0.90, 0.48),
      Offset(0.05, 0.55), Offset(0.22, 0.66), Offset(0.42, 0.74),
      Offset(0.62, 0.82), Offset(0.84, 0.70), Offset(0.96, 0.92),
      Offset(0.32, 0.96), Offset(0.52, 0.10), Offset(0.16, 0.88),
      Offset(0.72, 0.58), Offset(0.06, 0.78), Offset(0.46, 0.50),
    ];
    final paint = Paint();
    for (var i = 0; i < positions.length; i++) {
      final p = positions[i];
      final twinkle = 0.4 + 0.6 * ((i % 5) / 5 + t) % 1.0;
      paint.color = Colors.white.withValues(alpha: twinkle.clamp(0.15, 0.95));
      final r = (i % 3 == 0) ? 1.8 : (i % 3 == 1 ? 1.1 : 0.7);
      canvas.drawCircle(
          Offset(p.dx * size.width, p.dy * size.height), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _StarsPainter old) => old.t != t;
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const SweepGradient(
            colors: [
              AppColors.primary,
              AppColors.gem,
              AppColors.accent,
              AppColors.primary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.6),
              blurRadius: 30,
              spreadRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.background,
          ),
          padding: const EdgeInsets.all(4),
          child: ClipOval(
            child: Image.asset(
              'assets/images/jeff.png',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => const _AvatarFallback(),
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.gem],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.person, color: Colors.white, size: 100),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PlayerProgress.instance,
      builder: (_, _) {
        final p = PlayerProgress.instance;
        final nextLevelXp = p.level * 280 + 600;
        final levelXp = (p.level - 1) * 280 + 600;
        final pct = ((p.xp - levelXp) / (nextLevelXp - levelXp))
            .clamp(0.0, 1.0);
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4)),
          ),
          child: Column(
            children: [
              const Text(
                'Jeff',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 4),
              const Text(
                'Viajante do Tempo',
                style: TextStyle(color: AppColors.accent),
              ),
              const SizedBox(height: 10),
              GlowPill(text: 'NIVEL ${p.level}'),
              const SizedBox(height: 14),
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: pct,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.accent],
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.6),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${p.xp} / $nextLevelXp XP',
                style: const TextStyle(
                    color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PlayerProgress.instance,
      builder: (_, _) {
        final p = PlayerProgress.instance;
        return Row(
          children: [
            Expanded(
              child: _StatTile(
                icon: Icons.local_fire_department_rounded,
                color: const Color(0xFFFF7A3D),
                value: '${p.streak}',
                label: 'Dias seguidos',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatTile(
                icon: Icons.menu_book_rounded,
                color: AppColors.accent,
                value: '${p.wordsLearned}',
                label: 'Palavras',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatTile(
                icon: Icons.monetization_on_rounded,
                color: AppColors.gold,
                value: '${p.coins}',
                label: 'Moedas',
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementsCard extends StatelessWidget {
  const _AchievementsCard();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PlayerProgress.instance,
      builder: (_, _) {
        final p = PlayerProgress.instance;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'CONQUISTAS',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${p.totalCompleted} / ${Campaign.chapters.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final c in Campaign.chapters)
                    _BadgeChip(
                      label: c.year,
                      icon: c.icon,
                      color: c.color,
                      earned: p.isCompleted(c),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StoryProgressCard extends StatelessWidget {
  const _StoryProgressCard();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PlayerProgress.instance,
      builder: (_, _) {
        final c = PlayerProgress.instance.currentChapter;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withValues(alpha: 0.25),
                AppColors.gem.withValues(alpha: 0.15),
              ],
            ),
            border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              const Icon(Icons.auto_stories_rounded,
                  color: AppColors.accent, size: 36),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Capitulo atual',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${c.year} - ${c.title}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.textMuted),
            ],
          ),
        );
      },
    );
  }
}


class _BadgeChip extends StatelessWidget {
  const _BadgeChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.earned,
  });

  final String label;
  final IconData icon;
  final Color color;
  final bool earned;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: earned ? 1 : 0.4,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withValues(alpha: 0.18),
              border: Border.all(
                color: earned ? color : AppColors.border,
                width: 2,
              ),
            ),
            alignment: Alignment.center,
            child: Icon(
              earned ? icon : Icons.lock_rounded,
              color: earned ? color : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
