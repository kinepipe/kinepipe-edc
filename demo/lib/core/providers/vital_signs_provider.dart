import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalSignsData {
  final int? heartRate;
  final int? systolicBP;
  final int? diastolicBP;
  final double? oxygenSaturation;
  final double? temperature;

  VitalSignsData({
    this.heartRate,
    this.systolicBP,
    this.diastolicBP,
    this.oxygenSaturation,
    this.temperature,
  });

  bool get hasBloodPressure => systolicBP != null && diastolicBP != null;
  bool get isBloodPressureHigh => hasBloodPressure && (systolicBP! > 144 || diastolicBP! > 94);

  VitalSignsData copyWith({
    int? heartRate,
    int? systolicBP,
    int? diastolicBP,
    double? oxygenSaturation,
    double? temperature,
  }) {
    return VitalSignsData(
      heartRate: heartRate ?? this.heartRate,
      systolicBP: systolicBP ?? this.systolicBP,
      diastolicBP: diastolicBP ?? this.diastolicBP,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      temperature: temperature ?? this.temperature,
    );
  }
}

class VitalSignsNotifier extends Notifier<VitalSignsData> {
  @override
  VitalSignsData build() {
    return VitalSignsData();
  }

  void updateField({
    int? heartRate,
    int? systolicBP,
    int? diastolicBP,
    double? oxygenSaturation,
    double? temperature,
  }) {
    state = state.copyWith(
      heartRate: heartRate,
      systolicBP: systolicBP,
      diastolicBP: diastolicBP,
      oxygenSaturation: oxygenSaturation,
      temperature: temperature,
    );
  }
}

final vitalSignsProvider = NotifierProvider<VitalSignsNotifier, VitalSignsData>(VitalSignsNotifier.new);
