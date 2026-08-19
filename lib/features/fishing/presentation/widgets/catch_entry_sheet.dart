import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/fishing/di/fishing_di.dart';
import 'package:sakkoja/features/fishing/domain/entities/catch_size.dart';
import 'package:sakkoja/features/fishing/domain/entities/fish_species.dart';
import 'package:sakkoja/features/fishing/presentation/providers/catch_controller_provider.dart';
import 'package:sakkoja/features/fishing/presentation/providers/catch_size_validator_provider.dart';
import 'package:sakkoja/features/weather/presentation/controllers/point_weather_controller.dart';

/// Premium glassmorphic bottom sheet for recording a fish catch.
class CatchEntrySheet extends ConsumerStatefulWidget {
  const CatchEntrySheet({required this.location, super.key});

  /// Current GPS location, auto-captured when sheet opens.
  final LatLng location;

  @override
  ConsumerState<CatchEntrySheet> createState() => _CatchEntrySheetState();
}

class _CatchEntrySheetState extends ConsumerState<CatchEntrySheet> {
  FishSpecies _selectedSpecies = FishSpecies.ahven;
  FishingMethod? _selectedMethod;
  final _weightController = TextEditingController();
  final _lengthController = TextEditingController();
  final _lureController = TextEditingController();
  final _notesController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _weightController.dispose();
    _lengthController.dispose();
    _lureController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveCatch() async {
    if (_isSaving) return;
    setState(() => _isSaving = true);

    final lengthCm = _lengthController.text.isNotEmpty
        ? double.tryParse(_lengthController.text)
        : null;

    final repository = ref.read(fishingRepositoryProvider);
    final regulationsResult = await repository.getCatchSizes(
      lat: widget.location.latitude,
      lon: widget.location.longitude,
    );

    final regulations = regulationsResult.fold(
      (failure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚠️ Säädöstieto ei saatavilla',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Ei voitu tarkistaa kalastusrajoituksia. Tallennetaan ilman tarkistusta.',
                  ),
                ],
              ),
              backgroundColor: Colors.orange.shade800,
            ),
          );
        }
        return <CatchSize>[];
      },
      (r) => r,
    );

    final validator = ref.read(catchSizeValidatorProvider);
    final validation = validator.validate(
      species: _selectedSpecies,
      lengthCm: lengthCm,
      regulations: regulations,
    );

    if (!validation.isValid) {
      setState(() => _isSaving = false);
      if (mounted) {
        final message = validation.messages.join('\n');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '⚠️ Kalastusrajoitus',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(message),
              ],
            ),
            backgroundColor: Colors.orange.shade800,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      return;
    }

    try {
      final weatherState = ref.read(pointWeatherControllerProvider);
      final weather = weatherState.weather;

      await ref
          .read(catchControllerProvider.notifier)
          .recordCatch(
            species: _selectedSpecies,
            location: widget.location,
            weightGrams: _weightController.text.isNotEmpty
                ? int.tryParse(_weightController.text)
                : null,
            lengthCm: lengthCm,
            lure: _lureController.text.isNotEmpty ? _lureController.text : null,
            method: _selectedMethod,
            notes: _notesController.text.isNotEmpty
                ? _notesController.text
                : null,
            weatherTemp: weather?.temperature,
            weatherWindSpeed: weather?.windSpeed,
            weatherWindDir: weather?.windDirection,
            weatherDesc: weather?.weatherDescription,
            weatherIcon: weather?.weatherIcon,
          );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Saalis tallennettu! ${_selectedSpecies.emoji} ${_selectedSpecies.displayName}',
            ),
            backgroundColor: Colors.green.shade700,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Virhe tallennuksessa: $e'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0F172A).withValues(alpha: 0.95),
                const Color(0xFF1E293B).withValues(alpha: 0.9),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: AppPalette.textPrimary.withValues(alpha: 0.15),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                _buildHandleBar(),

                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Text('🎣', style: TextStyle(fontSize: 28)),
                      const SizedBox(width: 12),
                      const Text(
                        'Uusi saalis!',
                        style: TextStyle(
                          color: AppPalette.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          Icons.close,
                          color: AppPalette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Location info
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppPalette.primaryAction.withValues(alpha: 0.8),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.location.latitude.toStringAsFixed(4)}, ${widget.location.longitude.toStringAsFixed(4)}',
                        style: TextStyle(
                          color: AppPalette.textPrimary.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Species selector
                _buildSectionTitle('Kalalaji *'),
                _buildSpeciesSelector(),

                const SizedBox(height: 16),

                // Method selector
                _buildSectionTitle('Kalastustapa'),
                _buildMethodSelector(),

                const SizedBox(height: 16),

                // Weight and Length
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _weightController,
                          label: 'Paino (g)',
                          icon: Icons.scale,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          controller: _lengthController,
                          label: 'Pituus (cm)',
                          icon: Icons.straighten,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Lure
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildTextField(
                    controller: _lureController,
                    label: 'Viehe / Syötti',
                    icon: Icons.phishing,
                  ),
                ),

                const SizedBox(height: 12),

                // Notes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildTextField(
                    controller: _notesController,
                    label: 'Muistiinpanot',
                    icon: Icons.notes,
                    maxLines: 2,
                  ),
                ),

                const SizedBox(height: 24),

                // Save button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveCatch,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPalette.primaryAction,
                        foregroundColor: AppPalette.textPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppPalette.textPrimary,
                              ),
                            )
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle_outline),
                                SizedBox(width: 8),
                                Text(
                                  'Tallenna saalis',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: AppPalette.textPrimary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: AppPalette.textPrimary.withValues(alpha: 0.7),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSpeciesSelector() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: FishSpecies.values.length,
        itemBuilder: (context, index) {
          final species = FishSpecies.values[index];
          final isSelected = species == _selectedSpecies;

          return GestureDetector(
            onTap: () => setState(() => _selectedSpecies = species),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppPalette.primaryAction.withValues(alpha: 0.2)
                    : AppPalette.textPrimary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppPalette.primaryAction
                      : AppPalette.textPrimary.withValues(alpha: 0.1),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(species.emoji, style: const TextStyle(fontSize: 28)),
                  const SizedBox(height: 4),
                  Text(
                    species.displayName,
                    style: TextStyle(
                      color: isSelected
                          ? AppPalette.primaryAction
                          : AppPalette.textPrimary.withValues(alpha: 0.7),
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMethodSelector() {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: FishingMethod.values.length + 1, // +1 for "none" option
        itemBuilder: (context, index) {
          if (index == 0) {
            // "None" option
            final isSelected = _selectedMethod == null;
            return GestureDetector(
              onTap: () => setState(() => _selectedMethod = null),
              child: _buildMethodChip('-', isSelected),
            );
          }

          final method = FishingMethod.values[index - 1];
          final isSelected = method == _selectedMethod;

          return GestureDetector(
            onTap: () => setState(() => _selectedMethod = method),
            child: _buildMethodChip(method.displayName, isSelected),
          );
        },
      ),
    );
  }

  Widget _buildMethodChip(String label, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppPalette.primaryAction.withValues(alpha: 0.2)
            : AppPalette.textPrimary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? AppPalette.primaryAction
              : AppPalette.textPrimary.withValues(alpha: 0.1),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? AppPalette.primaryAction
              : AppPalette.textPrimary.withValues(alpha: 0.7),
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: AppPalette.textSecondary.withValues(alpha: 0.7)),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppPalette.textPrimary.withValues(alpha: 0.5),
        ),
        prefixIcon: Icon(
          icon,
          color: AppPalette.textSecondary.withValues(alpha: 0.6),
          size: 20,
        ),
        filled: true,
        fillColor: AppPalette.textPrimary.withValues(alpha: 0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppPalette.textPrimary.withValues(alpha: 0.1),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppPalette.textPrimary.withValues(alpha: 0.1),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppPalette.primaryAction),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}
