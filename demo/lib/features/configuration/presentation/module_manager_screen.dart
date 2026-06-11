import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/providers/module_manager_provider.dart';
import '../../../modules/core/module_flow_models.dart';
import 'flow_builder_screen.dart';
import 'module_preview_dialog.dart';

class ModuleManagerScreen extends ConsumerStatefulWidget {
  const ModuleManagerScreen({super.key});

  @override
  ConsumerState<ModuleManagerScreen> createState() => _ModuleManagerScreenState();
}

class _ModuleManagerScreenState extends ConsumerState<ModuleManagerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de Módulos y Rutas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(LucideIcons.store), text: 'Marketplace & Módulos'),
            Tab(icon: Icon(LucideIcons.gitMerge), text: 'Rutas de Evaluación'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildModulesTab(context, theme),
          _buildRoutesTab(context, theme),
        ],
      ),
    );
  }

  Widget _buildModulesTab(BuildContext context, ThemeData theme) {
    final state = ref.watch(moduleManagerProvider);
    
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final modules = state.filteredMarketplaceModules;
    
    // Categorías disponibles fijas para el filtro
    final categories = ['Todos', 'Clínico', 'Cuestionarios', 'Administrativo', 'Fisiología', 'Deportivo', 'Investigación'];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar módulos (ej. RAPA, clínico...)',
              prefixIcon: const Icon(LucideIcons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: theme.colorScheme.surface,
            ),
            onChanged: (val) => ref.read(moduleManagerProvider.notifier).setSearchQuery(val),
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              final isSelected = state.selectedCategory == cat || (state.selectedCategory == null && cat == 'Todos');
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  label: Text(cat),
                  selected: isSelected,
                  onSelected: (selected) {
                    ref.read(moduleManagerProvider.notifier).setCategory(cat == 'Todos' ? null : cat);
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: modules.length,
            itemBuilder: (context, index) {
              final module = modules[index];
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: theme.dividerColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                            child: Icon(module.icon, color: theme.colorScheme.primary),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(module.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                                    Row(
                                      children: [
                                        const Icon(LucideIcons.download, size: 14, color: Colors.grey),
                                        const SizedBox(width: 4),
                                        Text('${module.downloads}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                        const SizedBox(width: 12),
                                        const Icon(LucideIcons.star, size: 14, color: Colors.orange),
                                        const SizedBox(width: 4),
                                        Text('${module.rating}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text('por ${module.author}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.primary)),
                                const SizedBox(height: 8),
                                Text(module.description),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 8,
                              children: module.tags.map((tag) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: theme.dividerColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text('#$tag', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                              )).toList(),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => ModulePreviewDialog(moduleMetadata: module),
                              );
                            },
                            icon: const Icon(LucideIcons.eye, size: 16),
                            label: const Text('Vista Previa'),
                          ),
                          const SizedBox(width: 8),
                          _buildModuleTrailing(module),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModuleTrailing(AvailableModule module) {
    if (!module.isInstalled) {
      return ElevatedButton.icon(
        onPressed: () {
          ref.read(moduleManagerProvider.notifier).installModule(module.id);
        },
        icon: const Icon(LucideIcons.downloadCloud, size: 16),
        label: const Text('Instalar'),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(LucideIcons.trash2, size: 18, color: Colors.red),
          tooltip: 'Desinstalar',
          onPressed: () => ref.read(moduleManagerProvider.notifier).uninstallModule(module.id),
        ),
        const SizedBox(width: 8),
        Text(module.isEnabled ? 'Activo' : 'Inactivo', style: const TextStyle(fontSize: 12)),
        Switch(
          value: module.isEnabled,
          onChanged: (val) {
            ref.read(moduleManagerProvider.notifier).toggleModuleEnabled(module.id, val);
          },
        ),
      ],
    );
  }

  Widget _buildRoutesTab(BuildContext context, ThemeData theme) {
    final state = ref.watch(moduleManagerProvider);
    final routes = state.routes;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FlowBuilderScreen()),
              );
            },
            icon: const Icon(LucideIcons.plus),
            label: const Text('Crear Nueva Ruta'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              final isActive = state.activeRouteId == route.id || (state.activeRouteId == null && index == 0);
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isActive ? theme.colorScheme.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    ref.read(moduleManagerProvider.notifier).setActiveRoute(route.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ruta "${route.name}" seleccionada como activa.'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  leading: Icon(
                    isActive ? LucideIcons.checkCircle2 : LucideIcons.circle,
                    color: isActive ? theme.colorScheme.primary : Colors.grey,
                  ),
                  title: Text(route.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(route.description.isEmpty ? '${route.steps.length} módulos en flujo' : route.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(LucideIcons.edit2, size: 20),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => FlowBuilderScreen(routeToEdit: route)),
                          );
                        },
                      ),
                      if (index != 0) // Prevent deleting default route
                        IconButton(
                          icon: const Icon(LucideIcons.trash2, size: 20, color: Colors.red),
                          onPressed: () {
                            ref.read(moduleManagerProvider.notifier).deleteRoute(route.id);
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
