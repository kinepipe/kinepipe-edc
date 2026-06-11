import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modules/core/module_flow_models.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/module_web_repository.dart';

class ModuleManagerState {
  final List<AvailableModule> marketplaceModules;
  final List<EvaluationRoute> routes;
  final String? activeRouteId;
  final bool isLoading;
  final String searchQuery;
  final String? selectedCategory;

  ModuleManagerState({
    this.marketplaceModules = const [],
    this.routes = const [],
    this.activeRouteId,
    this.isLoading = true,
    this.searchQuery = '',
    this.selectedCategory,
  });

  List<AvailableModule> get installedModules => 
      marketplaceModules.where((m) => m.isInstalled).toList();

  List<AvailableModule> get enabledModules => 
      marketplaceModules.where((m) => m.isInstalled && m.isEnabled).toList();

  List<AvailableModule> get filteredMarketplaceModules {
    return marketplaceModules.where((m) {
      final matchesSearch = searchQuery.isEmpty || 
          m.name.toLowerCase().contains(searchQuery.toLowerCase()) || 
          m.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
          m.tags.any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()));
      
      final matchesCategory = selectedCategory == null || selectedCategory == 'Todos' ||
          m.categories.contains(selectedCategory);

      return matchesSearch && matchesCategory;
    }).toList();
  }

  EvaluationRoute? get activeRoute {
    if (routes.isEmpty) return null;
    if (activeRouteId == null) return routes.first;
    return routes.firstWhere((r) => r.id == activeRouteId, orElse: () => routes.first);
  }

  ModuleManagerState copyWith({
    List<AvailableModule>? marketplaceModules,
    List<EvaluationRoute>? routes,
    String? activeRouteId,
    bool? isLoading,
    String? searchQuery,
    String? selectedCategory,
  }) {
    return ModuleManagerState(
      marketplaceModules: marketplaceModules ?? this.marketplaceModules,
      routes: routes ?? this.routes,
      activeRouteId: activeRouteId ?? this.activeRouteId,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class ModuleManagerNotifier extends Notifier<ModuleManagerState> {
  static const _installedPrefsKey = 'installed_modules_v1';
  static const _enabledPrefsKey = 'enabled_modules_v1';

  @override
  ModuleManagerState build() {
    // Inicializamos asíncronamente
    _loadFromWebAndCache();
    return ModuleManagerState(
      isLoading: true,
      routes: [
        EvaluationRoute(
          name: 'Flujo de Ingreso Estándar',
          description: 'Flujo básico para nuevos participantes.',
          steps: [
            ModuleStep(moduleId: 'personal_data'),
            ModuleStep(moduleId: 'vital_signs'),
            ModuleStep(moduleId: 'parq'),
          ],
        )
      ]
    );
  }

  Future<void> _loadFromWebAndCache() async {
    final repo = ref.read(moduleWebRepositoryProvider);
    final webModules = await repo.fetchAvailableModules();
    
    final prefs = await SharedPreferences.getInstance();
    final installedList = prefs.getStringList(_installedPrefsKey) ?? ['personal_data', 'vital_signs', 'parq'];
    final enabledList = prefs.getStringList(_enabledPrefsKey) ?? ['personal_data', 'vital_signs', 'parq'];

    final mergedModules = webModules.map((m) {
      return m.copyWith(
        isInstalled: installedList.contains(m.id),
        isEnabled: enabledList.contains(m.id),
      );
    }).toList();

    state = state.copyWith(
      marketplaceModules: mergedModules,
      isLoading: false,
    );
  }

  Future<void> _saveCache(List<AvailableModule> modules) async {
    final prefs = await SharedPreferences.getInstance();
    final installedList = modules.where((m) => m.isInstalled).map((m) => m.id).toList();
    final enabledList = modules.where((m) => m.isEnabled).map((m) => m.id).toList();
    await prefs.setStringList(_installedPrefsKey, installedList);
    await prefs.setStringList(_enabledPrefsKey, enabledList);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void toggleModuleEnabled(String id, bool enabled) {
    final newModules = state.marketplaceModules.map((m) {
      if (m.id == id && m.isInstalled) {
        return m.copyWith(isEnabled: enabled);
      }
      return m;
    }).toList();
    
    state = state.copyWith(marketplaceModules: newModules);
    _saveCache(newModules);
  }

  void installModule(String id) {
    final newModules = state.marketplaceModules.map((m) {
      if (m.id == id) {
        return m.copyWith(isInstalled: true, isEnabled: true);
      }
      return m;
    }).toList();

    state = state.copyWith(marketplaceModules: newModules);
    _saveCache(newModules);
  }
  
  void uninstallModule(String id) {
    final newModules = state.marketplaceModules.map((m) {
      if (m.id == id) {
        return m.copyWith(isInstalled: false, isEnabled: false);
      }
      return m;
    }).toList();

    state = state.copyWith(marketplaceModules: newModules);
    _saveCache(newModules);
  }

  void createOrUpdateRoute(EvaluationRoute route) {
    final index = state.routes.indexWhere((r) => r.id == route.id);
    if (index >= 0) {
      final newRoutes = List<EvaluationRoute>.from(state.routes);
      newRoutes[index] = route;
      state = state.copyWith(routes: newRoutes);
    } else {
      state = state.copyWith(routes: [...state.routes, route]);
    }
  }

  void deleteRoute(String id) {
    state = state.copyWith(
      routes: state.routes.where((r) => r.id != id).toList()
    );
  }

  void setActiveRoute(String id) {
    state = state.copyWith(activeRouteId: id);
  }
}

final moduleManagerProvider = NotifierProvider<ModuleManagerNotifier, ModuleManagerState>(ModuleManagerNotifier.new);
