enum UpdateFrequency {
  unique,       // Básicamente único (Ej. ID, Datos demográficos). Bloqueo suave.
  intermediate, // Actualizaciones cada cierto tiempo (Ej. PAR-Q). Alerta antes de nuevo registro.
  dynamic,      // Cada vez que se llega al módulo se hace un nuevo registro (Ej. Telemetría).
}

enum ModuleStatus {
  pending,
  inProgress,
  completed,
}
