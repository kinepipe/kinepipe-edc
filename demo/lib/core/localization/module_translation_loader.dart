import 'dart:convert';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import '../../modules/module_registry.dart';
import '../../modules/instances/personal_data_module.dart';
import '../../modules/instances/parq_module.dart';
import '../../modules/instances/vital_signs_module.dart';

class ModuleTranslationLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    // 1. Load base translations from local JSON assets
    final String baseData = await rootBundle.loadString('$path/${locale.languageCode}-${locale.countryCode ?? locale.languageCode.toUpperCase()}.json');
    Map<String, dynamic> mergedTranslations = json.decode(baseData);

    // 2. Add translations from registered modules
    final List<ResearchModule> modules = [
      PersonalDataModule(),
      VitalSignsModule(),
      ParQModule(),
    ];

    // Mapping ISO 639-3 to ISO 639-1 (for easy_localization compatibility)
    final Map<String, String> isoMapping = {
      'es': 'spa',
      'en': 'eng',
      'pt': 'por',
      'fr': 'fra',
    };

    final String iso3Code = isoMapping[locale.languageCode] ?? locale.languageCode;

    for (var module in modules) {
      final moduleTranslations = module.translations[iso3Code];
      if (moduleTranslations != null) {
        // We nest them under the module ID to avoid collisions
        mergedTranslations[module.id] = moduleTranslations;
      }
    }

    return mergedTranslations;
  }
}
