import 'package:flutter/foundation.dart';

import 'campaign.dart';

/// Simple in-memory progression store. Notifies listeners on changes so the
/// timeline and HUD update immediately after a quiz finishes.
class PlayerProgress extends ChangeNotifier {
  PlayerProgress._();
  static final PlayerProgress instance = PlayerProgress._();

  int xp = 2450;
  int coins = 1250;
  int gems = 120;
  int level = 12;
  int streak = 7;
  int wordsLearned = 142;

  /// Id of the most recently completed chapter (for "Ultima conquista" card).
  String? lastCompletedId = 'independence';

  /// Map of chapter.id -> best score (0..questions.length). Missing = locked.
  final Map<String, int> _scores = {
    'independence': 5, // completed perfect
    'constitution': 3, // in progress
  };

  int scoreFor(String id) => _scores[id] ?? 0;

  bool isUnlocked(CampaignChapter c) {
    final idx = Campaign.chapters.indexWhere((x) => x.id == c.id);
    if (idx == 0) return true;
    final prev = Campaign.chapters[idx - 1];
    // Unlock when previous chapter has at least 60% correct.
    return scoreFor(prev.id) >= (prev.questions.length * 0.6).ceil();
  }

  bool isCompleted(CampaignChapter c) =>
      scoreFor(c.id) >= (c.questions.length * 0.8).ceil();

  double progressFor(CampaignChapter c) =>
      scoreFor(c.id) / c.questions.length;

  CampaignChapter get currentChapter {
    for (final c in Campaign.chapters) {
      if (!isCompleted(c) && isUnlocked(c)) return c;
    }
    return Campaign.chapters.last;
  }

  int get totalCompleted =>
      Campaign.chapters.where(isCompleted).length;

  void recordScore(CampaignChapter c, int score) {
    final prev = _scores[c.id] ?? 0;
    final wasCompleted = isCompleted(c);
    if (score > prev) {
      _scores[c.id] = score;
      xp += c.xpReward * score ~/ c.questions.length;
      coins += c.coinReward * score ~/ c.questions.length;
      wordsLearned += (score - prev);
      // simple level up
      while (xp >= level * 280 + 600) {
        level++;
      }
    }
    // Mark as last completed if this run reached the completion threshold.
    if (!wasCompleted && isCompleted(c)) {
      lastCompletedId = c.id;
      streak++;
    }
    notifyListeners();
  }

  CampaignChapter? get lastCompletedChapter {
    if (lastCompletedId == null) return null;
    for (final c in Campaign.chapters) {
      if (c.id == lastCompletedId) return c;
    }
    return null;
  }
}
