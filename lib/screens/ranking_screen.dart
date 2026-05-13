import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  static const _players = <_Player>[
    _Player('Jeff (Voce)', 12, 2450, true),
    _Player('Liberty_77', 18, 5210, false),
    _Player('Eagle Master', 17, 4980, false),
    _Player('TimeLord_1865', 15, 3870, false),
    _Player('ConstitutionFan', 14, 3100, false),
    _Player('FrontierKid', 11, 2200, false),
    _Player('PioneerGirl', 10, 1980, false),
  ];

  @override
  Widget build(BuildContext context) {
    final sorted = [..._players]..sort((a, b) => b.xp.compareTo(a.xp));

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      children: [
        const Text(
          'Ranking',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const Text(
          'Os melhores viajantes do tempo',
          style: TextStyle(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < sorted.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _RankRow(rank: i + 1, player: sorted[i]),
          ),
      ],
    );
  }
}

class _Player {
  const _Player(this.name, this.level, this.xp, this.isMe);
  final String name;
  final int level;
  final int xp;
  final bool isMe;
}

class _RankRow extends StatelessWidget {
  const _RankRow({required this.rank, required this.player});
  final int rank;
  final _Player player;

  Color _medalColor() {
    if (rank == 1) return AppColors.gold;
    if (rank == 2) return const Color(0xFFC0C0C0);
    if (rank == 3) return const Color(0xFFCD7F32);
    return AppColors.textMuted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: player.isMe
            ? AppColors.primary.withValues(alpha: 0.18)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: player.isMe ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32,
            child: rank <= 3
                ? Icon(Icons.emoji_events_rounded,
                    color: _medalColor(), size: 26)
                : Text(
                    '$rank',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textMuted,
                    ),
                  ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.gem],
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              player.name[0],
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: player.isMe
                        ? AppColors.accent
                        : AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Nivel ${player.level}',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${player.xp}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              const Text(
                'XP',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
