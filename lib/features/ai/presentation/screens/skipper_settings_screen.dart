import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sakkoja/core/theme/app_text_styles.dart';
import 'package:sakkoja/core/theme/theme_provider.dart';
import 'package:sakkoja/features/ai/data/services/model_download_service.dart';
import 'package:sakkoja/features/ai/presentation/providers/ai_providers.dart';
import 'package:sakkoja/features/ai/presentation/widgets/ai_safety_dialog.dart';
import 'package:sakkoja/features/ai/presentation/widgets/section_header.dart';
import 'package:sakkoja/features/ai/presentation/widgets/settings_action_buttons.dart';
import 'package:sakkoja/features/ai/presentation/widgets/settings_switch_tile.dart';
import 'package:sakkoja/features/ai/presentation/widgets/settings_threshold_slider.dart';
import 'package:sakkoja/features/fishing/presentation/providers/fishing_mode_provider.dart';

class SkipperSettingsScreen extends ConsumerStatefulWidget {
  const SkipperSettingsScreen({super.key});

  @override
  ConsumerState<SkipperSettingsScreen> createState() =>
      _SkipperSettingsScreenState();
}

class _SkipperSettingsScreenState extends ConsumerState<SkipperSettingsScreen> {
  bool _isAIEnabled = true;
  double _windYellow = 10;
  double _windOrange = 12;
  double _windRed = 14;
  double _waveYellow = 1;
  double _waveOrange = 1.5;
  double _waveRed = 2.5;
  double _pressureDrop = 2;
  int _forecastWindow = 3;
  bool _hasAcknowledgedSafety = false;
  String? _aiApiKey;
  String _aiModelId = 'meta-llama/llama-3.3-70b-instruct:free';

  bool _isInit = false;
  TextEditingController? _apiKeyController;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final settingsState = ref.watch(skipperSettingsControllerProvider);

    ref.listen(skipperSettingsControllerProvider, (prev, next) {
      if (!_isInit && next.hasValue) {
        final s = next.value!;
        setState(() {
          _isAIEnabled = s.isAIEnabled;
          _windYellow = s.thresholds.windYellowMs;
          _windOrange = s.thresholds.windOrangeMs;
          _windRed = s.thresholds.windRedMs;
          _waveYellow = s.thresholds.waveYellowM;
          _waveOrange = s.thresholds.waveOrangeM;
          _waveRed = s.thresholds.waveRedM;
          _pressureDrop = s.thresholds.pressureDropThresholdHpa;
          _forecastWindow = s.forecastWindowHours;
          _hasAcknowledgedSafety = s.hasAcknowledgedAISafety;
          _aiApiKey = s.aiApiKey;
          _aiModelId = s.aiModelId;
          _isInit = true;
        });
      }
    });

