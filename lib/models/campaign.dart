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
          prompt: 'Cognato: "Independence" em portugues e...',
          options: ['Liberdade', 'Independencia', 'Importancia', 'Identidade'],
          correctIndex: 1,
          explanation:
              'Cognatos identicos: Independence -> Independencia. Mesma raiz latina "in-dependere".',
        ),
        Question(
          prompt: 'A palavra "Declaration" e cognata de...',
          options: ['Decoracao', 'Declaracao', 'Dedicacao', 'Definicao'],
          correctIndex: 1,
          explanation: 'Declaration = Declaracao. Sufixo -tion vira -cao em portugues.',
        ),
        Question(
          prompt: 'Cognato historico: "Nation" significa...',
          options: ['Nacao', 'Norte', 'Nobre', 'Numero'],
          correctIndex: 0,
          explanation: 'Nation -> Nacao. Outro -tion / -cao.',
        ),
        Question(
          prompt: 'Em 1776, o "Congress" se reuniu em Filadelfia. Cognato:',
          options: ['Congresso', 'Conselho', 'Confronto', 'Convite'],
          correctIndex: 0,
        ),
        Question(
          prompt: 'Complete o cognato: "Liber__" significa Liberdade.',
          options: ['ate', 'ty', 'al', 'ous'],
          correctIndex: 1,
          explanation: 'Liberty = Liberdade. Sufixo -ty vira -dade.',
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
          prompt: 'Cognato: "Constitution" em portugues e...',
          options: ['Construcao', 'Constituicao', 'Contribuicao', 'Conclusao'],
          correctIndex: 1,
          explanation: 'Constitution -> Constituicao. Mais um -tion / -cao.',
        ),
        Question(
          prompt:
              'Os delegados escreveram artigos. "Article" em portugues e...',
          options: ['Artigo', 'Arte', 'Aresta', 'Atalho'],
          correctIndex: 0,
          explanation: 'Article = Artigo. Cognato direto.',
        ),
        Question(
          prompt: 'A federacao nasce aqui. "Federal" em portugues e...',
          options: ['Final', 'Federal', 'Falso', 'Famoso'],
          correctIndex: 1,
          explanation: '"Federal" e identico em ingles e portugues.',
        ),
        Question(
          prompt: 'Complete: "Senate and House of Repre___".',
          options: ['sentatives', 'served', 'sented', 'sealing'],
          correctIndex: 0,
          explanation: 'Representatives = Representantes. Outro cognato claro.',
        ),
        Question(
          prompt: 'O cognato de "Amendment" em portugues e:',
          options: ['Andamento', 'Acordo', 'Emenda', 'Atalho'],
          correctIndex: 2,
          explanation:
              'Amendment e quase cognato de "emenda" (raiz latina "emendare").',
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
          prompt: 'A nova "Territory" e enorme. Cognato em portugues:',
          options: ['Tropa', 'Territorio', 'Tesouro', 'Tradicao'],
          correctIndex: 1,
          explanation: 'Territory -> Territorio. Sufixo -y / -io.',
        ),
        Question(
          prompt: 'Lewis & Clark lead an "expedition". Cognato:',
          options: ['Exposicao', 'Expedicao', 'Explosao', 'Excursao'],
          correctIndex: 1,
          explanation: 'Expedition = Expedicao. Outro -tion / -cao.',
        ),
        Question(
          prompt:
              'The verb "to explore" comes from the same root as o verbo...',
          options: ['Esperar', 'Explorar', 'Explicar', 'Empurrar'],
          correctIndex: 1,
          explanation: 'Explore = Explorar. Cognato verbal direto.',
        ),
        Question(
          prompt: 'They cross the "continent". Cognato em portugues:',
          options: ['Continente', 'Conteudo', 'Continuo', 'Contador'],
          correctIndex: 0,
        ),
        Question(
          prompt: 'Complete: "The Native ___ welcomed the explorers."',
          options: ['Americans', 'Animals', 'Armies', 'Areas'],
          correctIndex: 0,
          explanation:
              'Native = Nativo. Americans = Americanos. Dois cognatos numa frase.',
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
          prompt: 'Everyone seeks "fortune". Portuguese cognate:',
          options: ['Forma', 'Fortuna', 'Floresta', 'Frota'],
          correctIndex: 1,
          explanation: 'Fortune = Fortuna. Cognato direto.',
        ),
        Question(
          prompt: 'A "mineral" rock in Portuguese is...',
          options: ['Madeira', 'Mineral', 'Marmore', 'Metano'],
          correctIndex: 1,
          explanation: '"Mineral" e identico nas duas linguas.',
        ),
        Question(
          prompt: 'Thousands of "immigrants" arrive. Cognato:',
          options: ['Imitadores', 'Imigrantes', 'Ilustres', 'Iniciantes'],
          correctIndex: 1,
          explanation: 'Immigrant = Imigrante.',
        ),
        Question(
          prompt: 'The brave "pioneer" travels west. Cognato:',
          options: ['Pirata', 'Pioneiro', 'Pintor', 'Padeiro'],
          correctIndex: 1,
          explanation: 'Pioneer = Pioneiro.',
        ),
        Question(
          prompt:
              'Complete: "Many people came to California to find a ___."',
          options: ['fortune', 'forest', 'forecast', 'forge'],
          correctIndex: 0,
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
          prompt:
              'The "Civil" War divides the nation. Cognate in Portuguese:',
          options: ['Civico', 'Civil', 'Climatico', 'Critico'],
          correctIndex: 1,
          explanation: '"Civil" e identico nas duas linguas.',
        ),
        Question(
          prompt: 'A brutal "conflict" between North and South. Cognate:',
          options: ['Conflito', 'Convite', 'Contraste', 'Comando'],
          correctIndex: 0,
          explanation: 'Conflict -> Conflito.',
        ),
        Question(
          prompt: 'Lincoln signs the Emancipation ___.',
          options: ['Promotion', 'Proclamation', 'Production', 'Provision'],
          correctIndex: 1,
          explanation:
              'Proclamation = Proclamacao. Emancipation = Emancipacao. Cognatos.',
        ),
        Question(
          prompt: 'The "Union" wins the war. Cognate:',
          options: ['Unidade', 'Uniao', 'Universo', 'Urbano'],
          correctIndex: 1,
          explanation: 'Union = Uniao. Sufixo -ion / -ao.',
        ),
        Question(
          prompt: 'The North celebrates "victory". Cognate:',
          options: ['Visita', 'Vitoria', 'Viagem', 'Virtude'],
          correctIndex: 1,
          explanation: 'Victory = Vitoria.',
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
          prompt: 'The age of "industry". Cognate in Portuguese:',
          options: ['Indireto', 'Industria', 'Indicio', 'Infancia'],
          correctIndex: 1,
          explanation: 'Industry -> Industria. Sufixo -y / -ia.',
        ),
        Question(
          prompt: '"Electric" lamps light Broadway. Cognate:',
          options: ['Eletrico', 'Eletronico', 'Elegante', 'Elementar'],
          correctIndex: 0,
          explanation: 'Electric -> Eletrico.',
        ),
        Question(
          prompt: 'Engineers build new "machines". Cognate:',
          options: ['Marcas', 'Maquinas', 'Madeiras', 'Massas'],
          correctIndex: 1,
          explanation: 'Machine = Maquina.',
        ),
        Question(
          prompt: 'Complete: "The Industrial ___ changed the country."',
          options: ['Revolution', 'Resolution', 'Reservation', 'Repetition'],
          correctIndex: 0,
          explanation:
              'Revolution = Revolucao. -tion / -cao mais uma vez.',
        ),
        Question(
          prompt: 'A brand new "invention" appears every day. Cognate:',
          options: ['Invasao', 'Invencao', 'Invenivel', 'Iniciativa'],
          correctIndex: 1,
          explanation: 'Invention = Invencao.',
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
          prompt: '"Mission" Apollo 11 launches. Cognate:',
          options: ['Marca', 'Missao', 'Memoria', 'Mensagem'],
          correctIndex: 1,
          explanation: 'Mission -> Missao.',
        ),
        Question(
          prompt: 'The "astronaut" prepares the capsule. Cognate:',
          options: ['Astronomo', 'Astronauta', 'Aviador', 'Arquiteto'],
          correctIndex: 1,
          explanation: '"Astronaut" e cognato direto de Astronauta.',
        ),
        Question(
          prompt: 'Houston monitors the "orbit". Cognate:',
          options: ['Origem', 'Orbita', 'Ordem', 'Oceano'],
          correctIndex: 1,
          explanation: 'Orbit -> Orbita.',
        ),
        Question(
          prompt: 'Complete: "The lunar ___ touches the Moon."',
          options: ['module', 'mountain', 'minute', 'monitor'],
          correctIndex: 0,
          explanation: 'Module = Modulo. Lunar = Lunar. Dois cognatos.',
        ),
        Question(
          prompt: '"Capsule", "transmission", "control". All cognates of...',
          options: [
            'Capsula, Transmissao, Controle',
            'Caixa, Transporte, Conta',
            'Casa, Trajeto, Costume',
            'Cabo, Trabalho, Conteudo',
          ],
          correctIndex: 0,
          explanation:
              'Capsule/Capsula, Transmission/Transmissao, Control/Controle.',
        ),
      ],
    ),
  ];
}
