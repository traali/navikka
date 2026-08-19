import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/services/marine_technical_copilot_service.dart';
import 'package:sakkoja/features/vessel/presentation/controllers/vessel_controller.dart';

class MarineTechnicalCopilotScreen extends ConsumerStatefulWidget {
  const MarineTechnicalCopilotScreen({super.key});

  @override
  ConsumerState<MarineTechnicalCopilotScreen> createState() =>
      _MarineTechnicalCopilotScreenState();
}

class _MarineTechnicalCopilotScreenState
    extends ConsumerState<MarineTechnicalCopilotScreen> {
  final TextEditingController _queryController = TextEditingController();
  final TextEditingController _manualNoteController = TextEditingController();
  final TextEditingController _manualTitleController = TextEditingController();

  String? _currentDiagnosis;
  final List<CustomMarineManualNote> _customManuals = [];

  final List<String> _quickSymptomChips = [
    'Ylikuumeneminen',
    'Sammuminen tyhjäkäynnillä',
    'Merkkisuihku puuttuu',
    'Öljynpainehälytys',
    'Valkoinen savu',
    'Siipipyörän vaihto',
  ];

  @override
  void dispose() {
    _queryController.dispose();
    _manualNoteController.dispose();
    _manualTitleController.dispose();
    super.dispose();
  }

  void _runDiagnosis(String query, String? brand, String? fuelType) {
    setState(() {
      _queryController.text = query;
      _currentDiagnosis = MarineTechnicalCopilotService.diagnoseSymptom(
        symptomQuery: query,
        engineBrand: brand,
        fuelType: fuelType,
      );
    });
  }

  void _addCustomManual() {
    final title = _manualTitleController.text.trim();
    final content = _manualNoteController.text.trim();
    if (title.isEmpty || content.isEmpty) return;

    setState(() {
      _customManuals.add(
        CustomMarineManualNote(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          content: content,
          updatedAt: DateTime.now(),
        ),
      );
      _manualTitleController.clear();
      _manualNoteController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Manuaalimuistiinpano tallennettu offline-tilaan'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final vesselState = ref.watch(vesselSettingsControllerProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        title: Text(
          'Tekninen Kippari & Moottoriopas',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
      ),
      body: vesselState.when(
        data: (vessel) {
          final brand = vessel?.engineManufacturer;
          final model = vessel?.engineModel;
          final fuel = vessel?.fuelType ?? 'Bensiini';
          final spec = MarineTechnicalCopilotService.getSpecForBrand(brand);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Engine Header Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: colors.glassBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: colors.primaryAction.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.precision_manufacturing,
                              color: colors.primaryAction,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  brand != null && brand.isNotEmpty
                                      ? '$brand ${model ?? ''}'.trim()
                                      : 'Yleinen merimoottori',
                                  style: AppTextStyles.h4.copyWith(
                                    color: colors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'Polttoaine: $fuel • ${vessel?.name ?? "Vene"}',
                                  style: AppTextStyles.caption.copyWith(
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: colors.primaryAction.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Offline RAG',
                              style: AppTextStyles.nvXs.copyWith(
                                color: colors.primaryAction,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (spec != null) ...[
                        const SizedBox(height: 12),
                        Divider(color: colors.glassBorder),
                        const SizedBox(height: 8),
                        Text(
                          'TEKNISET SUOSITUKSET',
                          style: AppTextStyles.nvXs.copyWith(
                            color: colors.primaryAction,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '• Öljy: ${spec.oilType}',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '• Jäähdytys: ${spec.coolantType}',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '• Impelleri: ${spec.impellerPartHint}',
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 2. Interactive Diagnostic Query Box
                Text(
                  'Vianmääritys & Oirediagnoosi',
                  style: AppTextStyles.h4.copyWith(color: colors.primaryAction),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _queryController,
                        style: TextStyle(color: colors.textPrimary),
                        decoration: InputDecoration(
                          hintText: 'Kuvaa oire (esim. kone käy kuumana)',
                          hintStyle: TextStyle(
                            color: colors.textSecondary.withValues(alpha: 0.5),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colors.glassBorder),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: colors.primaryAction),
                          ),
                        ),
                        onSubmitted: (q) => _runDiagnosis(q, brand, fuel),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: colors.primaryAction,
                        foregroundColor: colors.canvas,
                      ),
                      icon: const Icon(Icons.send),
                      onPressed: () =>
                          _runDiagnosis(_queryController.text, brand, fuel),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Quick symptom chips
                Wrap(
                  spacing: 6,
                  children: _quickSymptomChips.map((s) {
                    return ActionChip(
                      label: Text(s),
                      backgroundColor: colors.surfaceHighlight,
                      labelStyle: TextStyle(
                        color: colors.textPrimary,
                        fontSize: 11,
                      ),
                      onPressed: () => _runDiagnosis(s, brand, fuel),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Diagnosis Result Box
                if (_currentDiagnosis != null) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: colors.primaryAction.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      _currentDiagnosis!,
                      style: AppTextStyles.nvXs.copyWith(
                        color: colors.textPrimary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // 3. Engine Common Failure Modes (Preloaded)
                if (spec != null && spec.commonIssues.isNotEmpty) ...[
                  Text(
                    '${spec.brand} - Yleisimmät viat ja korjaukset',
                    style: AppTextStyles.h4.copyWith(
                      color: colors.primaryAction,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...spec.commonIssues.map((issue) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: colors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: issue.severity == 'Kriittinen'
                                      ? colors.danger.withValues(alpha: 0.2)
                                      : colors.warning.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  issue.severity,
                                  style: TextStyle(
                                    color: issue.severity == 'Kriittinen'
                                        ? colors.danger
                                        : colors.warning,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  issue.symptom,
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Syy: ${issue.likelyCause}',
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ...issue.stepByStepFix.map(
                            (step) => Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                step,
                                style: TextStyle(
                                  color: colors.textPrimary,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],

                // 4. Offline Manual Loader & Custom Notes
                Divider(color: colors.glassBorder),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.menu_book,
                      color: colors.primaryAction,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Omat Manuaalit & Huoltomuistiinpanot (Offline)',
                      style: AppTextStyles.h4.copyWith(
                        color: colors.primaryAction,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _manualTitleController,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText:
                        'Otsikko (esim. Öljynvaihto 2026 tai Kytkentäkaavio)',
                    labelStyle: TextStyle(color: colors.textSecondary),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colors.glassBorder),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _manualNoteController,
                  maxLines: 3,
                  style: TextStyle(color: colors.textPrimary),
                  decoration: InputDecoration(
                    labelText: 'Ohjeet / Huoltotiedot / Osanumerot',
                    labelStyle: TextStyle(color: colors.textSecondary),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: colors.glassBorder),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.primaryAction,
                    foregroundColor: colors.canvas,
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text('TALLENNA MANUAALI OFFLINE-TILAAN'),
                  onPressed: _addCustomManual,
                ),
                const SizedBox(height: 12),
                if (_customManuals.isNotEmpty) ...[
                  ..._customManuals.map((m) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colors.glassBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.title,
                            style: TextStyle(
                              color: colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            m.content,
                            style: TextStyle(
                              color: colors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Virhe: $err')),
      ),
    );
  }
}
