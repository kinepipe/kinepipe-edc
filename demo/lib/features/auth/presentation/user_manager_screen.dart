import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/auth/auth_models.dart';
import '../../../core/providers/user_management_provider.dart';
import '../../../core/providers/auth_provider.dart';

class UserManagerScreen extends ConsumerStatefulWidget {
  const UserManagerScreen({super.key});

  @override
  ConsumerState<UserManagerScreen> createState() => _UserManagerScreenState();
}

class _UserManagerScreenState extends ConsumerState<UserManagerScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.investigator;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAddUser() {
    if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Llene todos los campos')));
      return;
    }
    
    ref.read(userManagementProvider.notifier).addUser(
      _nameController.text,
      _selectedRole,
      _passwordController.text,
    );
    
    _nameController.clear();
    _passwordController.clear();
    setState(() => _selectedRole = UserRole.investigator);
  }

  void _handleEditUser(AppUser user) {
    _nameController.text = user.name;
    _selectedRole = user.role;
    _passwordController.clear(); // Por seguridad no mostramos el hash

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Editar Usuario: ${user.name}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre Completo', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<UserRole>(
              decoration: const InputDecoration(labelText: 'Rol', border: OutlineInputBorder()),
              value: _selectedRole,
              items: UserRole.values.map((r) => DropdownMenuItem(
                value: r,
                child: Text(r.displayName),
              )).toList(),
              onChanged: (val) => setState(() => _selectedRole = val!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Nueva Contraseña (opcional)', border: OutlineInputBorder()),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          ElevatedButton(
            onPressed: () {
              // Actualizar datos
              if (_nameController.text.isNotEmpty) {
                ref.read(userManagementProvider.notifier).updateUserName(user.id, _nameController.text);
                ref.read(userManagementProvider.notifier).updateUserRole(user.id, _selectedRole);
                if (_passwordController.text.isNotEmpty) {
                  ref.read(userManagementProvider.notifier).updateUserPassword(user.id, _passwordController.text);
                }
                Navigator.pop(ctx);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authUser = ref.watch(authProvider);
    final usersState = ref.watch(userManagementProvider);
    final theme = Theme.of(context);

    if (authUser?.role != UserRole.admin) {
      return const Scaffold(body: Center(child: Text('Acceso Denegado')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios y Roles'),
      ),
      body: Row(
        children: [
          // Panel Izquierdo: Formulario de Creación y GUÍA DE PERMISOS
          Expanded(
            flex: 1,
            child: Container(
              color: theme.colorScheme.surface,
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nuevo Miembro del Staff', style: theme.textTheme.titleLarge),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nombre Completo', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<UserRole>(
                      decoration: const InputDecoration(labelText: 'Rol', border: OutlineInputBorder()),
                      value: _selectedRole,
                      items: UserRole.values.map((r) => DropdownMenuItem(
                        value: r,
                        child: Text(r.displayName),
                      )).toList(),
                      onChanged: (val) => setState(() => _selectedRole = val!),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: 'Contraseña Temporal', border: OutlineInputBorder()),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton.icon(
                        icon: const Icon(LucideIcons.userPlus),
                        label: const Text('Crear Usuario'),
                        onPressed: _handleAddUser,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text('Guía de Permisos', style: theme.textTheme.titleMedium),
                    const SizedBox(height: 16),
                    _buildPermissionGuide(theme),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          // Panel Derecho: Lista de Usuarios
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: usersState.users.length,
              itemBuilder: (context, index) {
                final user = usersState.users[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primaryContainer,
                      child: Icon(LucideIcons.user, color: theme.colorScheme.onPrimaryContainer),
                    ),
                    title: Text(user.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rol: ${user.role.displayName}'),
                        const SizedBox(height: 4),
                        _buildUserPermissionIcons(user.role),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(LucideIcons.edit2, color: Colors.blue),
                          onPressed: () => _handleEditUser(user),
                        ),
                        if (user.id != authUser?.id)
                          IconButton(
                            icon: const Icon(LucideIcons.trash2, color: Colors.red),
                            onPressed: () {
                              ref.read(userManagementProvider.notifier).deleteUser(user.id);
                            },
                          )
                        else
                          const Chip(label: Text('Tú')),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionGuide(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
        },
        border: TableBorder.symmetric(inside: BorderSide(color: theme.colorScheme.outlineVariant, width: 0.5)),
        children: [
          // Header
          TableRow(
            decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withOpacity(0.2)),
            children: [
              _tableHeader('Rol'),
              _tableHeaderIcon(LucideIcons.plusCircle, 'Módulos'),
              _tableHeaderIcon(LucideIcons.users, 'Pacientes'),
              _tableHeaderIcon(LucideIcons.clipboardCheck, 'Eval.'),
              _tableHeaderIcon(LucideIcons.messageSquare, 'Obs.'),
            ],
          ),
          // Rows for each Role
          _rolePermissionRow(UserRole.investigator, [true, true, false, false]),
          _rolePermissionRow(UserRole.clinician, [false, true, true, true]),
          _rolePermissionRow(UserRole.user, [false, true, true, false]),
          _rolePermissionRow(UserRole.admin, [true, true, true, true]),
        ],
      ),
    );
  }

  Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _tableHeaderIcon(IconData icon, String tooltip) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: tooltip,
        child: Icon(icon, size: 16),
      ),
    );
  }

  TableRow _rolePermissionRow(UserRole role, List<bool> permissions) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(role.displayName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ),
        ...permissions.map((p) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            p ? LucideIcons.checkCircle2 : LucideIcons.xCircle,
            size: 14,
            color: p ? Colors.greenAccent : Colors.redAccent.withOpacity(0.3),
          ),
        )),
      ],
    );
  }

  Widget _buildUserPermissionIcons(UserRole role) {
    List<IconData> icons = [];
    if (role == UserRole.admin || role == UserRole.investigator) icons.add(LucideIcons.plusCircle);
    icons.add(LucideIcons.users);
    if (role != UserRole.investigator) icons.add(LucideIcons.clipboardCheck);
    if (role == UserRole.admin || role == UserRole.clinician) icons.add(LucideIcons.messageSquare);

    return Wrap(
      spacing: 4,
      children: icons.map((icon) => Icon(icon, size: 14, color: Colors.grey[400])).toList(),
    );
  }
}
