import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_models.dart';

/// Mapa de permisos estricto según especificación
const Map<UserRole, List<PermissionType>> _rolePermissions = {
  UserRole.investigator: [
    PermissionType.createModule,
    PermissionType.editModule,
    PermissionType.viewPatients,
    PermissionType.viewEvaluations,
  ],
  UserRole.clinician: [
    PermissionType.viewPatients,
    PermissionType.viewEvaluations,
    PermissionType.editEvaluations,
    PermissionType.addObservations,
  ],
  UserRole.user: [
    PermissionType.viewPatients,
    PermissionType.viewEvaluations,
    PermissionType.editEvaluations,
  ],
  UserRole.admin: [
    PermissionType.createModule,
    PermissionType.editModule,
    PermissionType.viewPatients,
    PermissionType.viewEvaluations,
    PermissionType.editEvaluations,
    PermissionType.addObservations,
  ],
};

class AuthNotifier extends Notifier<AppUser?> {
  @override
  AppUser? build() {
    // Retorna null cuando no hay sesión activa
    return null;
  }

  void login(AppUser user) {
    state = user;
  }

  void logout() {
    state = null;
  }

  bool hasPermission(PermissionType permission) {
    if (state == null) return false;
    final permissions = _rolePermissions[state!.role] ?? [];
    return permissions.contains(permission);
  }
}

final authProvider = NotifierProvider<AuthNotifier, AppUser?>(AuthNotifier.new);
