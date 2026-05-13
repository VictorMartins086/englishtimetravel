import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/common.dart';

/// Story screen presenting Jeff's adventure across American history.
class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  static const _chapters = <_Chapter>[
    _Chapter(
      year: '1776',
      title: 'A Faisca da Independencia',
      text:
          'Jeff acorda em Filadelfia, no dia em que a Declaracao de Independencia '
          'e assinada. Sem entender uma palavra de ingles, ele precisa decifrar '
          'os termos dos Founding Fathers para descobrir como voltar para casa.',
      icon: Icons.flag_rounded,
      unlocked: true,
    ),
    _Chapter(
      year: '1787',
      title: 'A Constituicao',
      text:
          'Na Convencao da Filadelfia, Jeff ajuda a copiar artigos da nova '
          'Constituicao. Cada palavra aprendida o aproxima do proximo portal.',
      icon: Icons.gavel_rounded,
      unlocked: true,
    ),
    _Chapter(
      year: '1803',
      title: 'Louisiana Purchase',
      text:
          'Jeff embarca com Lewis e Clark rumo ao oeste, aprendendo termos de '
          'geografia, comercio e diplomacia com os povos nativos.',
      icon: Icons.map_rounded,
      unlocked: true,
    ),
    _Chapter(
      year: '1849',
      title: 'A Corrida do Ouro',
      text:
          'Na Californinia, Jeff trabalha em uma mina e descobre o vocabulario '
          'da febre do ouro: claim, nugget, fortune.',
      icon: Icons.terrain_rounded,
      unlocked: false,
    ),
    _Chapter(
      year: '1861',
      title: 'Guerra Civil',
      text:
          'Norte vs Sul. Jeff atravessa linhas inimigas como mensageiro e '
          'aprende termos de estrategia, abolicao e uniao.',
      icon: Icons.shield_rounded,
      unlocked: false,
    ),
    _Chapter(
      year: '1969',
      title: 'Moon Landing',
      text:
          'O salto final no tempo: Jeff acompanha a Apollo 11. Sera que ele '
          'finalmente encontra o portal de volta para o presente?',
      icon: Icons.rocket_launch_rounded,
      unlocked: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('A Historia de Jeff'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StarryBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            children: [
              const SizedBox(height: 8),
              const _HeroIntro(),
              const SizedBox(height: 20),
              const Text(
                'CAPITULOS',
                style: TextStyle(
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              for (var i = 0; i < _chapters.length; i++)
                _ChapterTimeline(
                  chapter: _chapters[i],
                  isLast: i == _chapters.length - 1,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroIntro extends StatelessWidget {
  const _HeroIntro();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.18),
            AppColors.gem.withValues(alpha: 0.10),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.gem],
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.person, color: Colors.white, size: 38),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jeff',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Viajante do Tempo',
                      style: TextStyle(color: AppColors.accent),
                    ),
                  ],
                ),
              ),
              const GlowPill(text: 'NIVEL 12'),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Em 2026, Jeff encontrou um relogio antigo no sotao do avo. '
            'Ao toca-lo, foi sugado para 1776, no exato momento da assinatura '
            'da Declaracao de Independencia dos Estados Unidos. Sem falar uma '
            'palavra de ingles, ele precisa atravessar as eras, aprendendo o '
            'idioma e a historia para encontrar o caminho de volta.',
            style: TextStyle(
              color: AppColors.textSecondary,
              height: 1.5,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chapter {
  const _Chapter({
    required this.year,
    required this.title,
    required this.text,
    required this.icon,
    required this.unlocked,
  });

  final String year;
  final String title;
  final String text;
  final IconData icon;
  final bool unlocked;
}

class _ChapterTimeline extends StatelessWidget {
  const _ChapterTimeline({required this.chapter, required this.isLast});

  final _Chapter chapter;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: chapter.unlocked
                      ? AppColors.primary
                      : AppColors.surfaceAlt,
                  border: Border.all(
                    color: chapter.unlocked
                        ? AppColors.accent
                        : AppColors.border,
                    width: 2,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  chapter.unlocked ? chapter.icon : Icons.lock_rounded,
                  color: chapter.unlocked
                      ? Colors.white
                      : AppColors.textMuted,
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.border,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          chapter.year,
                          style: const TextStyle(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.4,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            chapter.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      chapter.text,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.4,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
