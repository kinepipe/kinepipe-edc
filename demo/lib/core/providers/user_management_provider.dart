import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../auth/auth_models.dart';

class UserManagementState {
  final List<AppUser> users;

  UserManagementState({required this.users});
}

class UserManagementNotifier extends Notifier<UserManagementState> {
  @override
  UserManagementState build() {
    // Inyectar un administrador por defecto para evitar bloqueos
    final admin = AppUser(
      id: const Uuid().v4(),
      name: 'Admin Principal',
      role: UserRole.admin,
      passwordHash: AppUser.hashPassword('admin'),
    );

    final investigator = AppUser(
      id: const Uuid().v4(),
      name: 'Dr. Investigador',
      role: UserRole.investigator,
      passwordHash: AppUser.hashPassword('investiga'),
    );

    final clinician = AppUser(
      id: const Uuid().v4(),
      name: 'Lic. Clínico',
      role: UserRole.clinician,
      passwordHash: AppUser.hashPassword('clinico'),
    );

    final standardUser = AppUser(
      id: const Uuid().v4(),
      name: 'Usuario Estándar',
      role: UserRole.user,
      passwordHash: AppUser.hashPassword('user'),
    );

    return UserManagementState(users: [admin, investigator, clinician, standardUser]);
  }

  void addUser(String name, UserRole role, String password) {
    final newUser = AppUser(
      id: const Uuid().v4(),
      name: name,
      role: role,
      passwordHash: AppUser.hashPassword(password),
    );
    state = UserManagementState(users: [...state.users, newUser]);
  }

  void deleteUser(String id) {
    state = UserManagementState(
      users: state.users.where((u) => u.id != id).toList(),
    );
  }

  void updateUserPassword(String id, String newPassword) {
    final newUsers = state.users.map((u) {
      if (u.id == id) {
        return u.copyWith(passwordHash: AppUser.hashPassword(newPassword));
      }
      return u;
    }).toList();
    state = UserManagementState(users: newUsers);
  }

  void updateUserName(String id, String newName) {
    final newUsers = state.users.map((u) {
      if (u.id == id) {
        return u.copyWith(name: newName);
      }
      return u;
    }).toList();
    state = UserManagementState(users: newUsers);
  }

  void updateUserRole(String id, UserRole newRole) {
    final newUsers = state.users.map((u) {
      if (u.id == id) {
        return u.copyWith(role: newRole);
      }
      return u;
    }).toList();
    state = UserManagementState(users: newUsers);
  }
}

final userManagementProvider = NotifierProvider<UserManagementNotifier, UserManagementState>(UserManagementNotifier.new);
