import 'package:flutter/material.dart';

import '../models/campaign.dart';
import '../models/player_progress.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

/// Functional multiple-choice quiz screen.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.chapter});
  final CampaignChapter chapter;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _locked = false;
  bool _showIntro = true;

  Question get _q => widget.chapter.questions[_index];

  void _select(int i) {
    if (_locked) return;
    setState(() {
      _selected = i;
      _locked = true;
      if (i == _q.correctIndex) _score++;
    });
  }

  void _next() {
    if (_index + 1 < widget.chapter.questions.length) {
      setState(() {
        _index++;
        _selected = null;
        _locked = false;
      });
    } else {
      final navigator = Navigator.of(context);
      PlayerProgress.instance.recordScore(widget.chapter, _score);
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (_) => _ResultScreen(
            chapter: widget.chapter,
            score: _score,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showIntro) {
      return _LoreIntroScreen(
        chapter: widget.chapter,
        onBegin: () => setState(() => _showIntro = false),
      );
    }
    final total = widget.chapter.questions.length;
    final progress = (_index + (_locked ? 1 : 0)) / total;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${widget.chapter.year} - ${widget.chapter.title}'),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: StarryBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Questao ${_index + 1} / $total',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.check_circle,
                        color: AppColors.gold.withValues(alpha: 0.9),
                        size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '$_score',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: AppColors.border,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                  ),
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Text(
                          _q.prompt,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            height: 1.35,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _q.options.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (_, i) {
                            final isSelected = _selected == i;
                            final isCorrect = i == _q.correctIndex;
                            Color border = AppColors.border;
                            Color bg = AppColors.surface;
                            IconData? icon;
                            if (_locked) {
                              if (isCorrect) {
                                border = const Color(0xFF7BD389);
                                bg = const Color(0xFF1F3D2A);
                                icon = Icons.check_circle_rounded;
                              } else if (isSelected) {
                                border = const Color(0xFFFF5C5C);
                                bg = const Color(0xFF3D1F1F);
                                icon = Icons.cancel_rounded;
                              }
                            } else if (isSelected) {
                              border = AppColors.primary;
                            }
                            return InkWell(
                              onTap: () => _select(i),
                              borderRadius: BorderRadius.circular(14),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(color: border, width: 2),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: border.withValues(alpha: 0.25),
                                        border: Border.all(color: border),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        String.fromCharCode(65 + i),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        _q.options[i],
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (icon != null)
                                      Icon(icon, color: border),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (_locked && _q.explanation != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.accent.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.lightbulb_outline,
                                    color: AppColors.accent),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _q.explanation!,
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _locked ? _next : null,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            disabledBackgroundColor:
                                AppColors.primary.withValues(alpha: 0.3),
                            foregroundColor: Colors.white,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Text(
                            _index + 1 == total ? 'Finalizar' : 'Proxima',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultScreen extends StatelessWidget {
  const _ResultScreen({required this.chapter, required this.score});
  final CampaignChapter chapter;
  final int score;

  @override
  Widget build(BuildContext context) {
    final total = chapter.questions.length;
    final pct = score / total;
    final passed = pct >= 0.6;
    final stars = pct >= 0.9
        ? 3
        : pct >= 0.7
            ? 2
            : pct >= 0.5
                ? 1
                : 0;

    return Scaffold(
      body: StarryBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  passed ? 'Capitulo concluido!' : 'Quase la!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${chapter.year} - ${chapter.title}',
                  style: const TextStyle(color: AppColors.accent),
                ),
                const SizedBox(height: 32),
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        chapter.color.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(chapter.icon, size: 100, color: Colors.white),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    return Icon(
                      Icons.star_rounded,
                      size: 56,
                      color: i < stars
                          ? AppColors.gold
                          : AppColors.border,
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Text(
                  '$score de $total acertos',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 24),
                if (passed)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.gold),
                      const SizedBox(width: 4),
                      Text(
                        '+${chapter.xpReward * score ~/ total} XP',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 18),
                      const Icon(Icons.monetization_on_rounded,
                          color: AppColors.gold),
                      const SizedBox(width: 4),
                      Text(
                        '+${chapter.coinReward * score ~/ total}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                if (passed) ...[
                  const SizedBox(height: 22),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.accent.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.auto_stories_rounded,
                                color: AppColors.accent, size: 18),
                            SizedBox(width: 6),
                            Text(
                              'A jornada continua...',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                                color: AppColors.accent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          chapter.outro,
                          style: const TextStyle(
                            height: 1.4,
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Continuar a jornada',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Lore intro shown before the player tackles the questions.
class _LoreIntroScreen extends StatelessWidget {
  const _LoreIntroScreen({required this.chapter, required this.onBegin});
  final CampaignChapter chapter;
  final VoidCallback onBegin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${chapter.year} - ${chapter.title}'),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
      ),
      body: StarryBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: chapter.color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: chapter.color.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.place_rounded,
                          color: chapter.color, size: 16),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          chapter.location,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '· ${chapter.year}',
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        chapter.color.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                    ),
                    border: Border.all(
                      color: chapter.color,
                      width: 2,
                    ),
                  ),
                  child:
                      Icon(chapter.icon, color: Colors.white, size: 54),
                ),
                const SizedBox(height: 16),
                Text(
                  chapter.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  chapter.subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            chapter.intro,
                            style: const TextStyle(
                              height: 1.5,
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.gem.withValues(alpha: 0.25),
                                AppColors.primary.withValues(alpha: 0.18),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.accent.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.format_quote_rounded,
                                  color: AppColors.accent, size: 28),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  chapter.heroLine,
                                  style: const TextStyle(
                                    height: 1.4,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            _RewardChip(
                              icon: Icons.star_rounded,
                              color: AppColors.gold,
                              label: '${chapter.xpReward} XP',
                            ),
                            const SizedBox(width: 8),
                            _RewardChip(
                              icon: Icons.monetization_on_rounded,
                              color: AppColors.gold,
                              label: '${chapter.coinReward}',
                            ),
                            const SizedBox(width: 8),
                            _RewardChip(
                              icon: Icons.help_outline_rounded,
                              color: AppColors.accent,
                              label:
                                  '${chapter.questions.length} questoes',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: onBegin,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text(
                      'Comecar capitulo',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RewardChip extends StatelessWidget {
  const _RewardChip({
    required this.icon,
    required this.color,
    required this.label,
  });
  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
