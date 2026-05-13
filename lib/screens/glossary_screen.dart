import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Glossary screen showing English/Portuguese word pairs from key chapters
/// of Jeff's American history journey.
class GlossaryScreen extends StatefulWidget {
  const GlossaryScreen({super.key});

  @override
  State<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends State<GlossaryScreen> {
  String _query = '';

  static const _words = <_WordEntry>[
    _WordEntry('Independence', 'Independencia',
        'Era 1776 - A Declaracao de Independencia.'),
    _WordEntry('Freedom', 'Liberdade',
        'Conceito central das 13 Colonias.'),
    _WordEntry('Constitution', 'Constituicao',
        '1787 - A Convencao da Filadelfia.'),
    _WordEntry('Founding Fathers', 'Pais Fundadores',
        'Jefferson, Washington, Franklin...'),
    _WordEntry('Revolution', 'Revolucao',
        'A Guerra Revolucionaria Americana.'),
    _WordEntry('Frontier', 'Fronteira',
        'A expansao para o oeste no seculo XIX.'),
    _WordEntry('Pioneer', 'Pioneiro',
        'Os primeiros colonos a desbravar terras.'),
    _WordEntry('Civil War', 'Guerra Civil',
        '1861-1865 - Norte contra Sul.'),
    _WordEntry('Abolition', 'Abolicao',
        'O fim da escravidao.'),
    _WordEntry('Gold Rush', 'Corrida do Ouro',
        '1849 - California chama os aventureiros.'),
    _WordEntry('Steam Engine', 'Motor a Vapor',
        'Tecnologia que moveu trens e navios.'),
    _WordEntry('Liberty Bell', 'Sino da Liberdade',
        'Simbolo da independencia americana.'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _words
        .where((w) =>
            w.en.toLowerCase().contains(_query.toLowerCase()) ||
            w.pt.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      children: [
        _Header(
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
            itemBuilder: (_, i) => _WordCard(entry: filtered[i]),
          ),
        ),
      ],
    );
  }
}

class _WordEntry {
  const _WordEntry(this.en, this.pt, this.context);
  final String en;
  final String pt;
  final String context;
}

class _WordCard extends StatelessWidget {
  const _WordCard({required this.entry});
  final _WordEntry entry;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  entry.context,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.volume_up_rounded,
                color: AppColors.textSecondary),
            onPressed: () {},
          ),
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
