class EngineQuickSpec {
  const EngineQuickSpec({
    required this.brand,
    required this.popularModels,
    required this.oilType,
    required this.coolantType,
    required this.impellerPartHint,
    required this.commonIssues,
  });

  final String brand;
  final List<String> popularModels;
  final String oilType;
  final String coolantType;
  final String impellerPartHint;
  final List<EngineIssueFix> commonIssues;
}

class EngineIssueFix {
  const EngineIssueFix({
    required this.symptom,
    required this.likelyCause,
    required this.stepByStepFix,
    required this.severity,
  });

  final String symptom;
  final String likelyCause;
  final List<String> stepByStepFix;
  final String severity; // 'Kriittinen', 'Tärkeä', 'Huomio'
}

class CustomMarineManualNote {
  const CustomMarineManualNote({
    required this.id,
    required this.title,
    required this.content,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String content;
  final DateTime updatedAt;
}

class MarineTechnicalCopilotService {
  static final List<EngineQuickSpec> engineSpecs = [
    const EngineQuickSpec(
      brand: 'Volvo Penta',
      popularModels: ['D4-300', 'D6-400', 'TAMD41', 'D1-30', 'D2-55'],
      oilType: 'VDS-4.5 15W-40 tai SAE 15W-40 Diesel',
      coolantType: 'Volvo Penta Coolant VCS (Keltainen)',
      impellerPartHint: 'Volvo Penta #21951348 / #3593659',
      commonIssues: [
        EngineIssueFix(
          symptom: 'Moottorin lämpötila nousee liian korkeaksi matkanopeudella',
          likelyCause:
              'Merivesisuodattimen tukos tai siipipyörän kuminapojen murtuma.',
          stepByStepFix: [
            '1. Sammuta moottori ja sulje pohjaventtiili (seacock).',
            '2. Avaa merivesisuodattimen kansi ja poista heinät/kalliotuhka.',
            '3. Tarkista pumpun siipipyörä (impelleri): vaihda jos siivekkeet ovat poikki.',
            '4. Avaa pohjaventtiili ja varmista vesikierto pakoputkesta ennen ajoa.',
          ],
          severity: 'Kriittinen',
        ),
        EngineIssueFix(
          symptom: 'Moottori käy epätasaisesti tai sammuu tyhjäkäynnillä',
          likelyCause:
              'Vettä polttoaineen esisuodattimessa tai ilmaa polttoainelinjassa.',
          stepByStepFix: [
            '1. Tarkista vedenerottimen tarkastuslasi ja laske vesi pois pohjaruuvista.',
            '2. Vaihda esisuodattimen panos (esim. Racor 500FG).',
            '3. Ilmaa polttoainejärjestelmä käsipumpulla kunnes kuplia ei näy.',
          ],
          severity: 'Tärkeä',
        ),
        EngineIssueFix(
          symptom: 'Ahtopaine puuttuu tai moottori savuttaa mustaa',
          likelyCause:
              'Ahtimen kompressorisiiven nokiintuminen tai hukkaportin jumiutuminen.',
          stepByStepFix: [
            '1. Tarkista ilmansuodattimen puhtaus.',
            '2. Tarkista ahtimen ilmaputkien klemmarit ahtovuotojen varalta.',
            '3. Varmista ettei potkuri ole kietoutunut verkkoon/köyteen.',
          ],
          severity: 'Huomio',
        ),
      ],
    ),
    const EngineQuickSpec(
      brand: 'Yamaha',
      popularModels: ['F70', 'F115', 'F150', 'F200', 'F250', 'F300'],
      oilType: 'Yamalube 4M 10W-30 / 10W-40 FC-W',
      coolantType: 'Merivesijäähdytys (avoin kierto)',
      impellerPartHint: 'Yamaha 6E5-44352-01-00 / 692-44352-00',
      commonIssues: [
        EngineIssueFix(
          symptom: 'Jäähdytysveden merkkisuihku (telltale) heikko tai puuttuu',
          likelyCause:
              'Merkkisuihkun suuttimen suolatukos tai vesipumpun siipipyörän kuluma.',
          stepByStepFix: [
            '1. Puhdista suihkusuutin ohuella nailonlangalla tai siimalla moottorin käydessä tyhjäkäynnillä.',
            '2. Jos suihku ei palaa ja summeri hälyttää, sammuta moottori välittömästi.',
            '3. Vaihda perän vesipumpun siipipyörä ja tiivistepesä.',
          ],
          severity: 'Kriittinen',
        ),
        EngineIssueFix(
          symptom: 'Kone pätkii korkeilla kierroksilla (yli 4000 RPM)',
          likelyCause:
              'Höyrystinsäiliön (VST) korkeapainesuodatin tukossa tai huonoa bensiiniä.',
          stepByStepFix: [
            '1. Tarkista veneen polttoainesuodatin / vedenerotin.',
            '2. Puhdista tai vaihda VST-säiliön imusihti.',
            '3. Käytä 98E5-bensiiniä tai pienkonebensiiniä etanolihaittojen estämiseksi.',
          ],
          severity: 'Tärkeä',
        ),
      ],
    ),
    const EngineQuickSpec(
      brand: 'Yanmar',
      popularModels: ['1GM10', '2YM15', '3YM30', '3JH40', '4JH4-TE'],
      oilType: 'API CI-4 / SAE 15W-40 Diesel Marine',
      coolantType: 'Yanmar Long Life Coolant (Punainen / Etyleeniglykoli)',
      impellerPartHint: 'Yanmar 128990-42200 / 129670-42531',
      commonIssues: [
        EngineIssueFix(
          symptom: 'Pakoputkesta tulee mustaa savua ja teho laskee',
          likelyCause:
              'Pakomutkan (mixing elbow) karstoittuminen tai lämmönvaihtimen kalkkiutuminen.',
          stepByStepFix: [
            '1. Tarkista pakokaasun sekoitusmutkan läpikulku karstasta.',
            '2. Puhdista lämmönvaihtimen pillistö suolahappo- tai sitruunahappoliuoksella.',
            '3. Varmista ettei peräsimen/vetolaitteen ympärillä ole likaa.',
          ],
          severity: 'Tärkeä',
        ),
      ],
    ),
    const EngineQuickSpec(
      brand: 'Mercury',
      popularModels: [
        'FourStroke 60',
        'FourStroke 115',
        'Verado 250',
        'Verado 300',
      ],
      oilType: 'Mercury 25W-40 Synthetic Blend NMMA FC-W',
      coolantType: 'Merivesijäähdytys',
      impellerPartHint: 'Mercury Quicksilver 47-89984T4 / 47-43026Q06',
      commonIssues: [
        EngineIssueFix(
          symptom: 'SmartCraft-hälytys: Vesi polttoaineessa (Water in Fuel)',
          likelyCause:
              'Kondenssivettä tankissa tai vuotava tankkauskorkin tiiviste.',
          stepByStepFix: [
            '1. Tyhjennä moottorikopan alla oleva punaisella renkaalla varustettu vedenerotinkuppi.',
            '2. Tarkista päävedenerotin veneen perätilassa.',
          ],
          severity: 'Tärkeä',
        ),
      ],
    ),
    const EngineQuickSpec(
      brand: 'Torqeedo',
      popularModels: ['Travel 1103 C', 'Cruise 3.0 / 6.0 / 12.0', 'Deep Blue'],
      oilType: 'Huoltovapaa sähkömoottori (vaihteistoöljy 75W-90)',
      coolantType: 'Ilmajäähdytys / Makeavesikierto (Cruise/Deep Blue)',
      impellerPartHint: 'Ei siipipyörää (Suoraveto tai vesikierto)',
      commonIssues: [
        EngineIssueFix(
          symptom: 'Kaasukahva näyttää virhekoodia E30 tai ei reagoi',
          likelyCause:
              'Magneettisen tappokytkimen kontakti irronnut tai kaapelin kosteus.',
          stepByStepFix: [
            '1. Aseta magneettinen hätäkatkaisin uudelleen tarkasti paikoilleen.',
            '2. Tarkista kaasukahvan ja akun välinen datakaapelin pikaliitin.',
            '3. Suorita kaasukahvan nollauskalibrointi ohjekirjan mukaisesti.',
          ],
          severity: 'Tärkeä',
        ),
      ],
    ),
  ];

  /// Resolves matching quick specs for a given engine manufacturer.
  static EngineQuickSpec? getSpecForBrand(String? brand) {
    if (brand == null || brand.trim().isEmpty) return null;
    final clean = brand.toLowerCase().trim();
    for (final spec in engineSpecs) {
      if (clean.contains(spec.brand.toLowerCase()) ||
          spec.brand.toLowerCase().contains(clean)) {
        return spec;
      }
    }
    return null;
  }

  /// Interactive diagnostic query solver in Finnish and English.
  static String diagnoseSymptom({
    required String symptomQuery,
    required String? engineBrand,
    required String? fuelType,
  }) {
    final spec = getSpecForBrand(engineBrand);
    final query = symptomQuery.toLowerCase();

    if (query.contains('lämpö') ||
        query.contains('ylikuum') ||
        query.contains('kuum') ||
        query.contains('heat') ||
        query.contains('temp')) {
      return '''
🔧 **Diagnoosi: Moottorin ylikuumeneminen** (${engineBrand ?? 'Yleismoottori'})
1. **Pohjaventtiili & Siivilä**: Tarkista pohjaventtiilin (seacock) asento ja poista meriruoho suodattimesta.
2. **Siipipyörä (Impelleri)**: ${spec != null ? 'Varaosa: ${spec.impellerPartHint}.' : 'Tarkista kuminapojen kunto.'}
3. **Termostaatti**: Jos vesivirta kulkee mutta kone kuumenee, termostaatti saattaa olla jumissa kiinniasennossa.
4. **Jäähdytysneste**: ${spec != null ? 'Suositus: ${spec.coolantType}' : 'Tarkista paisuntasäiliön taso.'}
''';
    }

    if (query.contains('sammuu') ||
        query.contains('bensa') ||
        query.contains('diesel') ||
        query.contains('polttoaine') ||
        query.contains('fuel') ||
        query.contains('start')) {
      return '''
🔧 **Diagnoosi: Polttoaine- tai käynnistysongelma** (${fuelType ?? 'Polttoainejärjestelmä'})
1. **Vedenerotin**: Tyhjennä vedenerottimen tarkastuslasi ja tarkista ettei polttoaineessa ole vettä tai diesellimaa.
2. **Ilmaus**: Dieselmoottoreissa suodattimen vaihdon jälkeen järjestelmä vaatii aina käsipumppuilmauksen.
3. **Tappokytkin & Virta**: Varmista että hätäkatkaisin (kill-switch) on pohjassa ja akkujännite vähintään 12.4 V.
''';
    }

    if (query.contains('öljy') || query.contains('oil')) {
      return '''
🔧 **Öljysuositus ja huolto-ohje** (${engineBrand ?? 'Moottori'})
- **Öljylaatu**: ${spec?.oilType ?? 'Valmistajan suosittelema 4-tahti marineöljy (NMMA FC-W / API CI-4)'}
- **Tarkistus**: Mittaa öljytikku aina koneen oltua sammuksissa vähintään 5 minuuttia vaakatasossa.
''';
    }

    return '''
🔧 **Kipparin Tekninen Huolto-opas** (${engineBrand ?? 'Merimoottori'})
Oire: "$symptomQuery"
- Tarkista moottoritilan tuuletus, hihnojen kireys, pilssiveden määrä ja polttoaineen saanti.
- Tarkista lisätiedot tallennetuista manuaaleista tai ota yhteys meripelastukseen/tekniseen päivystykseen tarvittaessa.
''';
  }
}
