import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modules/module_registry.dart';
import '../../modules/core/module_enums.dart';

class ModuleProgress {
  final ResearchModule module;
  final ModuleStatus status;
  final double completionPercentage; // 0.0 to 1.0
  final bool isUnlocked; // For 'unique' frequency modules
  final Map<String, dynamic>? customConfig;

  ModuleProgress({
    required this.module,
    this.status = ModuleStatus.pending,
    this.completionPercentage = 0.0,
    this.isUnlocked = false,
    this.customConfig,
  });

  ModuleProgress copyWith({
    ModuleStatus? status,
    double? completionPercentage,
    bool? isUnlocked,
    Map<String, dynamic>? customConfig,
  }) {
    return ModuleProgress(
      module: module,
      status: status ?? this.status,
      completionPercentage: completionPercentage ?? this.completionPercentage,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      customConfig: customConfig ?? this.customConfig,
    );
  }
}

class EvaluationSessionState {
  final String sessionId;
  final List<ModuleProgress> modules;
  final int currentModuleIndex;

  EvaluationSessionState({
    required this.sessionId,
    required this.modules,
    this.currentModuleIndex = 0,
  });
  
  double get globalProgress {
    if (modules.isEmpty) return 0.0;
    double total = modules.fold(0.0, (sum, m) => sum + m.completionPercentage);
    return total / modules.length;
  }

  EvaluationSessionState copyWith({
    String? sessionId,
    List<ModuleProgress>? modules,
    int? currentModuleIndex,
  }) {
    return EvaluationSessionState(
      sessionId: sessionId ?? this.sessionId,
      modules: modules ?? this.modules,
      currentModuleIndex: currentModuleIndex ?? this.currentModuleIndex,
    );
  }
}

class EvaluationSessionNotifier extends Notifier<EvaluationSessionState?> {
  @override
  EvaluationSessionState? build() {
    return null;
  }

  void startNewEvaluation(List<ModuleProgress> modulesProgress) {
    state = EvaluationSessionState(
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      modules: modulesProgress,
    );
  }

  void selectModule(int index) {
    if (state != null && index >= 0 && index < state!.modules.length) {
      state = state!.copyWith(currentModuleIndex: index);
    }
  }

  void unlockCurrentModule() {
    if (state == null) return;
    final updatedModules = List<ModuleProgress>.from(state!.modules);
    final idx = state!.currentModuleIndex;
    
    updatedModules[idx] = updatedModules[idx].copyWith(isUnlocked: true);
    state = state!.copyWith(modules: updatedModules);
  }

  void updateCurrentModuleProgress(double progress) {
    if (state == null) return;
    final updatedModules = List<ModuleProgress>.from(state!.modules);
    final idx = state!.currentModuleIndex;
    
    updatedModules[idx] = updatedModules[idx].copyWith(
      completionPercentage: progress,
      status: progress >= 1.0 ? ModuleStatus.completed : ModuleStatus.inProgress,
    );
    state = state!.copyWith(modules: updatedModules);
  }
}

final evaluationSessionProvider = NotifierProvider<EvaluationSessionNotifier, EvaluationSessionState?>(EvaluationSessionNotifier.new);
