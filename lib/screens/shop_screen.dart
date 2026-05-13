import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  static const _items = <_ShopItem>[
    _ShopItem('Bau Comum', 'Recompensas basicas', 50, Icons.inventory_2,
        AppColors.gold),
    _ShopItem('Bau Raro', 'Itens raros e XP extra', 150,
        Icons.card_giftcard_rounded, AppColors.gem),
    _ShopItem('Skin: Jeff Pirata', 'Visual exclusivo', 300,
        Icons.face_retouching_natural, AppColors.accent),
    _ShopItem('Pocao de XP 2x', 'Dobre o XP por 30min', 80,
        Icons.science_rounded, Colors.greenAccent),
    _ShopItem('Dica Magica', 'Revela uma resposta', 20,
        Icons.lightbulb_rounded, AppColors.goldLight),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
      children: [
        const Text(
          'Loja',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
        const Text(
          'Use moedas para acelerar a jornada',
          style: TextStyle(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.82,
          children: [
            for (final item in _items) _ShopCard(item: item),
          ],
        ),
      ],
    );
  }
}

class _ShopItem {
  const _ShopItem(this.name, this.desc, this.price, this.icon, this.color);
  final String name;
  final String desc;
  final int price;
  final IconData icon;
  final Color color;
}

class _ShopCard extends StatelessWidget {
  const _ShopCard({required this.item});
  final _ShopItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    item.color.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(item.icon, size: 64, color: item.color),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.name,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          Text(
            item.desc,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 11.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.monetization_on_rounded,
                    size: 14, color: AppColors.goldLight),
                const SizedBox(width: 4),
                Text(
                  '${item.price}',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
