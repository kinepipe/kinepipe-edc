import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

enum ModulePermissionOverride {
  none,       // Usa el permiso dictado por el Rol del usuario (99% de los casos)
  readOnly,   // Fuerzo a que sea solo lectura en esta ruta
  editable,   // Fuerzo a que sea editable en esta ruta
  suggestion, // Modo sugerencias (cambios en historial)
}

class AvailableModule {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final String version;
  final bool isInstalled;
  final bool isEnabled;
  final List<String> tags;
  final List<String> categories;
  final String author;
  final int downloads;
  final double rating;

  AvailableModule({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.version,
    this.isInstalled = false,
    this.isEnabled = false,
    this.tags = const [],
    this.categories = const [],
    this.author = 'Research Module Team',
    this.downloads = 0,
    this.rating = 5.0,
  });

  AvailableModule copyWith({
    bool? isInstalled,
    bool? isEnabled,
  }) {
    return AvailableModule(
      id: id,
      name: name,
      description: description,
      icon: icon,
      version: version,
      isInstalled: isInstalled ?? this.isInstalled,
      isEnabled: isEnabled ?? this.isEnabled,
      tags: tags,
      categories: categories,
      author: author,
      downloads: downloads,
      rating: rating,
    );
  }
}

class ModuleStep {
  final String id; // UUID único para este paso en la ruta
  final String moduleId; // ID del módulo que estamos usando (ej: 'parq')
  final ModulePermissionOverride permissionOverride;
  final Map<String, dynamic>? customConfig; // Configuración específica (ej: reglas de consentimiento)

  ModuleStep({
    String? id,
    required this.moduleId,
    this.permissionOverride = ModulePermissionOverride.none,
    this.customConfig,
  }) : id = id ?? const Uuid().v4();

  ModuleStep copyWith({
    String? moduleId,
    ModulePermissionOverride? permissionOverride,
    Map<String, dynamic>? customConfig,
  }) {
    return ModuleStep(
      id: id, // Keep same instance ID
      moduleId: moduleId ?? this.moduleId,
      permissionOverride: permissionOverride ?? this.permissionOverride,
      customConfig: customConfig ?? this.customConfig,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'moduleId': moduleId,
      'permissionOverride': permissionOverride.index,
      'customConfig': customConfig,
    };
  }

  factory ModuleStep.fromJson(Map<String, dynamic> json) {
    return ModuleStep(
      id: json['id'],
      moduleId: json['moduleId'],
      permissionOverride: ModulePermissionOverride.values[json['permissionOverride'] ?? 0],
      customConfig: json['customConfig'],
    );
  }
}

class EvaluationRoute {
  final String id;
  final String name;
  final String description;
  final List<ModuleStep> steps;
  final bool isActive;

  EvaluationRoute({
    String? id,
    required this.name,
    this.description = '',
    required this.steps,
    this.isActive = true,
  }) : id = id ?? const Uuid().v4();

  EvaluationRoute copyWith({
    String? name,
    String? description,
    List<ModuleStep>? steps,
    bool? isActive,
  }) {
    return EvaluationRoute(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      steps: steps ?? List.from(this.steps),
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'steps': steps.map((s) => s.toJson()).toList(),
      'isActive': isActive,
    };
  }

  factory EvaluationRoute.fromJson(Map<String, dynamic> json) {
    return EvaluationRoute(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      steps: (json['steps'] as List).map((s) => ModuleStep.fromJson(s)).toList(),
      isActive: json['isActive'] ?? true,
    );
  }
}
