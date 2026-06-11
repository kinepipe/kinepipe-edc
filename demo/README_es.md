---
title: "Demo EDC - Demo Integrado en Flutter"
summary: "Este directorio contiene el código fuente para el demo de Demo EDC, un sistema de captura de datos clínicos construido usando Flutter y Riverpod, que muestra evaluaciones modulares, roles de usuario, almacenamiento local offline-first e integración de sensores BLE."
document_type: "technical_documentation"
domain: "digital_health_software_design"
audience: "researchers, software_developers"
intended_use: "methodological_appendix_and_runnable_example"
key_entities: ["Flutter_App", "Modular_Capture", "Role_Based_Auth", "BLE_Sensor"]
version: "1.0"
language: "es"
---

# Demo EDC - Demo Integrado en Flutter

Este directorio contiene el código fuente de **Demo EDC** (nombre en clave *integrador*), un sistema multidispositivo de captura de datos clínicos desarrollado con Flutter. Se incluye en este repositorio como un anexo metodológico interactivo, ejecutable y editable asociado al manuscrito *From Zero to Hero: Methodological Experience in the Iterative Construction of Clinical Data Capture Systems using Agentic AI*.

---

## Stack Tecnológico y Librerías Clave

La aplicación está estructurada para demostrar una arquitectura limpia, gestión de estado reactiva mediante Riverpod y capacidades offline-first. Los paquetes clave declarados en `pubspec.yaml` incluyen:

- **Gestión de Estado**: `flutter_riverpod` (v3.3.1) para el seguimiento reactivo y modular del estado.
- **Rutas y Navegación**: `go_router` (v17.2.3) para navegación declarativa y enlaces profundos.
- **Diseño y UI**: `flex_color_scheme` (v8.4.0) para temas visuales armonizados, `lucide_icons` (v0.257.0) para iconos de la interfaz, y `flutter_animate` (v4.5.2) para micro-animaciones fluidas.
- **Localización**: `easy_localization` (v3.0.7) para la gestión de traducciones e idiomas.
- **Persistencia y Exportación PDF**: `shared_preferences` para caché rápido de sesión, `pdf` (v3.12.0) y `printing` (v5.14.3) para la generación de reportes clínicos en PDF de calidad profesional.
- **Seguridad y Multimedia**: `local_auth` (v3.0.1) para biometría local, `file_picker` (v9.0.2) para archivos adjuntos, y `mobile_scanner`/`qr_flutter` para sincronización de perfiles mediante códigos QR.

---

## Credenciales de Acceso Predefinidas

La aplicación utiliza un sistema de control de acceso basado en roles (RBAC) local para simular los flujos de trabajo de un equipo de investigación. Puedes ingresar seleccionando cualquiera de los siguientes usuarios precargados en la pantalla de inicio:

| Usuario Seleccionado | Rol / Nivel de Acceso | Contraseña por Defecto | Funcionalidades Habilitadas |
| :--- | :--- | :--- | :--- |
| **Admin Principal** | **Administrador** | `admin` | Control total del sistema, gestión de personal, registro de nuevos módulos. |
| **Dr. Investigador** | **Investigador** | `investiga` | Visualizar bases de datos, descargar reportes consolidados, diseñar matrices de evaluación. |
| **Lic. Clínico** | **Clínico** | `clinico` | Realizar evaluaciones a participantes, capturar telemetría de sensores Polar. |
| **Usuario Estándar** | **Usuario Estándar** | `user` | Ingreso y consulta básica de registros clínicos. |

---

## Cómo Ejecutar la Aplicación (Guía de Desarrollo)

Para ejecutar o modificar el código fuente en tu computadora, asegúrate de tener instalado y configurado en tu PATH el **SDK de Flutter** (v3.11.5 o superior).

1. **Entrar a la carpeta del demo**:
   ```bash
   cd demo
   ```
2. **Descargar las dependencias del proyecto**:
   ```bash
   flutter pub get
   ```
