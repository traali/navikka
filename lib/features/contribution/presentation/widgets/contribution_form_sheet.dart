import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakkoja/core/theme/app_palette.dart';
import 'package:sakkoja/features/contribution/domain/entities/user_contribution.dart';
import 'package:sakkoja/features/contribution/presentation/providers/contribution_provider.dart';

class ContributionFormSheet extends ConsumerStatefulWidget {
  const ContributionFormSheet({required this.location, super.key});
  final LatLng location;

  @override
  ConsumerState<ContributionFormSheet> createState() =>
      _ContributionFormSheetState();
}

class _ContributionFormSheetState extends ConsumerState<ContributionFormSheet> {
  ContributionType _type = ContributionType.speedLimit;
  double _speedLimit = 30; // Default speed
  String _signType = 'No Wake'; // Default sign (placeholder)

  // Common marine speed limits
  final List<double> _speedOptions = [5, 10, 20, 30, 40, 50, 60];

  final List<String> _signOptions = [
    'No Wake',
    'No Anchoring',
    'No Mooring',
    'Speed Recommendation',
    'Warning',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppPalette.textPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Map Data',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          // Type Selector
          SegmentedButton<ContributionType>(
            segments: const [
              ButtonSegment(
                value: ContributionType.speedLimit,
                label: Text('Speed Limit'),
                icon: Icon(Icons.speed),
              ),
              ButtonSegment(
                value: ContributionType.trafficSign,
                label: Text('Sign'),
                icon: Icon(Icons.signpost),
              ),
            ],
            selected: {_type},
            onSelectionChanged: (newSelection) {
              setState(() {
                _type = newSelection.first;
              });
            },
          ),
          const SizedBox(height: 24),

          // Dynamic Form Fields
          if (_type == ContributionType.speedLimit) ...[
            Text(
              'Speed Limit (km/h)',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _speedOptions.length,
                separatorBuilder: (context, index2) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final speed = _speedOptions[index];
                  final isSelected = _speedLimit == speed;
                  return ChoiceChip(
                    label: Text(speed.toInt().toString()),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _speedLimit = speed);
                    },
                  );
                },
              ),
            ),
          ] else ...[
            Text('Sign Type', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _signType,
              items: _signOptions.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _signType = val);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ],

          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _saveContribution,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppPalette.primaryAction,
              foregroundColor: AppPalette.textPrimary,
            ),
            child: const Text('SAVE'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _saveContribution() {
    final value = _type == ContributionType.speedLimit
        ? _speedLimit.toInt().toString()
        : _signType;

    ref
        .read(contributionProvider.notifier)
        .addContribution(type: _type, location: widget.location, value: value);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contribution saved locally!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
