import 'package:flutter/material.dart';

import '../models/campaign.dart';
import '../models/player_progress.dart';
import '../theme/app_theme.dart';
import '../widgets/campaign_timeline.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PlayerProgress.instance,
      builder: (_, _) {
        final p = PlayerProgress.instance;
        final total = Campaign.chapters.length;
        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
          children: [
            const Text(
              'Desafios',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            const Text(
              'Avance pelas eras da historia americana',
              style: TextStyle(color: AppColors.textMuted),
            ),
            const SizedBox(height: 18),
            _CampaignStats(done: p.totalCompleted, total: total),
            const SizedBox(height: 22),
            const CampaignTimeline(),
          ],
        );
      },
    );
  }
}

class _CampaignStats extends StatelessWidget {
  const _CampaignStats({required this.done, required this.total});
  final int done;
  final int total;

  @override
  Widget build(BuildContext context) {
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
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.timeline_rounded,
              color: AppColors.accent, size: 40),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Campanha',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '$done / $total capitulos concluidos',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: done / total,
                    minHeight: 7,
                    backgroundColor: AppColors.border,
                    valueColor:
                        const AlwaysStoppedAnimation(AppColors.accent),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
