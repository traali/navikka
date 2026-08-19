import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/domain/services/marine_technical_copilot_service.dart';
import 'package:sakkoja/features/vessel/data/tables.dart';
import 'package:sakkoja/features/vessel/presentation/controllers/vessel_controller.dart';

class VesselSettingsScreen extends ConsumerStatefulWidget {
  const VesselSettingsScreen({super.key});

  @override
  ConsumerState<VesselSettingsScreen> createState() =>
      _VesselSettingsScreenState();
}

class _VesselSettingsScreenState extends ConsumerState<VesselSettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _hinController;
  late TextEditingController _engineManufacturerController;
  late TextEditingController _engineModelController;

  VesselType _selectedType = VesselType.openBoat;
  String _selectedFuelType = 'Bensiini';
  double _maxWind = 10;
  double _maxWave = 1;
  double? _draft;
  double _cruisingSpeed = 15;

  bool _isInit = false;

  final List<String> _commonEngineBrands = [
    'Volvo Penta',
    'Yamaha',
    'Yanmar',
    'Mercury',
    'Torqeedo',
    'Honda',
    'Suzuki',
    'Tohatsu',
  ];

  final List<String> _fuelTypes = [
    'Bensiini',
    'Diesel',
    'Sähkö',
    'Muu / Purje',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _hinController = TextEditingController();
    _engineManufacturerController = TextEditingController();
    _engineModelController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _hinController.dispose();
    _engineManufacturerController.dispose();
    _engineModelController.dispose();
    super.dispose();
  }

  void _updateDefaults(VesselType type) {
    setState(() {
      _selectedType = type;
      switch (type) {
        case VesselType.openBoat:
          _maxWind = 10.0;
          _maxWave = 1.0;
        case VesselType.cabinBoat:
          _maxWind = 14.0;
          _maxWave = 2.0;
        case VesselType.sailboat:
          _maxWind = 16.0;
          _maxWave = 3.0;
        case VesselType.ship:
          _maxWind = 20.0;
          _maxWave = 5.0;
      }
    });
  }

  String _typeLabel(VesselType type) {
    switch (type) {
      case VesselType.openBoat:
        return 'Avovene';
      case VesselType.cabinBoat:
        return 'Hyttivene / Moottorivene';
      case VesselType.sailboat:
        return 'Purjevene';
      case VesselType.ship:
        return 'Laiva / Ammattialus';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final vesselState = ref.watch(vesselSettingsControllerProvider);

    ref.listen(vesselSettingsControllerProvider, (prev, next) {
      if (!mounted) return;
      if (!_isInit && next.hasValue && next.value != null) {
        final v = next.value!;
        setState(() {
          _nameController.text = v.name;
          _selectedType = v.type;
          _maxWind = v.maxWindLimit;
          _maxWave = v.maxWaveLimit;
          _draft = v.draftDepth;
          _cruisingSpeed = v.cruisingSpeedKmh;
          _hinController.text = v.hinCode ?? '';
          _engineManufacturerController.text = v.engineManufacturer ?? '';
          _engineModelController.text = v.engineModel ?? '';
          if (v.fuelType != null && _fuelTypes.contains(v.fuelType)) {
            _selectedFuelType = v.fuelType!;
          }
          _isInit = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        title: Text(
          'Veneen tiedot & Moottoriprofiili',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
      ),
      body: vesselState.when(
        data: (currentProfile) {
          if (!_isInit && currentProfile != null) {
            _isInit = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _nameController.text = currentProfile.name;
                  _selectedType = currentProfile.type;
                  _maxWind = currentProfile.maxWindLimit;
                  _maxWave = currentProfile.maxWaveLimit;
                  _draft = currentProfile.draftDepth;
                  _cruisingSpeed = currentProfile.cruisingSpeedKmh;
                  _hinController.text = currentProfile.hinCode ?? '';
                  _engineManufacturerController.text =
                      currentProfile.engineManufacturer ?? '';
                  _engineModelController.text =
                      currentProfile.engineModel ?? '';
                  if (currentProfile.fuelType != null &&
                      _fuelTypes.contains(currentProfile.fuelType)) {
                    _selectedFuelType = currentProfile.fuelType!;
                  }
                });
              }
            });
          }

          final engineSpec = MarineTechnicalCopilotService.getSpecForBrand(
            _engineManufacturerController.text,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Boat Name
                  TextFormField(
                    controller: _nameController,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Veneen nimi (esim. My Buster)',
                      labelStyle: TextStyle(color: colors.textSecondary),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.glassBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.primaryAction),
                      ),
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty ? 'Anna veneen nimi' : null,
                  ),
                  const SizedBox(height: 16),

                  // 2. Type Selector
                  DropdownButtonFormField<VesselType>(
                    key: ValueKey(_selectedType),
                    initialValue: _selectedType,
                    dropdownColor: colors.surface,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Alustyyppi',
                      labelStyle: TextStyle(color: colors.textSecondary),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.glassBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.primaryAction),
                      ),
                    ),
                    items: VesselType.values.map((t) {
                      return DropdownMenuItem(
                        value: t,
                        child: Text(
                          _typeLabel(t),
                          style: TextStyle(color: colors.textPrimary),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) _updateDefaults(val);
                    },
                  ),
                  const SizedBox(height: 16),

                  // 3. HIN / CIN / VIN
                  TextFormField(
                    controller: _hinController,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Runkonumero / HIN / WIN (valinnainen)',
                      labelStyle: TextStyle(color: colors.textSecondary),
                      hintText: 'esim. FI-BMS12345D819',
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
                  ),
                  const SizedBox(height: 20),

                  // Motor & Engine Section
                  Divider(color: colors.glassBorder),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.build_circle,
                        color: colors.primaryAction,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Moottori & Tekniset tiedot',
                        style: AppTextStyles.h4.copyWith(
                          color: colors.primaryAction,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Engine Manufacturer & Model
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _engineManufacturerController,
                          style: TextStyle(color: colors.textPrimary),
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            labelText: 'Moottorimerkki',
                            hintText: 'esim. Yamaha, Volvo Penta',
                            labelStyle: TextStyle(color: colors.textSecondary),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colors.glassBorder),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colors.primaryAction,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _engineModelController,
                          style: TextStyle(color: colors.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Malli',
                            hintText: 'esim. F150, D4-300',
                            labelStyle: TextStyle(color: colors.textSecondary),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: colors.glassBorder),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: colors.primaryAction,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Quick brand chips
                  Wrap(
                    spacing: 6,
                    children: _commonEngineBrands.map((b) {
                      final isSel =
                          _engineManufacturerController.text.toLowerCase() ==
                          b.toLowerCase();
                      return ChoiceChip(
                        label: Text(b),
                        selected: isSel,
                        selectedColor: colors.primaryAction.withValues(
                          alpha: 0.25,
                        ),
                        backgroundColor: colors.surfaceHighlight,
                        labelStyle: TextStyle(
                          color: isSel
                              ? colors.primaryAction
                              : colors.textSecondary,
                          fontSize: 11,
                        ),
                        onSelected: (selected) {
                          if (selected) {
                            setState(() {
                              _engineManufacturerController.text = b;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),

                  // Fuel Type
                  DropdownButtonFormField<String>(
                    key: ValueKey(_selectedFuelType),
                    initialValue: _selectedFuelType,
                    dropdownColor: colors.surface,
                    style: TextStyle(color: colors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Polttoainetyyppi',
                      labelStyle: TextStyle(color: colors.textSecondary),
                      border: const OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.glassBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: colors.primaryAction),
                      ),
                    ),
                    items: _fuelTypes.map((f) {
                      return DropdownMenuItem(
                        value: f,
                        child: Text(
                          f,
                          style: TextStyle(color: colors.textPrimary),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedFuelType = val);
                    },
                  ),
                  const SizedBox(height: 12),

                  // Engine Specs Autoloader Banner
                  if (engineSpec != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colors.primaryAction.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colors.primaryAction.withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.auto_awesome,
                                color: colors.primaryAction,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'AI-MOOTTORIOPAS: ${engineSpec.brand.toUpperCase()}',
                                style: AppTextStyles.nvXs.copyWith(
                                  color: colors.primaryAction,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '• Öljysuositus: ${engineSpec.oilType}\n'
                            '• Jäähdytysneste: ${engineSpec.coolantType}\n'
                            '• Siipipyörä / Impelleri: ${engineSpec.impellerPartHint}',
                            style: AppTextStyles.nvXs.copyWith(
                              color: colors.textPrimary,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${engineSpec.commonIssues.length} yleisintä vikaa & korjausohjetta esiladattu offline-oppaaseen.',
                            style: AppTextStyles.nvXs.copyWith(
                              color: colors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Virtual Skipper Limits
                  Divider(color: colors.glassBorder),
                  const SizedBox(height: 8),
                  Text(
                    'Turvallisuusrajat (Virtuaalikapteeni)',
                    style: AppTextStyles.h4.copyWith(
                      color: colors.primaryAction,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Max Wind
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suurin sallittu tuuli',
                        style: TextStyle(color: colors.textPrimary),
                      ),
                      Text(
                        '${_maxWind.toStringAsFixed(1)} m/s',
                        style: AppTextStyles.mono.copyWith(
                          color: colors.primaryAction,
                        ),
                      ),
                    ],
                  ),
                  Slider.adaptive(
                    value: _maxWind,
                    min: 5,
                    max: 30,
                    divisions: 50,
                    activeColor: colors.primaryAction,
                    inactiveColor: colors.surfaceHighlight,
                    label: '${_maxWind.round()} m/s',
                    onChanged: (val) => setState(() => _maxWind = val),
                  ),

                  // Max Wave
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suurin sallittu merkitsevä aallonkorkeus',
                        style: TextStyle(color: colors.textPrimary),
                      ),
                      Text(
                        '${_maxWave.toStringAsFixed(1)} m',
                        style: AppTextStyles.mono.copyWith(
                          color: colors.primaryAction,
                        ),
                      ),
                    ],
                  ),
                  Slider.adaptive(
                    value: _maxWave,
                    min: 0.5,
                    max: 10,
                    divisions: 19,
                    activeColor: colors.primaryAction,
                    inactiveColor: colors.surfaceHighlight,
                    label: '${_maxWave.toStringAsFixed(1)} m',
                    onChanged: (val) => setState(() => _maxWave = val),
                  ),
                  const SizedBox(height: 10),

                  // Cruising Speed
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Matkanopeus',
                        style: TextStyle(color: colors.textPrimary),
                      ),
                      Text(
                        '${_cruisingSpeed.toStringAsFixed(1)} km/h',
                        style: AppTextStyles.mono.copyWith(
                          color: colors.primaryAction,
                        ),
                      ),
                    ],
                  ),
                  Slider.adaptive(
                    value: _cruisingSpeed,
                    min: 5,
                    max: 50,
                    divisions: 45,
                    activeColor: colors.primaryAction,
                    inactiveColor: colors.surfaceHighlight,
                    label: '${_cruisingSpeed.round()} km/h',
                    onChanged: (val) => setState(() => _cruisingSpeed = val),
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.primaryAction,
                        foregroundColor: colors.canvas,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(vesselSettingsControllerProvider.notifier)
                              .saveProfile(
                                name: _nameController.text,
                                type: _selectedType,
                                maxWind: _maxWind,
                                maxWave: _maxWave,
                                draft: _draft,
                                cruisingSpeed: _cruisingSpeed,
                                hinCode: _hinController.text.trim().isNotEmpty
                                    ? _hinController.text.trim()
                                    : null,
                                engineManufacturer:
                                    _engineManufacturerController.text
                                        .trim()
                                        .isNotEmpty
                                    ? _engineManufacturerController.text.trim()
                                    : null,
                                engineModel:
                                    _engineModelController.text
                                        .trim()
                                        .isNotEmpty
                                    ? _engineModelController.text.trim()
                                    : null,
                                fuelType: _selectedFuelType,
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Veneen ja moottorin profiili tallennettu',
                              ),
                            ),
                          );
                          context.pop();
                        }
                      },
                      child: Text(
                        'TALLENNA PROFIILI',
                        style: TextStyle(
                          color: colors.canvas,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Virhe: $err')),
      ),
    );
  }
}
