import 'package:flutter/material.dart';

import '../models/campaign.dart';
import '../models/player_progress.dart';
import '../theme/app_theme.dart';
import '../screens/quiz_screen.dart';

/// Vertical timeline of the campaign. Locked / current / completed states.
class CampaignTimeline extends StatelessWidget {
  const CampaignTimeline({super.key, this.compact = false});

  /// When true, renders smaller nodes (used inside Home).
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: PlayerProgress.instance,
      builder: (ctx, _) {
        final progress = PlayerProgress.instance;
        final chapters = Campaign.chapters;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < chapters.length; i++)
              _TimelineNode(
                chapter: chapters[i],
                isFirst: i == 0,
                isLast: i == chapters.length - 1,
                state: _stateFor(chapters[i], progress),
                progress: progress.progressFor(chapters[i]),
                onTap: progress.isUnlocked(chapters[i])
                    ? () => Navigator.of(ctx).push(
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(chapter: chapters[i]),
                          ),
                        )
                    : null,
                compact: compact,
              ),
          ],
        );
      },
    );
  }

  _NodeState _stateFor(CampaignChapter c, PlayerProgress p) {
    if (!p.isUnlocked(c)) return _NodeState.locked;
    if (p.isCompleted(c)) return _NodeState.completed;
    if (p.scoreFor(c.id) > 0) return _NodeState.inProgress;
    if (p.currentChapter.id == c.id) return _NodeState.current;
    return _NodeState.available;
  }
}

enum _NodeState { locked, available, current, inProgress, completed }

class _TimelineNode extends StatelessWidget {
  const _TimelineNode({
    required this.chapter,
    required this.isFirst,
    required this.isLast,
    required this.state,
    required this.progress,
    required this.onTap,
    required this.compact,
  });

  final CampaignChapter chapter;
  final bool isFirst;
  final bool isLast;
  final _NodeState state;
  final double progress;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final nodeSize = compact ? 44.0 : 56.0;
    final color = switch (state) {
      _NodeState.completed => const Color(0xFF7BD389),
      _NodeState.current => AppColors.primary,
      _NodeState.inProgress => AppColors.accent,
      _NodeState.available => AppColors.accent,
      _NodeState.locked => AppColors.border,
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Rail + node column
          SizedBox(
            width: nodeSize + 12,
            child: Column(
              children: [
                Container(
                  width: 3,
                  height: isFirst ? 0 : 12,
                  color: AppColors.border,
                ),
                _Node(
                  size: nodeSize,
                  color: color,
                  state: state,
                  icon: chapter.icon,
                  pulse: state == _NodeState.current,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            color.withValues(alpha: 0.7),
                            AppColors.border,
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 14, top: 4),
              child: _NodeCard(
                chapter: chapter,
                state: state,
                progress: progress,
                onTap: onTap,
                compact: compact,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Node extends StatefulWidget {
  const _Node({
    required this.size,
    required this.color,
    required this.state,
    required this.icon,
    required this.pulse,
  });

  final double size;
  final Color color;
  final _NodeState state;
  final IconData icon;
  final bool pulse;

  @override
  State<_Node> createState() => _NodeStateView();
}

class _NodeStateView extends State<_Node> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inner = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.state == _NodeState.locked
            ? AppColors.surfaceAlt
            : widget.color.withValues(alpha: 0.18),
        border: Border.all(color: widget.color, width: 2.5),
        boxShadow: widget.state == _NodeState.locked
            ? null
            : [
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.45),
                  blurRadius: 14,
                ),
              ],
      ),
      alignment: Alignment.center,
      child: Icon(
        widget.state == _NodeState.locked
            ? Icons.lock_rounded
            : widget.state == _NodeState.completed
                ? Icons.check_rounded
                : widget.icon,
        color: widget.state == _NodeState.locked
            ? AppColors.textMuted
            : Colors.white,
        size: widget.size * 0.5,
      ),
    );
    if (!widget.pulse) return inner;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final t = _controller.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.size + 18 * t,
              height: widget.size + 18 * t,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.color.withValues(alpha: 0.5 * (1 - t)),
                  width: 2,
                ),
              ),
            ),
            child!,
          ],
        );
      },
      child: inner,
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({
    required this.chapter,
    required this.state,
    required this.progress,
    required this.onTap,
    required this.compact,
  });

  final CampaignChapter chapter;
  final _NodeState state;
  final double progress;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final locked = state == _NodeState.locked;
    final completed = state == _NodeState.completed;

    return Opacity(
      opacity: locked ? 0.55 : 1,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            padding: EdgeInsets.all(compact ? 12 : 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: state == _NodeState.current
                    ? AppColors.primary
                    : AppColors.border,
                width: state == _NodeState.current ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: chapter.color.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        chapter.year,
                        style: TextStyle(
                          color: chapter.color,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        chapter.title,
                        style: TextStyle(
                          fontSize: compact ? 14 : 15.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    if (completed)
                      const Icon(Icons.verified_rounded,
                          color: Color(0xFF7BD389), size: 18)
                    else if (state == _NodeState.current)
                      const _CurrentBadge()
                    else if (locked)
                      const Icon(Icons.lock_rounded,
                          color: AppColors.textMuted, size: 16),
                  ],
                ),
                if (!compact) ...[
                  const SizedBox(height: 4),
                  Text(
                    chapter.subtitle,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: AppColors.border,
                    valueColor: AlwaysStoppedAnimation(chapter.color),
                  ),
                ),
                if (!compact) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.gold, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '${chapter.xpReward} XP',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.monetization_on_rounded,
                          color: AppColors.gold, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '${chapter.coinReward}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${chapter.questions.length} questoes',
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CurrentBadge extends StatelessWidget {
  const _CurrentBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'AGORA',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
