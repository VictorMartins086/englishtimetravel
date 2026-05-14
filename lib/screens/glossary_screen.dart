import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../theme/app_theme.dart';

/// Glossary screen showing English/Portuguese cognate pairs from key
/// chapters of Jeff's American history journey, with TTS pronunciation
/// and a detail sheet explaining the cognate pattern.
class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  String _query = '';
  final _GlossaryTts _tts = _GlossaryTts();
  String? _speakingWord;

  @override
  void initState() {
    super.initState();
    _tts.onComplete = () {
      if (mounted) setState(() => _speakingWord = null);
    };
  }

  @override
  void dispose() {
    _tts.dispose();
    super.dispose();
  }

  Future<void> _speak(String word) async {
    setState(() => _speakingWord = word);
    await _tts.speak(word);
  }

  static const _words = <_WordEntry>[
    _WordEntry(
      en: 'Independence',
      pt: 'Independencia',
      era: 'Era 1776 - A Declaracao de Independencia.',
      pattern: 'Sufixo -ence vira -encia. Mesma raiz latina.',
      example: 'The Declaration of Independence was signed in 1776.',
      exampleTranslation:
          'A Declaracao de Independencia foi assinada em 1776.',
    ),
    _WordEntry(
      en: 'Freedom',
      pt: 'Liberdade',
      era: 'Conceito central das 13 Colonias.',
      pattern:
          'Nao e cognato direto (raiz germanica), mas o sinonimo "Liberty" '
          'e cognato perfeito de "Liberdade" (-ty / -dade).',
      example: 'Freedom is the right of every citizen.',
      exampleTranslation: 'Liberdade e o direito de todo cidadao.',
    ),
    _WordEntry(
      en: 'Constitution',
      pt: 'Constituicao',
      era: '1787 - A Convencao da Filadelfia.',
      pattern: 'Sufixo -tion vira -cao. Padrao mais comum entre cognatos.',
      example: 'The Constitution defines the federal government.',
      exampleTranslation: 'A Constituicao define o governo federal.',
    ),
    _WordEntry(
      en: 'Founding Fathers',
      pt: 'Pais Fundadores',
      era: 'Jefferson, Washington, Franklin...',
      pattern:
          '"Founding" vem de "found" (fundar) - cognato com "fundar". '
          '"Father" tem raiz indo-europeia comum com "pai" (pater/padre).',
      example: 'The Founding Fathers wrote the Constitution.',
      exampleTranslation: 'Os Pais Fundadores escreveram a Constituicao.',
    ),
    _WordEntry(
      en: 'Revolution',
      pt: 'Revolucao',
      era: 'A Guerra Revolucionaria Americana.',
      pattern: 'Sufixo -tion vira -cao. Mesma raiz latina "revolvere".',
      example: 'The American Revolution began in 1775.',
      exampleTranslation: 'A Revolucao Americana comecou em 1775.',
    ),
    _WordEntry(
      en: 'Frontier',
      pt: 'Fronteira',
      era: 'A expansao para o oeste no seculo XIX.',
      pattern:
          'Cognato direto: ambos do latim "frons/frontis". Sufixo -er '
          'vira -eira.',
      example: 'The frontier moved further west each year.',
      exampleTranslation: 'A fronteira avancava mais para o oeste a cada ano.',
    ),
    _WordEntry(
      en: 'Pioneer',
      pt: 'Pioneiro',
      era: 'Os primeiros colonos a desbravar terras.',
      pattern: 'Cognato direto: -eer vira -eiro. Mesma raiz francesa.',
      example: 'Pioneers traveled in covered wagons.',
      exampleTranslation: 'Pioneiros viajavam em vagoes cobertos.',
    ),
    _WordEntry(
      en: 'Civil War',
      pt: 'Guerra Civil',
      era: '1861-1865 - Norte contra Sul.',
      pattern:
          '"Civil" e identico nas duas linguas. "War" e germanico, mas '
          'aparece em "guerrilla" / "guerrilha".',
      example: 'The Civil War divided the country.',
      exampleTranslation: 'A Guerra Civil dividiu o pais.',
    ),
    _WordEntry(
      en: 'Abolition',
      pt: 'Abolicao',
      era: 'O fim da escravidao.',
      pattern: 'Sufixo -tion vira -cao. Latim "abolere".',
      example: 'Lincoln supported the abolition of slavery.',
      exampleTranslation: 'Lincoln apoiou a abolicao da escravidao.',
    ),
    _WordEntry(
      en: 'Gold Rush',
      pt: 'Corrida do Ouro',
      era: '1849 - California chama os aventureiros.',
      pattern:
          '"Gold" e germanico (nao cognato com "ouro"). "Rush" significa '
          'corrida apressada - sem cognato direto.',
      example: 'The Gold Rush brought thousands to California.',
      exampleTranslation: 'A Corrida do Ouro trouxe milhares a California.',
    ),
    _WordEntry(
      en: 'Steam Engine',
      pt: 'Motor a Vapor',
      era: 'Tecnologia que moveu trens e navios.',
      pattern:
          '"Engine" e cognato de "engenho" (latim "ingenium"). "Steam" '
          'e germanico, mas a palavra "vapor" tambem existe em ingles.',
      example: 'The steam engine changed industry forever.',
      exampleTranslation: 'O motor a vapor mudou a industria para sempre.',
    ),
    _WordEntry(
      en: 'Liberty Bell',
      pt: 'Sino da Liberdade',
      era: 'Simbolo da independencia americana.',
      pattern: '"Liberty" e cognato perfeito de "Liberdade" (-ty / -dade).',
      example: 'The Liberty Bell is in Philadelphia.',
      exampleTranslation: 'O Sino da Liberdade fica na Filadelfia.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final q = _query.toLowerCase();
    final filtered = _words
        .where((w) =>
            w.en.toLowerCase().contains(q) || w.pt.toLowerCase().contains(q))
        .toList();

    return Column(
      children: [
        const _Header(
          title: 'Glossario',
          subtitle: 'A jornada de Jeff em palavras',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (v) => setState(() => _query = v),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Buscar palavra...',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              prefixIcon:
                  const Icon(Icons.search, color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 120),
            itemCount: filtered.length,
            separatorBuilder: (_, _) => const SizedBox(height: 10),
            itemBuilder: (_, i) => _WordCard(
              entry: filtered[i],
              isSpeaking: _speakingWord == filtered[i].en,
              onSpeak: () => _speak(filtered[i].en),
              onTap: () => _openDetail(filtered[i]),
            ),
          ),
        ),
      ],
    );
  }

  void _openDetail(_WordEntry entry) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => _WordDetailSheet(entry: entry, tts: _tts),
    );
  }
}

