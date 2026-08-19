import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/models/bbox.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/map/presentation/providers/layer_filter_provider.dart';
import 'package:sakkoja/features/speed_limits/di/speed_limits_di.dart';
import 'package:sakkoja/features/speed_limits/domain/entities/speed_limit_zone.dart';

class DebugBBoxWidget extends ConsumerStatefulWidget {
  const DebugBBoxWidget({super.key, this.userLocation});
  final LatLng? userLocation;

  @override
  ConsumerState<DebugBBoxWidget> createState() => _DebugBBoxWidgetState();
}

class _DebugBBoxWidgetState extends ConsumerState<DebugBBoxWidget> {
  bool _isLoading = false;
  List<SpeedLimitZone>? _fetchedZones;
  String? _error;
  BBox? _lastBBox;
  DateTime? _lastFetchTime;

  Future<void> _fetchBBoxData() async {
    if (widget.userLocation == null) {
      setState(() {
        _error = 'No user location available';
        _fetchedZones = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _fetchedZones = null;
    });

    try {
      // Create 5km bbox
      final bbox = BBox.fromCenter(widget.userLocation!, 5);
      _lastBBox = bbox;
      _lastFetchTime = DateTime.now();

      // Fetch from API
      final useCase = ref.read(getSpeedLimitsWithBBoxUseCaseProvider);
      final result = await useCase(bbox);

      result.fold(
        (failure) {
          setState(() {
            _error = 'API Error: ${failure.message}';
            _isLoading = false;
          });
        },
        (zones) {
          setState(() {
            _fetchedZones = zones;
            _isLoading = false;
            _error = null;
          });
        },
      );
    } catch (e) {
      setState(() {
        _error = 'Exception: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              const Icon(Icons.bug_report, color: Colors.blue, size: 20),
              const SizedBox(width: 8),
              const Text(
                'DEBUG: BBox Fetch',
                style: TextStyle(
                  color: AppPalette.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppPalette.textPrimary.withValues(alpha: 0.5),
                ),
                onPressed: () {
                  // Close callback would be passed from parent
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const Divider(color: Colors.blue),
          const SizedBox(height: 8),

          // Location Info
          if (widget.userLocation != null) ...[
            _buildInfoRow(
              'Location',
              '${widget.userLocation!.latitude.toStringAsFixed(4)}, '
                  '${widget.userLocation!.longitude.toStringAsFixed(4)}',
              Colors.green,
            ),
            const SizedBox(height: 4),
          ] else ...[
            _buildInfoRow('Location', 'NOT AVAILABLE', Colors.red),
            const SizedBox(height: 4),
          ],

          // BBox Info
          if (_lastBBox != null) ...[
            _buildInfoRow('BBox (5km)', _lastBBox!.toWfsParam(), Colors.blue),
            const SizedBox(height: 4),
          ],

          // Last Fetch Time
          if (_lastFetchTime != null) ...[
            _buildInfoRow(
              'Last Fetch',
              '${_lastFetchTime!.hour}:${_lastFetchTime!.minute.toString().padLeft(2, '0')}:${_lastFetchTime!.second.toString().padLeft(2, '0')}',
              AppPalette.textSecondary,
            ),
            const SizedBox(height: 8),
          ],

          // Fetch Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isLoading ? null : _fetchBBoxData,
              icon: _isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppPalette.textPrimary,
                      ),
                    )
                  : const Icon(Icons.refresh),
              label: Text(_isLoading ? 'Fetching...' : 'Fetch 5km BBox Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: AppPalette.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Results
          if (_error != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'ERROR',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: const TextStyle(
                      color: AppPalette.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ] else if (_fetchedZones != null) ...[
            Builder(
              builder: (context) {
                final layerFilterAsync = ref.watch(layerFilterProvider);
                final layerFilter =
                    layerFilterAsync.value ?? LayerFilterState.initial();
                final visibleCount = _fetchedZones!.where((z) {
                  var isVisible = layerFilter.isVisible(z.typeDescription);
                  // Hybrid Logic
                  if (!isVisible &&
                      z.speedLimitKmh > 0 &&
                      layerFilter.isVisible('Nopeusrajoitus')) {
                    isVisible = true;
                  }
                  return isVisible;
                }).length;

                return Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'SUCCESS: ${_fetchedZones!.length} zones ($visibleCount visible)',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Zone details
                      if (_fetchedZones!.isNotEmpty) ...[
                        const Text(
                          'Sample Zones:',
                          style: TextStyle(
                            color: AppPalette.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _fetchedZones!.length.clamp(0, 10),
                            itemBuilder: (context, index) {
                              final zone = _fetchedZones![index];
                              var isVisible = layerFilter.isVisible(
                                zone.typeDescription,
                              );
                              if (!isVisible &&
                                  zone.speedLimitKmh > 0 &&
                                  layerFilter.isVisible('Nopeusrajoitus')) {
                                isVisible = true;
                              }

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 6),
                                child: Text(
                                  '${index + 1}. ${zone.typeDescription ?? "Unknown"} '
                                  '- ${zone.speedLimitKmh > 0 ? "${zone.speedLimitKmh} km/h" : "No speed"}'
                                  '${isVisible ? "" : " (HIDDEN)"}',
                                  style: TextStyle(
                                    color: isVisible
                                        ? AppPalette.textPrimary.withValues(
                                            alpha: 0.7,
                                          )
                                        : AppPalette.textSecondary.withValues(
                                            alpha: 0.6,
                                          ),
                                    fontSize: 11,
                                    decoration: isVisible
                                        ? null
                                        : TextDecoration.lineThrough,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (_fetchedZones!.length > 10) ...[
                          const SizedBox(height: 4),
                          Text(
                            '... and ${_fetchedZones!.length - 10} more',
                            style: const TextStyle(
                              color: AppPalette.textSecondary,
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ] else ...[
                        const Text(
                          'No zones found in this area',
                          style: TextStyle(
                            color: AppPalette.warning,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppPalette.textPrimary,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );
  }
}
