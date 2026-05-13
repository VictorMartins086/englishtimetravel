import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'campaign.dart';

/// Persistent progression store. State is loaded from SharedPreferences at
/// startup via [load] and saved automatically on every change. Notifies
/// listeners so timeline and HUD update immediately after a quiz.
class PlayerProgress extends ChangeNotifier {
  PlayerProgress._();
  static final PlayerProgress instance = PlayerProgress._();

  static const _kKey = 'english_time_travel.progress.v1';

  int xp = 0;
  int coins = 0;
  int gems = 0;
  int level = 1;
  int streak = 0;
  int wordsLearned = 0;
  String? lastCompletedId;

  /// Map of chapter.id -> best score (0..questions.length). Missing = not yet
  /// played.
  final Map<String, int> _scores = {};

  SharedPreferences? _prefs;

  /// Loads progress from disk. Call once during app start (before runApp).
  /// If no saved state exists, seeds a fresh account with starter resources.
  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs!.getString(_kKey);
    if (raw == null) {
      _seedNewAccount();
      await _persist();
      return;
    }
    try {
      final data = json.decode(raw) as Map<String, dynamic>;
      xp = (data['xp'] as num?)?.toInt() ?? 0;
      coins = (data['coins'] as num?)?.toInt() ?? 0;
      gems = (data['gems'] as num?)?.toInt() ?? 0;
      level = (data['level'] as num?)?.toInt() ?? 1;
      streak = (data['streak'] as num?)?.toInt() ?? 0;
      wordsLearned = (data['wordsLearned'] as num?)?.toInt() ?? 0;
      lastCompletedId = data['lastCompletedId'] as String?;
      _scores.clear();
      final s = data['scores'];
      if (s is Map) {
        s.forEach((k, v) {
          if (k is String && v is num) _scores[k] = v.toInt();
        });
      }
    } catch (_) {
      _seedNewAccount();
      await _persist();
    }
  }

  void _seedNewAccount() {
    xp = 0;
    coins = 50;
    gems = 5;
    level = 1;
    streak = 0;
    wordsLearned = 0;
    lastCompletedId = null;
    _scores.clear();
  }

  Future<void> _persist() async {
    final prefs = _prefs;
    if (prefs == null) return;
    final data = <String, dynamic>{
      'xp': xp,
      'coins': coins,
      'gems': gems,
      'level': level,
      'streak': streak,
      'wordsLearned': wordsLearned,
      'lastCompletedId': lastCompletedId,
      'scores': _scores,
    };
    await prefs.setString(_kKey, json.encode(data));
  }

  /// Wipes saved state and reseeds a fresh account.
  Future<void> resetAll() async {
    _seedNewAccount();
    await _persist();
    notifyListeners();
  }

  int scoreFor(String id) => _scores[id] ?? 0;

  bool isUnlocked(CampaignChapter c) {
    final idx = Campaign.chapters.indexWhere((x) => x.id == c.id);
    if (idx == 0) return true;
    final prev = Campaign.chapters[idx - 1];
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

  int get totalCompleted => Campaign.chapters.where(isCompleted).length;

  CampaignChapter? get lastCompletedChapter {
    if (lastCompletedId == null) return null;
    for (final c in Campaign.chapters) {
      if (c.id == lastCompletedId) return c;
    }
    return null;
  }

  /// Records the score of a quiz run for chapter [c]. Only improves over
  /// previous best. Updates XP, coins, level, streak and last-completed
  /// pointer; then persists and notifies listeners.
  Future<void> recordScore(CampaignChapter c, int score) async {
    final prev = _scores[c.id] ?? 0;
    final wasCompleted = isCompleted(c);
    if (score > prev) {
      _scores[c.id] = score;
      xp += c.xpReward * score ~/ c.questions.length;
      coins += c.coinReward * score ~/ c.questions.length;
      wordsLearned += (score - prev);
      while (xp >= level * 280 + 600) {
        level++;
        gems += 5; // small reward for leveling up
      }
    }
    if (!wasCompleted && isCompleted(c)) {
      lastCompletedId = c.id;
      streak++;
    }
    await _persist();
    notifyListeners();
  }
}
