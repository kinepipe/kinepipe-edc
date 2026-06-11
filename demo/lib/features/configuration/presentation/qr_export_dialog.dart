import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../modules/core/module_flow_models.dart';

class QrExportDialog extends StatelessWidget {
  final EvaluationRoute route;

  const QrExportDialog({super.key, required this.route});

  String _generatePayload() {
    final jsonStr = jsonEncode(route.toJson());
    // Convert to base64 to ensure it's a safe string for QR
    final bytes = utf8.encode(jsonStr);
    final base64Str = base64Encode(bytes);
    return 'kinepipe://route?payload=$base64Str';
  }

  @override
  Widget build(BuildContext context) {
    final payload = _generatePayload();

    return AlertDialog(
      title: const Row(
        children: [
          Icon(LucideIcons.qrCode, color: Colors.blueAccent),
          SizedBox(width: 12),
          Text('Exportar Ruta'),
        ],
      ),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Escanea este código desde la aplicación móvil para importar la configuración de esta ruta.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: QrImageView(
                data: payload,
                version: QrVersions.auto,
                size: 250.0,
                errorCorrectionLevel: QrErrorCorrectLevel.L,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ruta: ${route.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${route.steps.length} módulos',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        )
      ],
    );
  }
}