    return Scaffold(
      backgroundColor: colors.canvas,
      appBar: AppBar(
        title: Text(
          'Kipparin asetukset',
          style: TextStyle(
            color: colors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: colors.surface,
        elevation: 0,
      ),
      body: settingsState.when(
        data: (settings) {
          if (!_isInit) {
            _isAIEnabled = settings.isAIEnabled;
            _windYellow = settings.thresholds.windYellowMs;
            _windOrange = settings.thresholds.windOrangeMs;
            _windRed = settings.thresholds.windRedMs;
            _waveYellow = settings.thresholds.waveYellowM;
            _waveOrange = settings.thresholds.waveOrangeM;
            _waveRed = settings.thresholds.waveRedM;
            _pressureDrop = settings.thresholds.pressureDropThresholdHpa;
            _forecastWindow = settings.forecastWindowHours;
            _hasAcknowledgedSafety = settings.hasAcknowledgedAISafety;
            _aiApiKey = settings.aiApiKey;
            _aiModelId = settings.aiModelId;
            _isInit = true;
          }

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SectionHeader('Tekoäly ja suositukset'),
              SettingsSwitchTile(
                title: 'Virtuaalikapteeni (AI)',
                subtitle:
                    'Laitteessa ja pilvessä toimiva luonnollisen kielen tilanneanalyysi.',
                value: _isAIEnabled,
                onChanged: (val) async {
                  if (val && !_hasAcknowledgedSafety) {
                    final accepted = await showDialog<bool>(
                      context: context,
                      builder: (_) => const AISafetyDisclaimerDialog(),
                    );
                    if (accepted ?? false) {
                      setState(() {
                        _isAIEnabled = true;
                        _hasAcknowledgedSafety = true;
                      });
                    }
                  } else {
                    setState(() => _isAIEnabled = val);
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildFishingModeToggle(colors),
              const SizedBox(height: 32),

              const SectionHeader('Pilvi-tekoälyn konfigurointi'),
              _buildAiConfigSection(colors),
              const SizedBox(height: 32),

              const SectionHeader('Tuulirajat (m/s)'),
              SettingsThresholdSlider(
                label: 'Huomio (Keltainen)',
                value: _windYellow,
                min: 5,
                max: 25,
                unit: 'm/s',
                onChanged: (val) => setState(() {
                  _windYellow = val;
                  if (_windOrange < _windYellow) _windOrange = _windYellow;
                  if (_windRed < _windOrange) _windRed = _windOrange;
                }),
              ),
              SettingsThresholdSlider(
                label: 'Varoitus (Oranssi)',
                value: _windOrange,
                min: 10,
                max: 30,
                unit: 'm/s',
                onChanged: (val) => setState(() {
                  _windOrange = val;
                  if (_windYellow > _windOrange) _windYellow = _windOrange;
                  if (_windRed < _windOrange) _windRed = _windOrange;
                }),
              ),
              SettingsThresholdSlider(
                label: 'Kriittinen (Punainen)',
                value: _windRed,
                min: 15,
                max: 40,
                unit: 'm/s',
                onChanged: (val) => setState(() {
                  _windRed = val;
                  if (_windOrange > _windRed) _windOrange = _windRed;
                  if (_windYellow > _windOrange) _windYellow = _windOrange;
                }),
              ),

              const SizedBox(height: 32),
              const SectionHeader('Aallokkorajat (m)'),
              SettingsThresholdSlider(
                label: 'Huomio (Keltainen)',
                value: _waveYellow,
                min: 0.5,
                max: 3,
                unit: 'm',
                onChanged: (val) => setState(() {
                  _waveYellow = val;
                  if (_waveOrange < _waveYellow) _waveOrange = _waveYellow;
                  if (_waveRed < _waveOrange) _waveRed = _waveOrange;
                }),
              ),
              SettingsThresholdSlider(
                label: 'Varoitus (Oranssi)',
                value: _waveOrange,
                min: 1,
                max: 5,
                unit: 'm',
                onChanged: (val) => setState(() {
                  _waveOrange = val;
                  if (_waveYellow > _waveOrange) _waveYellow = _waveOrange;
                  if (_waveRed < _waveOrange) _waveRed = _waveOrange;
                }),
              ),
              SettingsThresholdSlider(
                label: 'Kriittinen (Punainen)',
                value: _waveRed,
                min: 2,
                max: 10,
                unit: 'm',
                onChanged: (val) => setState(() {
                  _waveRed = val;
                  if (_waveOrange > _waveRed) _waveOrange = _waveRed;
                  if (_waveYellow > _waveOrange) _waveYellow = _waveOrange;
                }),
              ),

              const SizedBox(height: 32),
              const SectionHeader('Sään muutosherkkyys'),
              SettingsThresholdSlider(
                label: 'Ilmanpaineen nopea lasku (hPa/h)',
                value: _pressureDrop,
                min: 0.5,
                max: 5,
                unit: 'hPa',
                onChanged: (val) => setState(() => _pressureDrop = val),
              ),

              const SizedBox(height: 32),
              const SectionHeader('Ennusteen tarkasteluhorisontti'),
              _buildForecastWindowSelector(colors),

              const SizedBox(height: 32),
              const SectionHeader('Paikallinen tekoälymalli'),
              _buildModelManagementTile(colors),

              const SizedBox(height: 48),
              SettingsActionButtons(
                isAIEnabled: _isAIEnabled,
                forecastWindow: _forecastWindow,
                windYellow: _windYellow,
                windOrange: _windOrange,
                windRed: _windRed,
                waveYellow: _waveYellow,
                waveOrange: _waveOrange,
                waveRed: _waveRed,
                pressureDrop: _pressureDrop,
                hasAcknowledgedSafety: _hasAcknowledgedSafety,
                aiApiKey: _aiApiKey,
                aiModelId: _aiModelId,
                onReset: () async {
                  await ref
                      .read(skipperSettingsControllerProvider.notifier)
                      .resetToDefaults();
                  setState(() {
                    _isInit = false;
                  });
                },
              ),
            ],
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: colors.primaryAction),
        ),
        error: (err, _) => Center(
          child: Text(
            'Virhe: $err',
            style: TextStyle(color: colors.danger),
          ),
        ),
      ),
    );
  }

  Widget _buildForecastWindowSelector(AppThemeColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ennusteen tarkasteluaika',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Kippari skannaa tulevia ennusteita mahdollisten sääriskien varalta.',
            style: AppTextStyles.caption.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [3, 6, 12].map((h) {
              final isSelected = _forecastWindow == h;
              return ChoiceChip(
                label: Text('${h}h'),
                selected: isSelected,
                onSelected: (val) {
                  if (val) setState(() => _forecastWindow = h);
                },
                selectedColor: colors.primaryAction.withValues(alpha: 0.2),
                labelStyle: TextStyle(
                  color: isSelected
                      ? colors.primaryAction
                      : colors.textSecondary,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                backgroundColor: colors.surfaceHighlight,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAiConfigSection(AppThemeColors colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.glassBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OpenRouter API-avain',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tarvitaan laajempiin selityksiin pilvipalvelussa. Avain tallennetaan vain paikallisesti laitteeseesi.',
            style: AppTextStyles.caption.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _apiKeyController ??= TextEditingController(
              text: _aiApiKey,
            ),
            onChanged: (val) =>
                _aiApiKey = val.trim().isEmpty ? null : val.trim(),
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'sk-or-v1-...',
              hintStyle: TextStyle(
                color: colors.textSecondary.withValues(alpha: 0.5),
              ),
              filled: true,
              fillColor: colors.surfaceHighlight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            style: AppTextStyles.mono.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 20),
          Text(
            'Tekoälymalli',
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Valitse käytettävä tekoälymalli suosituksille.',
            style: AppTextStyles.caption.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _aiModelId,
            dropdownColor: colors.surface,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              filled: true,
              fillColor: colors.surfaceHighlight,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: 'meta-llama/llama-3.3-70b-instruct:free',
                child: Text('Llama 3.3 70B (Suositus)'),
              ),
              DropdownMenuItem(
                value: 'meta-llama/llama-3.2-3b-instruct:free',
                child: Text('Llama 3.2 3B (Nopea)'),
              ),
              DropdownMenuItem(
                value: 'openrouter/free',
                child: Text('OpenRouter Free Router'),
              ),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _aiModelId = val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFishingModeToggle(AppThemeColors colors) {
    final fishingModeAsync = ref.watch(fishingModeControllerProvider);

    return fishingModeAsync.when(
      loading: () => _buildDisabledTile('Kalastusmoodi', 'Ladataan...', colors),
      error: (err, _) => _buildDisabledTile('Kalastusmoodi', 'Virhe', colors),
      data: (mode) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.glassBorder),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kalastusmoodi',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Näytä kalastusrajoitukset kartalla',
                    style: AppTextStyles.caption.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: mode.isEnabled,
              activeThumbColor: colors.primaryAction,
              activeTrackColor: colors.primaryAction.withValues(alpha: 0.4),
              onChanged: (val) {
                if (val != mode.isEnabled) {
                  ref.read(fishingModeControllerProvider.notifier).toggle();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisabledTile(
    String title,
    String subtitle,
    AppThemeColors colors,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.glassBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.caption.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 44,
            height: 24,
            child: Container(
              decoration: BoxDecoration(
                color: colors.surfaceHighlight,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModelManagementTile(AppThemeColors colors) {
    final downloadState = ref.watch(modelDownloadServiceProvider);

    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (downloadState.status) {
      case DownloadStatus.notDownloaded:
        statusColor = colors.textSecondary;
        statusText = 'Ei asennettu';
        statusIcon = Icons.cloud_download_outlined;
      case DownloadStatus.checkingWifi:
        statusColor = colors.textSecondary;
        statusText = 'Tarkistetaan Wi-Fiä...';
        statusIcon = Icons.wifi_find;
      case DownloadStatus.downloading:
        statusColor = colors.primaryAction;
        statusText =
            'Ladataan ${(downloadState.progress * 100).toStringAsFixed(0)}%';
        statusIcon = Icons.downloading;
      case DownloadStatus.ready:
        statusColor = colors.success;
        statusText = 'Valmis (Offline)';
        statusIcon = Icons.check_circle;
      case DownloadStatus.error:
        statusColor = colors.danger;
        statusText = 'Virhe';
        statusIcon = Icons.error_outline;
    }

    return Container(
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
              Icon(statusIcon, color: statusColor),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gemma 3 1B (Laitemalli)',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                  if (downloadState.status == DownloadStatus.notDownloaded)
                    Text(
                      '~700 MB - Wi-Fi suositeltava',
                      style: AppTextStyles.caption.copyWith(
                        color: colors.textSecondary,
                      ),
                    )
                  else
                    Text(
                      statusText,
                      style: AppTextStyles.caption.copyWith(color: statusColor),
                    ),
                ],
              ),
              const Spacer(),
              if (downloadState.status == DownloadStatus.notDownloaded ||
                  downloadState.status == DownloadStatus.error)
                IconButton(
                  icon: const Icon(Icons.download),
                  color: colors.primaryAction,
                  tooltip: 'Lataa malli',
                  onPressed: () => ref
                      .read(modelDownloadServiceProvider.notifier)
                      .downloadModel(),
                ),
              if (downloadState.status == DownloadStatus.ready)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: colors.danger,
                  tooltip: 'Poista malli',
                  onPressed: () => ref
                      .read(modelDownloadServiceProvider.notifier)
                      .deleteModel(),
                ),
            ],
          ),
          if (downloadState.status == DownloadStatus.downloading) ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: downloadState.progress,
              backgroundColor: colors.surfaceHighlight,
              color: colors.primaryAction,
              borderRadius: BorderRadius.circular(2),
            ),
          ],
          if (downloadState.status == DownloadStatus.error &&
              downloadState.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                downloadState.errorMessage!,
                style: AppTextStyles.caption.copyWith(color: colors.danger),
              ),
            ),
        ],
      ),
    );
  }
}
