---
title: "Demo EDC - Integrated Flutter App"
summary: "This directory contains the source code for the Demo EDC, a clinical data capture system built using Flutter and Riverpod, showcasing modular evaluations, user roles, offline-first local storage, and BLE sensor integration."
document_type: "technical_documentation"
domain: "digital_health_software_design"
audience: "researchers, software_developers"
intended_use: "methodological_appendix_and_runnable_example"
key_entities: ["Flutter_App", "Modular_Capture", "Role_Based_Auth", "BLE_Sensor"]
version: "1.0"
language: "en"
---

# Demo EDC - Integrated Flutter App

This directory contains the source code of **Demo EDC** (codename *integrador*), a cross-platform clinical data capture system developed using Flutter. It is included in this repository as an interactive, editable, and runnable methodological appendix associated with the manuscript *From Zero to Hero: Methodological Experience in the Iterative Construction of Clinical Data Capture Systems using Agentic AI*.

---

## Technical Stack & Key Libraries

The application is structured to demonstrate clean architecture, state management using Riverpod, and offline-first capabilities. Key packages declared in `pubspec.yaml` include:

- **State Management**: `flutter_riverpod` (v3.3.1) for reactive, modular state tracking.
- **Routing**: `go_router` (v17.2.3) for declarative and deep-linkable navigation.
- **Styling & UI**: `flex_color_scheme` (v8.4.0) for harmonized themes, `lucide_icons` (v0.257.0) for UI icons, and `flutter_animate` (v4.5.2) for smooth micro-animations.
- **Localization**: `easy_localization` (v3.0.7) for managing translation assets.
- **Persistence & PDF Export**: `shared_preferences` for quick session caching, `pdf` (v3.12.0) and `printing` (v5.14.3) for professional clinical report rendering.
- **Security & Media**: `local_auth` (v3.0.1) for biometrics, `file_picker` (v9.0.2) for attachments, and `mobile_scanner`/`qr_flutter` for configuration syncing.

---

## Predefined Login Credentials

The application uses local role-based access control (RBAC) to simulate clinical workflows. You can log in using any of the following pre-loaded credentials:

| Selected User | Role / Access Level | Default Password | Features Enabled |
| :--- | :--- | :--- | :--- |
| **Admin Principal** | **Administrator** | `admin` | Full system control, user management, module registration. |
| **Dr. Investigador** | **Investigator** | `investiga` | View database, download reports, design matrices. |
| **Lic. Clínico** | **Clinician** | `clinico` | Conduct patient evaluations, record sensor telemetry. |
| **Usuario Estándar** | **Standard User** | `user` | Basic data entry and lookup. |

---

## How to Run the App (Developer Guide)

To execute or modify the application on your computer, ensure you have the **Flutter SDK** (v3.11.5 or higher) installed and configured in your path.

1. **Navigate to the demo folder**:
   ```bash
   cd demo
   ```
2. **Download all package dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the application on Windows desktop**:
   ```bash
   flutter run -d windows
   ```
   *Note: If you want to run it on Chrome/Edge or an Android emulator, replace `windows` with `chrome` or `android` respectively.*

---

## Compiling & Packaging (Creating the .exe)

To facilitate visualization without developer tools, the application can be compiled into a native Windows executable:

### A. Compile for Release
Run the following build command in the `demo/` directory:
```bash
flutter build windows --release
```
This compiles Dart code into native machine code and outputs the binaries to:
`build/windows/x64/runner/Release/`

### B. Packaging for Non-Developer Distribution
The resulting compiled folder is **not** a single self-contained `.exe` file. It compiles to `integrador.exe` but requires its companion DLLs and asset folder to execute. To distribute the demo:
1. Navigate to `build/windows/x64/runner/Release/`.
2. Locate the following files:
   - `integrador.exe`
   - `flutter_windows.dll`
   - Any plugin-specific `.dll` files (e.g. `path_provider_windows_plugin.dll`)
   - The `data/` folder (contains fonts, assets, and translations).
3. Compress this entire `Release` folder into a single **`.zip`** archive (e.g. `ResearchModule_Windows.zip`).
4. Users can download, extract the ZIP, and run `integrador.exe` directly, without needing Flutter or Visual Studio installed.

> [!TIP]
> In academic and open-source releases, it is highly recommended to place this compiled `.zip` file under the **GitHub Releases** page of your repository or directly upload it as an appendix on Zenodo to avoid bloating the Git history with large binary assets.

---

## Cross-Platform Versioning (Mobile & Other OS)

Flutter allows compiling the exact same codebase to other platforms:
- **Android**: Run `flutter build apk` to generate a package (`.apk`) installable on Android tablets and phones.
- **iOS**: Run `flutter build ipa` on a macOS machine to generate an iOS archive ready for distribution via TestFlight.
- **macOS / Linux**: Run `flutter build macos` or `flutter build linux` to compile native desktop builds for those systems.
- **Web**: Run `flutter build web` to compile the app into HTML/JS assets ready to host on GitHub Pages or Netlify.

---

## How to Customize and Add Modules

The Demo EDC application is designed around a modular structure. 

### A. The Naming Schema
Every measurement field in a module follows a naming structure that links its code-identifier with a variable type:
`{module_name}_{field_name}` (e.g., `ipaq_vigorous_duration` or `polar_max_hr`). 
This guarantees that when multiple modules are active, the system can dynamically identify duplicate variables and apply integration rules (such as "keep first value", "prompt user", or "re-enter").

### B. Registering a New Module (Drafting Flow)
To configure a new evaluation card in the dashboard:
1. Log in as **Admin Principal**.
2. Go to **Configuración** (Gear Icon).
3. Navigate to **Gestor de Módulos** (Module Manager).
4. Click **Agregar Módulo** (Add Module) and define:
   - Name and Category (Clinical, Questionnaire, Physiological).
   - Target attributes to capture.
   - Status (set to `draft_state` to review, or `published` to deploy immediately to clinicians).
