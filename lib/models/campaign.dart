import 'package:flutter/material.dart';

/// A single multiple-choice question.
class Question {
  const Question({
    required this.prompt,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });

  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String? explanation;
}

/// A chapter / era of the campaign.
class CampaignChapter {
  const CampaignChapter({
    required this.id,
    required this.year,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.questions,
    required this.xpReward,
    required this.coinReward,
  });

  final String id;
  final String year;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<Question> questions;
  final int xpReward;
  final int coinReward;
}

/// Hard-coded campaign content — Jeff's journey through American history.
class Campaign {
  static const List<CampaignChapter> chapters = [
    CampaignChapter(
      id: 'independence',
      year: '1776',
      title: 'Independence Day',
      subtitle: 'A Declaracao em Filadelfia',
      icon: Icons.flag_rounded,
      color: Color(0xFFE2B255),
      xpReward: 80,
      coinReward: 30,
      questions: [
        Question(
          prompt: 'O que significa "Independence" em portugues?',
          options: ['Liberdade', 'Independencia', 'Coragem', 'Justica'],
          correctIndex: 1,
          explanation: 'Independence = Independencia.',
        ),
        Question(
          prompt: 'Complete: "We hold these truths to be ___-evident."',
          options: ['self', 'true', 'high', 'all'],
          correctIndex: 0,
          explanation: '"Self-evident" = autoevidente.',
        ),
        Question(
          prompt: 'Quem escreveu a Declaracao de Independencia?',
          options: [
            'George Washington',
            'Benjamin Franklin',
            'Thomas Jefferson',
            'John Adams',
          ],
          correctIndex: 2,
        ),
        Question(
          prompt: 'O que significa "Freedom"?',
          options: ['Medo', 'Liberdade', 'Familia', 'Forca'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Em que ano foi assinada a Declaracao?',
          options: ['1492', '1776', '1812', '1865'],
          correctIndex: 1,
        ),
      ],
    ),
    CampaignChapter(
      id: 'constitution',
      year: '1787',
      title: 'The Constitution',
      subtitle: 'Convencao da Filadelfia',
      icon: Icons.gavel_rounded,
      color: Color(0xFFC9A4FF),
      xpReward: 100,
      coinReward: 40,
      questions: [
        Question(
          prompt: '"We the People" significa:',
          options: ['Nos as Pessoas', 'Para o Povo', 'Pela Patria', 'Em Paz'],
          correctIndex: 0,
        ),
        Question(
          prompt: 'O que e "Bill of Rights"?',
          options: [
            'Declaracao de Guerra',
            'Carta de Direitos',
            'Lista de Impostos',
            'Acordo de Paz',
          ],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Amendment"',
          options: ['Acordo', 'Emenda', 'Castigo', 'Anuncio'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'O Congresso americano tem duas camaras: Senate e ___?',
          options: ['Court', 'House', 'Council', 'Chamber'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Government"',
          options: ['Governo', 'Reino', 'Imperio', 'Estado'],
          correctIndex: 0,
        ),
      ],
    ),
    CampaignChapter(
      id: 'louisiana',
      year: '1803',
      title: 'Louisiana Purchase',
      subtitle: 'Rumo ao Oeste com Lewis & Clark',
      icon: Icons.map_rounded,
      color: Color(0xFF7BD389),
      xpReward: 120,
      coinReward: 50,
      questions: [
        Question(
          prompt: 'O que significa "Purchase"?',
          options: ['Venda', 'Compra', 'Troca', 'Doacao'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Frontier"',
          options: ['Fronteira', 'Floresta', 'Fortaleza', 'Fazenda'],
          correctIndex: 0,
        ),
        Question(
          prompt: '"River" significa:',
          options: ['Montanha', 'Lago', 'Rio', 'Vale'],
          correctIndex: 2,
        ),
        Question(
          prompt: 'Lewis and Clark eram:',
          options: ['Soldados', 'Exploradores', 'Politicos', 'Pintores'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Land"',
          options: ['Mar', 'Terra', 'Ceu', 'Pedra'],
          correctIndex: 1,
        ),
      ],
    ),
    CampaignChapter(
      id: 'gold_rush',
      year: '1849',
      title: 'Gold Rush',
      subtitle: 'A febre do ouro na California',
      icon: Icons.terrain_rounded,
      color: Color(0xFFF6D27B),
      xpReward: 150,
      coinReward: 60,
      questions: [
        Question(
          prompt: 'O que significa "Gold"?',
          options: ['Prata', 'Ouro', 'Bronze', 'Ferro'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Miner"',
          options: ['Mineiro', 'Marinheiro', 'Mercador', 'Mestre'],
          correctIndex: 0,
        ),
        Question(
          prompt: '"Nugget" significa:',
          options: ['Pepita', 'Caverna', 'Pa', 'Tenda'],
          correctIndex: 0,
        ),
        Question(
          prompt: 'Traduza: "Fortune"',
          options: ['Sorte', 'Fortuna', 'Forca', 'Familia'],
          correctIndex: 1,
        ),
        Question(
          prompt: '"Claim" no contexto da corrida do ouro:',
          options: ['Reclamar', 'Reivindicar terra', 'Cantar', 'Andar'],
          correctIndex: 1,
        ),
      ],
    ),
    CampaignChapter(
      id: 'civil_war',
      year: '1861',
      title: 'Civil War',
      subtitle: 'Norte vs Sul',
      icon: Icons.shield_rounded,
      color: Color(0xFFFF7A3D),
      xpReward: 180,
      coinReward: 80,
      questions: [
        Question(
          prompt: 'O que significa "War"?',
          options: ['Paz', 'Guerra', 'Vitoria', 'Derrota'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Slavery"',
          options: ['Liberdade', 'Escravidao', 'Trabalho', 'Sociedade'],
          correctIndex: 1,
        ),
        Question(
          prompt: '"Union" significa:',
          options: ['Uniao', 'Sul', 'Norte', 'Cidade'],
          correctIndex: 0,
        ),
        Question(
          prompt: 'Quem foi presidente durante a Guerra Civil?',
          options: [
            'Roosevelt',
            'Lincoln',
            'Jefferson',
            'Kennedy',
          ],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Abolition"',
          options: ['Abolicao', 'Adocao', 'Acao', 'Aliado'],
          correctIndex: 0,
        ),
      ],
    ),
    CampaignChapter(
      id: 'industry',
      year: '1900',
      title: 'Industrial Era',
      subtitle: 'Fabricas, trens e arranha-ceus',
      icon: Icons.factory_rounded,
      color: Color(0xFF9B6BFF),
      xpReward: 200,
      coinReward: 90,
      questions: [
        Question(
          prompt: '"Factory" significa:',
          options: ['Fabrica', 'Fazenda', 'Familia', 'Forca'],
          correctIndex: 0,
        ),
        Question(
          prompt: 'Traduza: "Railroad"',
          options: ['Estrada', 'Ferrovia', 'Cidade', 'Rio'],
          correctIndex: 1,
        ),
        Question(
          prompt: '"Worker" significa:',
          options: ['Patrao', 'Trabalhador', 'Visitante', 'Vendedor'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Skyscraper"',
          options: ['Aviao', 'Arranha-ceu', 'Estrela', 'Subida'],
          correctIndex: 1,
        ),
        Question(
          prompt: '"Invention" significa:',
          options: ['Invasao', 'Invencao', 'Invejavel', 'Iniciativa'],
          correctIndex: 1,
        ),
      ],
    ),
    CampaignChapter(
      id: 'moon',
      year: '1969',
      title: 'Moon Landing',
      subtitle: 'O salto final para casa',
      icon: Icons.rocket_launch_rounded,
      color: Color(0xFFB14CFF),
      xpReward: 250,
      coinReward: 120,
      questions: [
        Question(
          prompt: 'O que significa "Moon"?',
          options: ['Estrela', 'Lua', 'Sol', 'Planeta'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "One small step for man..."',
          options: [
            'Um grande salto',
            'Um pequeno passo para o homem',
            'Uma grande viagem',
            'Um sonho real',
          ],
          correctIndex: 1,
        ),
        Question(
          prompt: '"Astronaut" significa:',
          options: ['Aviador', 'Astronauta', 'Astronomo', 'Atleta'],
          correctIndex: 1,
        ),
        Question(
          prompt: 'Traduza: "Rocket"',
          options: ['Foguete', 'Robo', 'Rota', 'Roda'],
          correctIndex: 0,
        ),
        Question(
          prompt: 'Quem foi o primeiro homem na Lua?',
          options: [
            'Buzz Aldrin',
            'Neil Armstrong',
            'Yuri Gagarin',
            'John Glenn',
          ],
          correctIndex: 1,
        ),
      ],
    ),
  ];
}
