import 'dart:convert';
import 'package:crypto/crypto.dart';

enum UserRole {
  investigator,
  clinician,
  user,
  admin
}

enum PermissionType {
  createModule,
  editModule,
  viewPatients,
  viewEvaluations,
  editEvaluations,
  addObservations
}

/// Helper extension para centralizar los nombres legibles
extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.investigator: return 'Investigador';
      case UserRole.clinician: return 'Clínico';
      case UserRole.user: return 'Usuario';
      case UserRole.admin: return 'Administrador';
    }
  }
}

class AppUser {
  final String id;
  final String name;
  final UserRole role;
  final String passwordHash;

  AppUser({
    required this.id,
    required this.name,
    required this.role,
    required this.passwordHash,
  });

  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  bool verifyPassword(String password) {
    return passwordHash == hashPassword(password);
  }

  AppUser copyWith({
    String? id,
    String? name,
    UserRole? role,
    String? passwordHash,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      passwordHash: passwordHash ?? this.passwordHash,
    );
  }
}
