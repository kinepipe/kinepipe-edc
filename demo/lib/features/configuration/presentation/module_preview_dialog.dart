import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../modules/core/module_flow_models.dart';
import '../../../modules/module_registry.dart';
import '../../../core/providers/module_manager_provider.dart';

class ModulePreviewDialog extends ConsumerWidget {
  final AvailableModule moduleMetadata;

  const ModulePreviewDialog({super.key, required this.moduleMetadata});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final registry = ref.watch(moduleRegistryProvider);

    // Intentamos encontrar la instancia real si está instalada
    final realModule = moduleMetadata.isInstalled
        ? registry.firstWhere((m) => m.id == moduleMetadata.id, orElse: () => null as dynamic)
        : null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 700,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera Premium
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Icon(moduleMetadata.icon, size: 28, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moduleMetadata.name,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'por ${moduleMetadata.author} • v${moduleMetadata.version}',
                        style: TextStyle(color: theme.colorScheme.primary, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(LucideIcons.x),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const Divider(height: 32),

            // Contenido dinámico (Preview Real vs Preview Bloqueado)
            Expanded(
              child: realModule != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.green.withOpacity(0.3)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(LucideIcons.checkCircle2, size: 14, color: Colors.green),
                              SizedBox(width: 6),
                              Text(
                                'MODO VISTA PREVIA ACTIVO (Interactiva)',
                                style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Card(
                            elevation: 0,
                            color: theme.colorScheme.surface.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(color: theme.dividerColor.withOpacity(0.3)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.all(16),
                                child: realModule.buildEvaluationView(
                                  context,
                                  isLocked: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : _buildLockedPreview(context, theme, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedPreview(BuildContext context, ThemeData theme, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(LucideIcons.downloadCloud, size: 80, color: Colors.grey),
        const SizedBox(height: 24),
        const Text(
          'Vista Previa no disponible',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.0),
          child: Text(
            'Descarga e instala este módulo clínico desde el marketplace para desbloquear su vista previa totalmente interactiva.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {
            ref.read(moduleManagerProvider.notifier).installModule(moduleMetadata.id);
            Navigator.pop(context); // Cerrar y permitir recarga
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Módulo "${moduleMetadata.name}" instalado con éxito.'),
                backgroundColor: Colors.green,
              ),
            );
          },
          icon: const Icon(LucideIcons.downloadCloud),
          label: const Text('Descargar e Instalar Ahora'),
        ),
      ],
    );
  }
}
