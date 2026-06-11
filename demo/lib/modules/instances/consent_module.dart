import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../module_registry.dart';
import '../core/module_enums.dart';
import '../core/consent_config.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:signature/signature.dart';

class ConsentModule extends ResearchModule {
  @override
  String get id => 'informed_consent';

  @override
  String get name => 'Consentimiento Informado';

  @override
  String get description => 'Validación legal con firma, biometría y soporte documental.';

  @override
  IconData get icon => LucideIcons.fileSignature;

  @override
  UpdateFrequency get updateFrequency => UpdateFrequency.dynamic;

  @override
  Future<void> printToPdf(BuildContext context) async {
    // Implementar generación de PDF del consentimiento firmado
  }

  @override
  Widget buildEvaluationView(BuildContext context, {required bool isLocked, Map<String, dynamic>? customConfig}) {
    final config = customConfig != null ? ConsentConfig.fromJson(customConfig) : ConsentConfig();
    return ConsentEvaluationView(config: config, isLocked: isLocked);
  }
}

class ConsentEvaluationView extends StatefulWidget {
  final ConsentConfig config;
  final bool isLocked;

  const ConsentEvaluationView({super.key, required this.config, required this.isLocked});

  @override
  State<ConsentEvaluationView> createState() => _ConsentEvaluationViewState();
}

class _ConsentEvaluationViewState extends State<ConsentEvaluationView> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  bool _isDocumentScrolledToBottom = false;
  bool _biometricValidated = false;
  bool _ssoValidated = false;
  bool _photoTaken = false;

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Encabezado Informativo según el grupo
        if (widget.config.isForMinors)
          _buildAlertBanner(
            'Consentimiento para Menores de Edad',
            'Este documento debe ser firmado por el padre, madre o tutor legal.',
            Colors.orange,
          ),
        if (widget.config.isForCognitiveDisability)
          _buildAlertBanner(
            'Apoyo Cognitivo Requerido',
            'Se recomienda la lectura asistida y presencia de un testigo.',
            Colors.blue,
          ),
          
        const SizedBox(height: 16),
        
        // Visor de Documento
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: theme.dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >= notification.metrics.maxScrollExtent - 50) {
                  if (!_isDocumentScrolledToBottom) {
                    setState(() => _isDocumentScrolledToBottom = true);
                  }
                }
                return false;
              },
              child: Markdown(
                data: widget.config.documentContent ?? _defaultConsentText(),
                styleSheet: MarkdownStyleSheet(
                  p: theme.textTheme.bodyLarge,
                  h1: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Herramientas de Validación
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            if (widget.config.requireSignature)
              _buildValidationCard(
                'Firma Digital',
                LucideIcons.penTool,
                _signatureController.isNotEmpty,
                () => _showSignatureDialog(context),
              ),
            if (widget.config.requirePhoto)
              _buildValidationCard(
                'Fotografía de Respaldo',
                LucideIcons.camera,
                _photoTaken,
                () => setState(() => _photoTaken = true), // Simulado
              ),
            if (widget.config.requireBiometrics)
              _buildValidationCard(
                'Identidad Biométrica',
                LucideIcons.fingerprint,
                _biometricValidated,
                () => _simulateBiometrics(),
              ),
            if (widget.config.requireSSOConfirmation)
              _buildValidationCard(
                'Confirmación SSO',
                LucideIcons.shieldCheck,
                _ssoValidated,
                () => _simulateSSO(),
              ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Footer de Validación
        if (!_isDocumentScrolledToBottom)
          const Center(
            child: Text(
              'Por favor, lea el documento hasta el final para habilitar la firma.',
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }

  Widget _buildAlertBanner(String title, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.info, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
                Text(sub, style: TextStyle(color: color.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationCard(String label, IconData icon, bool completed, VoidCallback onTap) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: widget.isLocked ? null : onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: completed ? Colors.green : theme.dividerColor),
          borderRadius: BorderRadius.circular(12),
          color: completed ? Colors.green.withOpacity(0.05) : null,
        ),
        child: Column(
          children: [
            Icon(completed ? LucideIcons.checkCircle2 : icon, color: completed ? Colors.green : null),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showSignatureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Firme aquí'),
        content: Container(
          width: 500,
          height: 300,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Signature(
            controller: _signatureController,
            backgroundColor: Colors.white,
          ),
        ),
        actions: [
          TextButton(onPressed: () => _signatureController.clear(), child: const Text('Limpiar')),
          FilledButton(onPressed: () {
            setState(() {});
            Navigator.pop(context);
          }, child: const Text('Guardar Firma')),
        ],
      ),
    );
  }

  void _simulateBiometrics() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invocando sensor biométrico...')));
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _biometricValidated = true);
    });
  }

  void _simulateSSO() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Re-autenticando con Google/Office...')));
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _ssoValidated = true);
    });
  }

  String _defaultConsentText() {
    return '''
# Consentimiento Informado para Participación en Investigación

Yo, reconozco que he sido informado sobre los objetivos de este estudio. 

## 1. Naturaleza del Estudio
Se me ha explicado que mi participación consiste en evaluaciones clínicas y de rendimiento físico.

## 2. Voluntariedad
Entiendo que mi participación es completamente voluntaria y que puedo retirarme en cualquier momento sin dar explicaciones.

## 3. Confidencialidad
Todos mis datos serán tratados de forma anónima mediante un identificador único (Hash de Identidad).

---
Al firmar este documento, doy mi consentimiento libre y espontáneo para participar.
''';
  }
}
