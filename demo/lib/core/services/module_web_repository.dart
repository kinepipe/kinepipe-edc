import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../modules/core/module_flow_models.dart';

class ModuleWebRepository {
  /// Simula una llamada a la nube (Supabase/API) para obtener el catálogo
  Future<List<AvailableModule>> fetchAvailableModules() async {
    // Simulamos un retraso de red
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      AvailableModule(
        id: 'personal_data',
        name: 'Ficha del Paciente',
        description: 'Módulo base de información demográfica y hash de identidad.',
        icon: LucideIcons.userCircle,
        version: '1.0.0',
        tags: ['ingreso', 'demografía', 'base'],
        categories: ['Administrativo'],
        author: 'Oficial',
        downloads: 5420,
        rating: 4.9,
      ),
      AvailableModule(
        id: 'vital_signs',
        name: 'Signos Vitales',
        description: 'Evaluación rápida de FC, PA, Saturación y Temperatura.',
        icon: LucideIcons.activity,
        version: '1.1.0',
        tags: ['signos', 'clínico', 'fisiología'],
        categories: ['Clínico', 'Fisiología'],
        author: 'Oficial',
        downloads: 4890,
        rating: 4.8,
      ),
      AvailableModule(
        id: 'parq',
        name: 'PAR-Q Advanced',
        description: 'Cuestionario de Aptitud Física con reglas condicionales automáticas.',
        icon: LucideIcons.clipboardCheck,
        version: '2.0.0',
        tags: ['cuestionario', 'screening', 'deporte'],
        categories: ['Cuestionarios', 'Deportivo'],
        author: 'Oficial',
        downloads: 3200,
        rating: 4.7,
      ),
      AvailableModule(
        id: 'rapa',
        name: 'RAPA (Rapid Assessment)',
        description: 'Cuestionario RAPA para medir nivel de actividad aeróbica, fuerza y flexibilidad.',
        icon: LucideIcons.activity,
        version: '1.0.0',
        tags: ['rapa', 'actividad física', 'cuestionario', 'screening'],
        categories: ['Cuestionarios', 'Clínico'],
        author: 'Oficial',
        downloads: 1250,
        rating: 4.9,
      ),
      AvailableModule(
        id: 'informed_consent',
        name: 'Consentimiento Informado',
        description: 'Motor de validación legal dinámica con soporte Markdown y firma.',
        icon: LucideIcons.fileSignature,
        version: '1.0.0',
        tags: ['legal', 'consentimiento', 'firma'],
        categories: ['Administrativo', 'Legal'],
        author: 'Oficial',
        downloads: 2100,
        rating: 4.6,
      ),
      AvailableModule(
        id: 'biometrics',
        name: 'Reconocimiento Biométrico',
        description: 'Seguridad biométrica (huella/facial) de la identidad del participante.',
        icon: LucideIcons.fingerprint,
        version: '0.9.0',
        tags: ['seguridad', 'identidad', 'biometría'],
        categories: ['Seguridad', 'Administrativo'],
        author: 'Experimental',
        downloads: 890,
        rating: 4.2,
      ),
      AvailableModule(
        id: 'ipaq',
        name: 'IPAQ Corto',
        description: 'Cuestionario Internacional de Actividad Física (Versión Corta).',
        icon: LucideIcons.fileText,
        version: '1.0.1',
        tags: ['ipaq', 'cuestionario', 'actividad'],
        categories: ['Cuestionarios', 'Investigación'],
        author: 'Comunidad',
        downloads: 450,
        rating: 4.5,
      ),
    ];
  }
}

final moduleWebRepositoryProvider = Provider((ref) => ModuleWebRepository());
