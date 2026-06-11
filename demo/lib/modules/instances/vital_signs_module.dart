import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../module_registry.dart';
import '../core/module_enums.dart';
import '../../core/providers/vital_signs_provider.dart';

class VitalSignsModule extends ResearchModule {
  @override
  String get id => 'vital_signs';

  @override
  String get name => 'Signos Vitales';

  @override
  String get description => 'Evaluación clínica de signos vitales basales';

  @override
  IconData get icon => LucideIcons.activity;

  @override
  UpdateFrequency get updateFrequency => UpdateFrequency.dynamic;

  @override
  Map<String, Map<String, String>> get translations => {
    'spa': {
      'hr': 'Frecuencia Cardíaca (LPM)',
      'sys_bp': 'Presión Arterial Sistólica (mmHg)',
      'dia_bp': 'Presión Arterial Diastólica (mmHg)',
      'spo2': 'Saturación de Oxígeno (%)',
      'temp': 'Temperatura (°C)',
    },
    'eng': {
      'hr': 'Heart Rate (BPM)',
      'sys_bp': 'Systolic Blood Pressure (mmHg)',
      'dia_bp': 'Diastolic Blood Pressure (mmHg)',
      'spo2': 'Oxygen Saturation (%)',
      'temp': 'Temperature (°C)',
    }
  };

  @override
  Future<void> initialize() async {}

  @override
  Future<void> printToPdf(BuildContext context) async {
    // Basic implementation
  }

  @override
  Widget buildEvaluationView(BuildContext context, {required bool isLocked, Map<String, dynamic>? customConfig}) {
    return _VitalSignsEvaluationView(isLocked: isLocked);
  }
}

class _VitalSignsEvaluationView extends ConsumerStatefulWidget {
  final bool isLocked;
  const _VitalSignsEvaluationView({required this.isLocked});

  @override
  ConsumerState<_VitalSignsEvaluationView> createState() => _VitalSignsEvaluationViewState();
}

class _VitalSignsEvaluationViewState extends ConsumerState<_VitalSignsEvaluationView> {
  @override
  Widget build(BuildContext context) {
    final vitalSigns = ref.watch(vitalSignsProvider);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.activity, size: 32, color: theme.colorScheme.primary),
              const SizedBox(width: 12),
              Text(
                'Signos Vitales',
                style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildNumberField(
            'Presión Arterial Sistólica (mmHg)', 
            vitalSigns.systolicBP, 
            (v) => ref.read(vitalSignsProvider.notifier).updateField(systolicBP: v)
          ),
          const SizedBox(height: 16),
          _buildNumberField(
            'Presión Arterial Diastólica (mmHg)', 
            vitalSigns.diastolicBP, 
            (v) => ref.read(vitalSignsProvider.notifier).updateField(diastolicBP: v)
          ),
          const SizedBox(height: 16),
          _buildNumberField(
            'Frecuencia Cardíaca (LPM)', 
            vitalSigns.heartRate, 
            (v) => ref.read(vitalSignsProvider.notifier).updateField(heartRate: v)
          ),
          const SizedBox(height: 16),
          _buildDecimalField(
            'Saturación de Oxígeno (%)', 
            vitalSigns.oxygenSaturation, 
            (v) => ref.read(vitalSignsProvider.notifier).updateField(oxygenSaturation: v)
          ),
          const SizedBox(height: 16),
          _buildDecimalField(
            'Temperatura (°C)', 
            vitalSigns.temperature, 
            (v) => ref.read(vitalSignsProvider.notifier).updateField(temperature: v)
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildNumberField(String label, int? value, Function(int?) onChanged) {
    return TextFormField(
      initialValue: value?.toString() ?? '',
      enabled: !widget.isLocked,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      keyboardType: TextInputType.number,
      onChanged: (v) => onChanged(int.tryParse(v)),
    );
  }

  Widget _buildDecimalField(String label, double? value, Function(double?) onChanged) {
    return TextFormField(
      initialValue: value?.toString() ?? '',
      enabled: !widget.isLocked,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (v) => onChanged(double.tryParse(v)),
    );
  }
}
