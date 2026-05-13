import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  static const _challenges = <_Challenge>[
    _Challenge(
      era: '1776',
      title: 'Independence Day',
      description: 'Traduza palavras-chave da Declaracao.',
      xp: 80,
      coins: 30,
      unlocked: true,
      progress: 1.0,
    ),
    _Challenge(
      era: '1787',
      title: 'The Constitution',
      description: 'Complete frases dos artigos fundadores.',
      xp: 100,
      coins: 40,
      unlocked: true,
      progress: 0.6,
    ),
    _Challenge(
      era: '1803',
      title: 'Louisiana Purchase',
      description: 'Vocabulario sobre territorios e mapas.',
      xp: 120,
      coins: 50,
      unlocked: true,
      progress: 0.2,
    ),
    _Challenge(
      era: '1849',
      title: 'Gold Rush',
      description: 'Aprenda termos da corrida do ouro.',
      xp: 150,
      coins: 60,
      unlocked: false,
      progress: 0.0,
    ),
    _Challenge(
      era: '1861',
      title: 'Civil War',
      description: 'Norte vs Sul - vocabulario de guerra.',
      xp: 180,
      coins: 80,
      unlocked: false,
      progress: 0.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      children: [
        const Text(
          'Desafios',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const Text(
          'Avance pelas eras da historia americana',
          style: TextStyle(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        for (final c in _challenges) ...[
          _ChallengeCard(challenge: c),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _Challenge {
  const _Challenge({
    required this.era,
    required this.title,
    required this.description,
    required this.xp,
    required this.coins,
    required this.unlocked,
    required this.progress,
  });

  final String era;
  final String title;
  final String description;
  final int xp;
  final int coins;
  final bool unlocked;
  final double progress;
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge});
  final _Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final locked = !challenge.unlocked;
    return Opacity(
      opacity: locked ? 0.55 : 1,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: locked ? AppColors.border : AppColors.primary
                .withValues(alpha: 0.55),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    challenge.era,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: AppColors.accent,
                    ),
                  ),
                ),
                const Spacer(),
                if (locked)
                  const Icon(Icons.lock_rounded,
                      color: AppColors.textMuted, size: 20),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              challenge.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              challenge.description,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: challenge.progress,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star_rounded,
                    color: AppColors.gold, size: 16),
                const SizedBox(width: 4),
                Text('${challenge.xp} XP',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(width: 12),
                const Icon(Icons.monetization_on_rounded,
                    color: AppColors.gold, size: 16),
                const SizedBox(width: 4),
                Text('${challenge.coins}',
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const Spacer(),
                FilledButton(
                  onPressed: locked ? null : () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(locked ? 'Bloqueado' : 'Jogar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
