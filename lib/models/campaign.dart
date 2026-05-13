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
    required this.intro,
    required this.heroLine,
    required this.outro,
    required this.location,
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

  /// Narrative shown before the quiz begins (the lore of this era).
  final String intro;

  /// Jeff's in-character motivational quote for this era.
  final String heroLine;

  /// Narrative shown after victory — sets up the next chapter.
  final String outro;

  /// Short location label ("Filadelfia, 1776").
  final String location;
}

/// Hard-coded campaign content — Jeff's journey through American history.
class Campaign {
  static const List<CampaignChapter> chapters = [
    CampaignChapter(
      id: 'independence',
      year: '1776',
      title: 'Independence Day',
      subtitle: 'A Declaracao em Filadelfia',
      location: 'Filadelfia, Pensilvania',
      icon: Icons.flag_rounded,
      color: Color(0xFFE2B255),
      xpReward: 80,
      coinReward: 30,
      intro:
          'Jeff acorda numa rua de paralelepipedos. Sinos badalam pela cidade '
          'e uma multidao se aglomera diante do Independence Hall. Treze '
          'colonias estao prestes a romper com a coroa britanica — e voce '
          'precisa entender cada palavra dessa Declaracao para sobreviver '
          'nesta nova terra.',
      heroLine:
          '"Se eu quero viver livre nesse mundo novo, preciso aprender a '
          'lingua da liberdade." — Jeff',
      outro:
          'A tinta da Declaracao mal secou. Jeff guarda no bolso uma copia '
          'do documento e parte rumo a Filadelfia outra vez — onde uma nova '
          'convencao decidira como esse povo livre sera governado.',
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
      location: 'Independence Hall, Filadelfia',
      icon: Icons.gavel_rounded,
      color: Color(0xFFC9A4FF),
      xpReward: 100,
      coinReward: 40,
      intro:
          'Onze anos depois da independencia, Jeff retorna a Filadelfia. '
          'Cinquenta e cinco delegados se trancam num salao abafado para '
          'redigir as regras do novo pais. Cada artigo, cada emenda, sera '
          'o alicerce de uma nacao — e Jeff precisa decifrar tudo antes que '
          'o tempo siga em frente.',
      heroLine:
          '"We the People... essas tres palavras vao ecoar pelos seculos. '
          'Preciso entender o que elas significam." — Jeff',
      outro:
          'Com a Constituicao ratificada, o continente parece pequeno demais. '
          'Napoleao oferece um pedaco gigantesco do oeste por uma pechincha '
          '— e Jeff sente o cheiro de aventura no ar.',
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
      location: 'Rio Missouri, fronteira oeste',
      icon: Icons.map_rounded,
      color: Color(0xFF7BD389),
      xpReward: 120,
      coinReward: 50,
      intro:
          'A nacao acaba de dobrar de tamanho. Jeff se junta a expedicao '
          'de Lewis e Clark, descendo o Missouri em canoas, dormindo sob '
          'estrelas que ninguem antes mapeou. Cada palavra em ingles agora '
          'pode salvar — ou custar — sua vida na fronteira selvagem.',
      heroLine:
          '"Esse continente e maior do que minha imaginacao. So o idioma '
          'pode me guiar de volta." — Jeff',
      outro:
          'Jeff retorna da expedicao com um diario cheio de palavras novas. '
          'Mas mal pisa em St. Louis, ouve gritos de "Gold!" vindos do '
          'oeste — California chama.',
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
      location: 'Sutter Mill, California',
      icon: Icons.terrain_rounded,
      color: Color(0xFFF6D27B),
      xpReward: 150,
      coinReward: 60,
      intro:
          'Sao Francisco se transformou de aldeia em metropole em meses. '
          'Mineiros chegam aos milhares: irlandeses, chineses, chilenos, '
          'todos gritando em linguas diferentes. Jeff levanta sua pa — mas '
          'sem ingles, qualquer "claim" pode ser roubado em segundos.',
      heroLine:
          '"O ouro nao esta so no rio. Esta em cada palavra que eu aprendo '
          'a negociar." — Jeff',
      outro:
          'Jeff sai da California com uma bolsa de pepitas e um vocabulario '
          'de minerador. Mas tambores de guerra ecoam do leste — irmao '
          'contra irmao, Norte contra Sul.',
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
      location: 'Gettysburg, Pensilvania',
      icon: Icons.shield_rounded,
      color: Color(0xFFFF7A3D),
      xpReward: 180,
      coinReward: 80,
      intro:
          'O pais se parte ao meio. Jeff atravessa campos de batalha em '
          'Gettysburg, traduzindo ordens, lendo cartas de soldados, '
          'ouvindo o discurso de um presidente alto e magro que prometeu '
          'libertar todos os escravizados. Palavras decidem o destino da '
          'Uniao.',
      heroLine:
          '"Liberdade nao e so um termo na Declaracao. Aqui, ela tem nome, '
          'corpo e historia." — Jeff',
      outro:
          'A guerra terminou. Trilhos de aco comecam a costurar o pais '
          'reunido. Jeff embarca num trem a vapor, rumo a uma era de '
          'fabricas, eletricidade e arranha-ceus.',
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
      location: 'Nova York, virada do seculo',
      icon: Icons.factory_rounded,
      color: Color(0xFF9B6BFF),
      xpReward: 200,
      coinReward: 90,
      intro:
          'Manhattan cresce para o ceu. Imigrantes chegam por Ellis Island '
          'a cada hora, e Jeff trabalha como interprete entre operarios '
          'e patroes. Maquinas a vapor, eletricidade, telefones — o '
          'vocabulario tecnico explode, e quem nao aprende fica para tras.',
      heroLine:
          '"Cada engrenagem dessa cidade fala uma palavra. Eu vou aprender '
          'todas." — Jeff',
      outro:
          'O seculo vinte avanca rapido. Duas guerras mundiais, radio, '
          'cinema, televisao. Jeff agora olha para cima — onde uma '
          'nova fronteira, prateada e silenciosa, espera ser alcancada.',
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
      location: 'Centro de Controle, Houston',
      icon: Icons.rocket_launch_rounded,
      color: Color(0xFFB14CFF),
      xpReward: 250,
      coinReward: 120,
      intro:
          'Bilhoes de pessoas seguram o folego. No cockpit da Apollo 11, '
          'Jeff escuta o "T minus ten..." pela ultima vez. Cada termo '
          'aerospacial, cada checklist em ingles, e a chave para nao '
          'ficar preso na orbita errada da historia.',
      heroLine:
          '"Aprender ingles me levou ate aqui. Agora, vou plantar uma '
          'bandeira em outro mundo." — Jeff',
      outro:
          'Neil Armstrong pisa na Lua. Jeff fecha o diario que comecou em '
          '1776 e sorri: aprendeu o suficiente para atravessar dois '
          'seculos, sete eras, e voltar para casa. A jornada continua — '
          'em voce.',
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