class _WordEntry {
  const _WordEntry({
    required this.en,
    required this.pt,
    required this.era,
    required this.pattern,
    required this.example,
    required this.exampleTranslation,
  });

  final String en;
  final String pt;
  final String era;
  final String pattern;
  final String example;
  final String exampleTranslation;
}

class _WordCard extends StatelessWidget {
  const _WordCard({
    required this.entry,
    required this.isSpeaking,
    required this.onSpeak,
    required this.onTap,
  });

  final _WordEntry entry;
  final bool isSpeaking;
  final VoidCallback onSpeak;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                entry.en[0],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.accent,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.en,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    entry.pt,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    entry.era,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Ouvir pronuncia',
              icon: Icon(
                isSpeaking
                    ? Icons.graphic_eq_rounded
                    : Icons.volume_up_rounded,
                color:
                    isSpeaking ? AppColors.primary : AppColors.textSecondary,
              ),
              onPressed: onSpeak,
            ),
          ],
        ),
      ),
    );
  }
}

class _WordDetailSheet extends StatelessWidget {
  const _WordDetailSheet({required this.entry, required this.tts});

  final _WordEntry entry;
  final _GlossaryTts tts;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.en,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          entry.pt,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    shape: const CircleBorder(),
                    child: IconButton(
                      tooltip: 'Ouvir',
                      iconSize: 28,
                      icon: const Icon(
                        Icons.volume_up_rounded,
                        color: AppColors.accent,
                      ),
                      onPressed: () => tts.speak(entry.en),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _DetailBlock(
                icon: Icons.history_edu_rounded,
                color: AppColors.gold,
                title: 'Contexto historico',
                body: entry.era,
              ),
              const SizedBox(height: 10),
              _DetailBlock(
                icon: Icons.translate_rounded,
                color: AppColors.primary,
                title: 'Padrao de cognato',
                body: entry.pattern,
              ),
              const SizedBox(height: 10),
              _DetailBlock(
                icon: Icons.format_quote_rounded,
                color: AppColors.accent,
                title: 'Exemplo de uso',
                body: entry.example,
                footer: entry.exampleTranslation,
                onPlay: () => tts.speak(entry.example),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock({
    required this.icon,
    required this.color,
    required this.title,
    required this.body,
    this.footer,
    this.onPlay,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String body;
  final String? footer;
  final VoidCallback? onPlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),
              if (onPlay != null)
                InkWell(
                  onTap: onPlay,
                  borderRadius: BorderRadius.circular(20),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          if (footer != null) ...[
            const SizedBox(height: 6),
            Text(
              footer!,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
                height: 1.35,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

/// Lightweight wrapper around flutter_tts: en-US voice, slower rate for
/// learners, single shared instance to avoid overlapping speech.
class _GlossaryTts {
  _GlossaryTts() {
    _tts = FlutterTts();
    _init();
  }

  late final FlutterTts _tts;
  bool _ready = false;
  VoidCallback? onComplete;

  Future<void> _init() async {
    try {
      await _tts.setLanguage('en-US');
      await _tts.setSpeechRate(0.45);
      await _tts.setPitch(1.0);
      await _tts.setVolume(1.0);
    } catch (_) {
      // Some platforms throw if voices not yet loaded; safe to ignore.
    }
    _tts.setCompletionHandler(() => onComplete?.call());
    _tts.setCancelHandler(() => onComplete?.call());
    _tts.setErrorHandler((_) => onComplete?.call());
    _ready = true;
  }

  Future<void> speak(String text) async {
    if (!_ready) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
    }
    await _tts.stop();
    await _tts.speak(text);
  }

  void dispose() {
    _tts.stop();
  }
}
