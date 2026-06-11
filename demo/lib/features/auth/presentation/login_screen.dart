import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/utils/glassmorphism.dart';
import '../../../core/auth/auth_models.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/user_management_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _passwordController = TextEditingController();
  AppUser? _selectedUser;
  bool _obscureText = true;
  String? _errorMessage;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_selectedUser == null) {
      setState(() => _errorMessage = 'Seleccione un usuario');
      return;
    }

    if (_selectedUser!.verifyPassword(_passwordController.text)) {
      ref.read(authProvider.notifier).login(_selectedUser!);
      context.go('/');
    } else {
      setState(() => _errorMessage = 'Contraseña incorrecta');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final usersState = ref.watch(userManagementProvider);
    final users = usersState.users;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?q=80&w=2070&auto=format&fit=crop'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: GlassContainer(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.activity, size: 64, color: theme.colorScheme.primary),
                      const SizedBox(height: 16),
                      Text(
                        'Research Module',
                        style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Identifíquese para continuar',
                        style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 40),
                      
                      // SSO Placeholders
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(LucideIcons.mail),
                          label: const Text('Iniciar sesión con Google'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('SSO integration pending'))
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(LucideIcons.building),
                          label: const Text('Iniciar sesión con Microsoft'),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('SSO integration pending'))
                            );
                          },
                        ),
                      ),
  
                      const SizedBox(height: 32),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('O LOGIN LOCAL', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 32),
  
                      DropdownButtonFormField<AppUser>(
                        decoration: const InputDecoration(
                          labelText: 'Usuario',
                          prefixIcon: Icon(LucideIcons.user),
                          border: OutlineInputBorder(),
                        ),
                        value: _selectedUser,
                        items: users.map((u) {
                          return DropdownMenuItem(
                            value: u,
                            child: Text('${u.name} (${u.role.displayName})'),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() {
                            _selectedUser = val;
                            _errorMessage = null;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(LucideIcons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureText ? LucideIcons.eyeOff : LucideIcons.eye),
                            onPressed: () => setState(() => _obscureText = !_obscureText),
                          ),
                        ),
                        onSubmitted: (_) => _handleLogin(),
                      ),
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 16),
                        Text(_errorMessage!, style: TextStyle(color: theme.colorScheme.error)),
                      ],
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: FilledButton(
                          onPressed: _handleLogin,
                          child: const Text('Ingresar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