3. **Ejecutar el proyecto en modo escritorio Windows**:
   ```bash
   flutter run -d windows
   ```
   *Nota: Si deseas probarlo en tu navegador (Chrome o Edge) o en un emulador de Android, reemplaza `windows` por `chrome` o `android` en el comando.*

---

## Compilación y Empaquetado (Creación del .exe)

Para facilitar la visualización de la aplicación sin herramientas de desarrollo instaladas, se puede compilar a un ejecutable nativo de Windows:

### A. Compilar para Producción (Release)
Ejecuta el siguiente comando en la carpeta `demo/`:
```bash
flutter build windows --release
```
Esto compilará el código Dart a lenguaje máquina nativo y exportará los binarios a la ruta:
`build/windows/x64/runner/Release/`

### B. Empaquetado para Distribución a Usuarios Finales
La carpeta compilada resultante **no** consta de un único archivo ejecutable autocontenido. El archivo `integrador.exe` requiere obligatoriamente de sus archivos DLL acompañantes y de la estructura de recursos para funcionar. Para distribuirlo:
1. Dirígete a la ruta `build/windows/x64/runner/Release/`.
2. Identifica los siguientes archivos y carpetas esenciales:
   - `integrador.exe` (El ejecutable principal).
   - `flutter_windows.dll` (Motor gráfico de Flutter).
   - Archivos `.dll` específicos de plugins (ej. `path_provider_windows_plugin.dll`).
   - La carpeta `data/` (Contiene fuentes de texto, imágenes de assets y traducciones).
3. Comprime toda esa carpeta `Release` en un único archivo **`.zip`** (ej. `ResearchModule_Windows.zip`).
4. Los evaluadores clínicos o usuarios finales podrán descargar, descomprimir el ZIP y ejecutar `integrador.exe` directamente en cualquier PC con Windows, sin necesidad de instalar SDKs de desarrollo o Visual Studio.

> [!TIP]
> En publicaciones científicas y proyectos de código abierto, la mejor práctica es subir este archivo `.zip` compilado a la sección de **"Releases" de tu repositorio de GitHub** o adjuntarlo en el registro de **Zenodo** (junto al DOI), evitando saturar el historial de Git con archivos binarios pesados.

---

## Distribución a otras plataformas (Móvil y Escritorio)

Flutter permite compilar exactamente el mismo código fuente para otras plataformas:
- **Android**: Ejecuta `flutter build apk` para generar el instalador `.apk` compatible con tablets y celulares Android.
- **iOS**: Requiere macOS. Ejecuta `flutter build ipa` para generar el empaquetado cargable a TestFlight.
- **macOS / Linux**: Ejecuta `flutter build macos` o `flutter build linux` respectivamente para compilar instaladores de escritorio en dichos sistemas operativos.
- **Web**: Ejecuta `flutter build web` para compilar los recursos web (HTML/JS) listos para subir a servidores de hosting estático como GitHub Pages o Netlify.

---

## Cómo Personalizar y Añadir Módulos

La aplicación Demo EDC se diseñó bajo un principio modular fuerte.

### A. Estructura de Nombres (Naming Schema)
Cada campo de medición de un módulo debe seguir una nomenclatura consistente que enlace su identificador con su tipo de variable:
`{nombre_modulo}_{nombre_campo}` (ej. `ipaq_vigorous_duration` o `polar_max_hr`). 
Esto permite que, al integrar múltiples módulos, el sistema identifique de forma automática campos duplicados y aplique reglas de integración lógica (tales como "mantener primer valor", "preguntar al usuario", o "solicitar reingreso").

### B. Registrar un Nuevo Módulo (Modo Borrador)
Para configurar una nueva ficha de evaluación en el tablero:
1. Inicia sesión como **Admin Principal**.
2. Entra al menú de **Configuración** (icono de engranaje).
3. Ve a la pestaña de **Gestor de Módulos**.
4. Haz clic en **Agregar Módulo** y define:
   - Nombre y Categoría (Clínico, Cuestionario, Fisiología, Deportivo, etc.).
   - Atributos a registrar.
   - Estado: Establécelo en `draft_state` si está en edición preliminar, o en `published` para distribuirlo inmediatamente a los dispositivos de los clínicos.
