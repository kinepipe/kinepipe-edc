import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/evaluation_session_provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../modules/instances/personal_data_module.dart';
import '../../../modules/instances/parq_module.dart';
import '../../../modules/instances/vital_signs_module.dart';
import '../../../modules/core/module_enums.dart';
import '../../../modules/module_registry.dart';

import '../../../core/providers/module_manager_provider.dart';

import '../../../modules/instances/consent_module.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/theme_provider.dart';

class EvaluationFlowScreen extends ConsumerStatefulWidget {
  const EvaluationFlowScreen({super.key});

  @override
  ConsumerState<EvaluationFlowScreen> createState() => _EvaluationFlowScreenState();
}

class _EvaluationFlowScreenState extends ConsumerState<EvaluationFlowScreen> {
  bool _isPatientMode = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final moduleState = ref.read(moduleManagerProvider);
      final activeRoute = moduleState.activeRoute;
      
      List<ModuleProgress> modulesProgress = [];
      
      if (activeRoute != null) {
        final registeredModules = ref.read(moduleRegistryProvider);
        for (final step in activeRoute.steps) {
          // Buscamos dinámicamente en el registro global de módulos
          final matchingModules = registeredModules.where((m) => m.id == step.moduleId);
          
          if (matchingModules.isNotEmpty) {
            final module = matchingModules.first;
            modulesProgress.add(ModuleProgress(
              module: module,
              customConfig: step.customConfig,
              isUnlocked: module.updateFrequency != UpdateFrequency.unique,
            ));
          }
        }
      }
      
      // Fallback de seguridad
      if (modulesProgress.isEmpty) {
        modulesProgress = [
          ModuleProgress(module: PersonalDataModule(), isUnlocked: true),
          ModuleProgress(module: VitalSignsModule(), isUnlocked: true),
          ModuleProgress(module: ParQModule(), isUnlocked: true),
        ];
      }

      ref.read(evaluationSessionProvider.notifier).startNewEvaluation(modulesProgress);
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(evaluationSessionProvider);

    if (session == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: _isPatientMode ? null : AppBar(
        title: Text('${tr('dashboard.action_new_eval')} - ${(session.globalProgress * 100).toInt()}%'),
        actions: [
          _buildLanguageToggle(context, session),
          IconButton(
            icon: const Icon(LucideIcons.user),
            tooltip: 'Modo Paciente',
            onPressed: () => _togglePatientMode(),
          ),
          IconButton(
            icon: const Icon(LucideIcons.settings),
            tooltip: 'Opciones y Configuraciones',
            onPressed: () {
              context.push('/settings');
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: (ref.watch(themeProvider).progressIndicatorStyle == ProgressIndicatorStyle.linearHeader || _isPatientMode)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: LinearProgressIndicator(
                value: session.globalProgress,
                backgroundColor: Colors.white24,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
      ),
      body: Row(
        children: [
          // Sidebar (Stepper replacement)
          if (!_isPatientMode && ref.watch(themeProvider).progressIndicatorStyle == ProgressIndicatorStyle.circularSidebar)
            SizedBox(
              width: 250,
              child: ListView.builder(
                itemCount: session.modules.length,
                itemBuilder: (context, index) {
                  final moduleProgress = session.modules[index];
                  final isSelected = session.currentModuleIndex == index;
                  
                  return ListTile(
                    selected: isSelected,
                    leading: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: moduleProgress.completionPercentage,
                          strokeWidth: 3,
                          color: moduleProgress.status == ModuleStatus.completed ? Colors.green : Colors.blue,
                          backgroundColor: Colors.white12,
                        ),
                        Icon(moduleProgress.module.icon, size: 16),
                      ],
                    ),
                    title: Text(moduleProgress.module.name),
                    onTap: () {
                      ref.read(evaluationSessionProvider.notifier).selectModule(index);
                    },
                  );
                },
              ),
            ),
          if (!_isPatientMode && ref.watch(themeProvider).progressIndicatorStyle == ProgressIndicatorStyle.circularSidebar) const VerticalDivider(width: 1),
          // Main Module Content Area
          Expanded(
            child: session.modules.isEmpty
                ? const Center(child: Text('No active modules found.'))
                : Stack(
                    children: [
                      _buildModuleContent(context, session.modules[session.currentModuleIndex]),
                      if (_isPatientMode)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: FloatingActionButton.small(
                            onPressed: () => _togglePatientMode(),
                            tooltip: 'Salir de Modo Paciente',
                            child: const Icon(LucideIcons.logOut),
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void _togglePatientMode() {
    if (_isPatientMode) {
      // Pedir confirmación/pass para salir del modo paciente
      _showExitPatientModeDialog();
    } else {
      setState(() => _isPatientMode = true);
    }
  }

  void _showExitPatientModeDialog() {
    final passwordController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Salir de Modo Paciente'),
        content: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Contraseña del Evaluador'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              // Simplificado: verificar contra el usuario actual
              final auth = ref.read(authProvider);
              if (auth != null && auth.verifyPassword(passwordController.text)) {
                setState(() => _isPatientMode = false);
                Navigator.pop(ctx);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contraseña incorrecta')));
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleContent(BuildContext context, ModuleProgress progress) {
    final isLocked = !progress.isUnlocked;

    return Column(
      children: [
        // Linear Module Progress Indicator
        if (ref.watch(themeProvider).progressIndicatorStyle == ProgressIndicatorStyle.linearHeader)
          LinearProgressIndicator(value: progress.completionPercentage),
        Expanded(
          child: Stack(
            children: [
              // The actual module view
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: progress.module.buildEvaluationView(
                  context, 
                  isLocked: isLocked,
                  customConfig: progress.customConfig,
                ),
              ),
              
              // Soft Lock Overlay logic
              if (isLocked)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.lock, size: 48, color: Colors.white54),
                        const SizedBox(height: 16),
                        Text(tr('evaluation.soft_locked'), style: const TextStyle(fontSize: 18, color: Colors.white)),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            ref.read(evaluationSessionProvider.notifier).unlockCurrentModule();
                          },
                          icon: const Icon(LucideIcons.unlock),
                          label: Text(tr('evaluation.btn_edit')),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Footer Actions
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: isLocked ? null : () {
                  ref.read(evaluationSessionProvider.notifier).updateCurrentModuleProgress(1.0);
                },
                icon: const Icon(LucideIcons.checkCircle),
                label: Text(tr('evaluation.mark_complete')),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageToggle(BuildContext context, EvaluationSessionState session) {
    final currentModule = session.modules[session.currentModuleIndex].module;
    final available = currentModule.availableLanguages;
    
    // Only show if the module has more than one language
    if (available.length <= 1) return const SizedBox.shrink();

    return TextButton(
      onPressed: () {
        final currentIso1 = context.locale.languageCode;
        final nextIso1 = currentIso1 == 'es' ? 'en' : 'es';
        
        // Map to ISO 639-3
        final nextIso3 = nextIso1 == 'es' ? 'spa' : 'eng';

        if (available.contains(nextIso3)) {
          context.setLocale(nextIso1 == 'es' ? const Locale('es', 'ES') : const Locale('en', 'US'));
        }
      },
      child: Text(
        context.locale.languageCode.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
