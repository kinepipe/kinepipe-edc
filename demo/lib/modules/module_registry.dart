import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/module_enums.dart';
import 'instances/personal_data_module.dart';
import 'instances/parq_module.dart';
import 'instances/consent_module.dart';
import 'instances/rapa_module.dart';

/// Define the standard interface for all research modules
abstract class ResearchModule {
  String get id;
  String get name;
  String get description;
  IconData get icon;
  
  /// Determines how often this module needs to be filled
  UpdateFrequency get updateFrequency;

  /// Decentralized translations for the module using ISO 639-3 codes.
  /// Format: {'spa': {'key': 'value'}, 'eng': {'key': 'value'}}
  Map<String, Map<String, String>> get translations => {};

  /// Returns the list of available languages for this specific module.
  List<String> get availableLanguages => translations.keys.toList();

  /// Prints the module results to a professional PDF.
  Future<void> printToPdf(BuildContext context);
  
  // Method that returns the UI for this module during an evaluation flow
  Widget buildEvaluationView(BuildContext context, {required bool isLocked, Map<String, dynamic>? customConfig});
}

/// Notifier to manage loaded modules
class ModuleRegistryNotifier extends Notifier<List<ResearchModule>> {
  @override
  List<ResearchModule> build() {
    return [
      PersonalDataModule(),
      ParQModule(),
      ConsentModule(),
      RapaModule(),
    ];
  }

  void registerModule(ResearchModule module) {
    state = [...state, module];
  }

  void unregisterModule(String moduleId) {
    state = state.where((m) => m.id != moduleId).toList();
  }
}

/// Provider to access the module registry globally
final moduleRegistryProvider = NotifierProvider<ModuleRegistryNotifier, List<ResearchModule>>(ModuleRegistryNotifier.new);
