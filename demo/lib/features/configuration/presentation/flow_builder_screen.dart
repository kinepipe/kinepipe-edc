import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/providers/module_manager_provider.dart';
import '../../../modules/core/module_flow_models.dart';
import '../../../modules/core/consent_config.dart';

import 'qr_export_dialog.dart';

class FlowBuilderScreen extends ConsumerStatefulWidget {
  final EvaluationRoute? routeToEdit;

  const FlowBuilderScreen({super.key, this.routeToEdit});

  @override
  ConsumerState<FlowBuilderScreen> createState() => _FlowBuilderScreenState();
}

class _FlowBuilderScreenState extends ConsumerState<FlowBuilderScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  List<ModuleStep> _currentSteps = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.routeToEdit?.name ?? '');
    _descController = TextEditingController(text: widget.routeToEdit?.description ?? '');
    _currentSteps = widget.routeToEdit != null ? List.from(widget.routeToEdit!.steps) : [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveRoute() {
    if (_nameController.text.isEmpty || _currentSteps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La ruta debe tener un nombre y al menos un módulo.')),
      );
      return;
    }

    final newRoute = EvaluationRoute(
      id: widget.routeToEdit?.id,
      name: _nameController.text,
      description: _descController.text,
      steps: _currentSteps,
    );

    ref.read(moduleManagerProvider.notifier).createOrUpdateRoute(newRoute);
    Navigator.pop(context);
  }

  void _showQrDialog() {
    if (_nameController.text.isEmpty || _currentSteps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debes definir un nombre y agregar módulos antes de exportar.')),
      );
      return;
    }

    final tempRoute = EvaluationRoute(
      id: widget.routeToEdit?.id,
      name: _nameController.text,
      description: _descController.text,
      steps: _currentSteps,
    );

    showDialog(
      context: context,
      builder: (_) => QrExportDialog(route: tempRoute),
    );
  }

  void _showModuleConfigDialog(ModuleStep step, int index) {
    if (step.moduleId == 'informed_consent') {
      _showConsentConfigDialog(step, index);
    } else {
      _showPermissionModal(step, index);
    }
  }

  void _showConsentConfigDialog(ModuleStep step, int index) {
    ConsentConfig config = step.customConfig != null 
        ? ConsentConfig.fromJson(step.customConfig!) 
        : ConsentConfig();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => AlertDialog(
          title: const Row(
            children: [
              Icon(LucideIcons.fileSignature, color: Colors.blue),
              SizedBox(width: 12),
              Text('Configurar Consentimiento'),
            ],
          ),
          content: SizedBox(
            width: 500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Grupos de Población Especial', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(),
                  _buildToggle(setModalState, 'Menores de Edad', config.isForMinors, (v) => config = config.copyWith(isForMinors: v)),
                  _buildToggle(setModalState, 'Adultos Mayores', config.isForElderly, (v) => config = config.copyWith(isForElderly: v)),
                  _buildToggle(setModalState, 'Discapacidad Cognitiva', config.isForCognitiveDisability, (v) => config = config.copyWith(isForCognitiveDisability: v)),
                  _buildToggle(setModalState, 'Discapacidad Visual', config.isForVisualDisability, (v) => config = config.copyWith(isForVisualDisability: v)),
                  _buildToggle(setModalState, 'Discapacidad Auditiva', config.isForHearingDisability, (v) => config = config.copyWith(isForHearingDisability: v)),
                  _buildToggle(setModalState, 'Discapacidad Motora', config.isForMotorDisability, (v) => config = config.copyWith(isForMotorDisability: v)),
                  _buildToggle(setModalState, 'Discapacidad Psiquiátrica', config.isForPsychiatricDisability, (v) => config = config.copyWith(isForPsychiatricDisability: v)),
                  
                  const SizedBox(height: 24),
                  const Text('Requisitos de Validación', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(),
                  _buildToggle(setModalState, 'Requerir Firma Digital', config.requireSignature, (v) => config = config.copyWith(requireSignature: v)),
                  _buildToggle(setModalState, 'Requerir Fotografía', config.requirePhoto, (v) => config = config.copyWith(requirePhoto: v)),
                  _buildToggle(setModalState, 'Requerir Grabación Audio', config.requireAudio, (v) => config = config.copyWith(requireAudio: v)),
                  _buildToggle(setModalState, 'Requerir Biometría', config.requireBiometrics, (v) => config = config.copyWith(requireBiometrics: v)),
                  _buildToggle(setModalState, 'Confirmación SSO (Identidad)', config.requireSSOConfirmation, (v) => config = config.copyWith(requireSSOConfirmation: v)),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () {
                setState(() {
                  _currentSteps[index] = _currentSteps[index].copyWith(customConfig: config.toJson());
                });
                Navigator.pop(context);
              }, 
              child: const Text('Guardar Configuración'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(StateSetter setModalState, String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(fontSize: 14)),
      value: value,
      onChanged: (v) {
        setModalState(() => onChanged(v));
      },
    );
  }

  void _showPermissionModal(ModuleStep step, int index) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Permiso Excepcional (Override)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('99% del tiempo debes usar "Según Rol". Solo cambia esto si este flujo exige un comportamiento especial.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(LucideIcons.shield),
                title: const Text('Según Rol de Usuario (Por Defecto)'),
                onTap: () => _updateStepPermission(index, ModulePermissionOverride.none),
                selected: step.permissionOverride == ModulePermissionOverride.none,
              ),
              ListTile(
                leading: const Icon(LucideIcons.eye),
                title: const Text('Forzar Solo Lectura'),
                onTap: () => _updateStepPermission(index, ModulePermissionOverride.readOnly),
                selected: step.permissionOverride == ModulePermissionOverride.readOnly,
              ),
              ListTile(
                leading: const Icon(LucideIcons.edit3),
                title: const Text('Forzar Modo Edición'),
                onTap: () => _updateStepPermission(index, ModulePermissionOverride.editable),
                selected: step.permissionOverride == ModulePermissionOverride.editable,
              ),
              ListTile(
                leading: const Icon(LucideIcons.messageSquare),
                title: const Text('Forzar Modo Sugerencias'),
                onTap: () => _updateStepPermission(index, ModulePermissionOverride.suggestion),
                selected: step.permissionOverride == ModulePermissionOverride.suggestion,
              ),
            ],
          ),
        );
      }
    );
  }

  void _updateStepPermission(int index, ModulePermissionOverride override) {
    setState(() {
      _currentSteps[index] = _currentSteps[index].copyWith(permissionOverride: override);
    });
    Navigator.pop(context);
  }

  String _getPermissionLabel(ModulePermissionOverride override) {
    switch (override) {
      case ModulePermissionOverride.none: return 'Rol';
      case ModulePermissionOverride.readOnly: return 'Lectura';
      case ModulePermissionOverride.editable: return 'Editable';
      case ModulePermissionOverride.suggestion: return 'Sugerencia';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(moduleManagerProvider);
    final enabledModules = state.enabledModules;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.routeToEdit == null ? 'Nueva Ruta' : 'Editar Ruta'),
        actions: [
          TextButton.icon(
            onPressed: _showQrDialog,
            icon: const Icon(LucideIcons.qrCode, color: Colors.blueAccent),
            label: const Text('Exportar QR', style: TextStyle(color: Colors.blueAccent)),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: _saveRoute,
            icon: const Icon(LucideIcons.save, color: Colors.white),
            label: const Text('Guardar', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Left Panel: Available Enabled Modules to Add
          Container(
            width: 300,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: theme.dividerColor)),
              color: theme.scaffoldBackgroundColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Módulos Activos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: enabledModules.length,
                    itemBuilder: (context, index) {
                      final module = enabledModules[index];
                      return ListTile(
                        leading: Icon(module.icon, color: theme.colorScheme.primary),
                        title: Text(module.name),
                        trailing: IconButton(
                          icon: const Icon(LucideIcons.plusCircle),
                          onPressed: () {
                            setState(() {
                              _currentSteps.add(ModuleStep(moduleId: module.id));
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Right Panel: Flow Builder
          Expanded(
            child: Container(
              color: theme.cardColor.withOpacity(0.5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre de la Ruta',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _descController,
                            decoration: const InputDecoration(
                              labelText: 'Descripción corta',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Secuencia de Evaluación (Arrastra para reordenar)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                  ),
                  Expanded(
                    child: _currentSteps.isEmpty
                      ? const Center(child: Text('Usa el botón (+) a la izquierda para añadir módulos a esta ruta.', style: TextStyle(color: Colors.grey)))
                      : ReorderableListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          itemCount: _currentSteps.length,
                          onReorder: (oldIndex, newIndex) {
                            setState(() {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final item = _currentSteps.removeAt(oldIndex);
                              _currentSteps.insert(newIndex, item);
                            });
                          },
                          itemBuilder: (context, index) {
                            final step = _currentSteps[index];
                            final moduleInfo = enabledModules.firstWhere(
                              (m) => m.id == step.moduleId,
                              orElse: () => AvailableModule(id: 'unknown', name: 'Módulo Desconocido', description: '', icon: LucideIcons.helpCircle, version: ''),
                            );

                            return Card(
                              key: ValueKey(step.id), // Must use unique key for ReorderableListView
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 2,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: theme.colorScheme.primary,
                                  child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                                title: Text(moduleInfo.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Row(
                                  children: [
                                    const Icon(LucideIcons.lock, size: 14, color: Colors.grey),
                                    const SizedBox(width: 4),
                                    Text('Permiso: ${_getPermissionLabel(step.permissionOverride)}', style: const TextStyle(color: Colors.grey)),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (step.customConfig != null)
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8.0),
                                        child: Icon(LucideIcons.checkCircle, color: Colors.green, size: 16),
                                      ),
                                    IconButton(
                                      icon: Icon(
                                        step.moduleId == 'informed_consent' 
                                          ? LucideIcons.settings2 
                                          : LucideIcons.settings,
                                        color: step.moduleId == 'informed_consent' ? theme.colorScheme.primary : null,
                                      ),
                                      tooltip: 'Configurar Módulo',
                                      onPressed: () => _showModuleConfigDialog(step, index),
                                    ),
                                    IconButton(
                                      icon: const Icon(LucideIcons.xCircle, color: Colors.red),
                                      tooltip: 'Quitar Módulo',
                                      onPressed: () {
                                        setState(() {
                                          _currentSteps.removeAt(index);
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(LucideIcons.gripVertical, color: Colors.grey),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
