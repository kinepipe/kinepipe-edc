import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../module_registry.dart';
import '../core/module_enums.dart';
import '../../core/providers/patient_data_provider.dart';

class PersonalDataModule extends ResearchModule {
  @override
  String get id => 'personal_data';

  @override
  String get name => 'Ficha del Paciente';

  @override
  String get description => 'Información demográfica y de contacto del paciente';

  @override
  IconData get icon => LucideIcons.userCircle;

  @override
  UpdateFrequency get updateFrequency => UpdateFrequency.unique;

  @override
  Map<String, Map<String, String>> get translations => {
    'spa': {
      'first_name': 'Nombres',
      'last_name1': 'Apellido Paterno',
      'last_name2': 'Apellido Materno',
      'id_number': 'RUT / Pasaporte',
      'dob': 'Fecha de Nacimiento',
      'unknown_dob': 'No sé la fecha exacta',
      'manual_age': 'Edad (años)',
      'gender': 'Sexo',
      'email': 'Correo Electrónico',
      'phone': 'Teléfono',
      'address': 'Dirección',
      'insurance': 'Seguro Médico / Previsión',
      'tutor_section': 'Información del Tutor o Representante',
      'tutor_reason': 'Requerido por edad del paciente',
      'tutor_name': 'Nombre del Tutor',
      'tutor_relation': 'Parentesco',
      'tutor_phone': 'Teléfono del Tutor',
    },
    'eng': {
      'first_name': 'First Name',
      'last_name1': 'Last Name',
      'last_name2': 'Second Last Name',
      'id_number': 'ID / Passport',
      'dob': 'Date of Birth',
      'unknown_dob': 'I do not know the exact date',
      'manual_age': 'Age (years)',
      'gender': 'Gender',
      'email': 'Email',
      'phone': 'Phone Number',
      'address': 'Address',
      'insurance': 'Health Insurance',
      'tutor_section': 'Tutor or Representative Information',
      'tutor_reason': 'Required due to patient age',
      'tutor_name': 'Tutor Name',
      'tutor_relation': 'Relationship',
      'tutor_phone': 'Tutor Phone',
    }
  };

  @override
  Future<void> initialize() async {}

  @override
  Future<void> printToPdf(BuildContext context) async {
    // Basic implementation
  }

  @override
  Widget buildEvaluationView(BuildContext context, {required bool isLocked, Map<String, dynamic>? customConfig}) {
    return _PersonalDataEvaluationView(isLocked: isLocked);
  }
}

class _PersonalDataEvaluationView extends ConsumerStatefulWidget {
  final bool isLocked;
  const _PersonalDataEvaluationView({required this.isLocked});

  @override
  ConsumerState<_PersonalDataEvaluationView> createState() => _PersonalDataEvaluationViewState();
}

class _PersonalDataEvaluationViewState extends ConsumerState<_PersonalDataEvaluationView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final patientData = ref.watch(patientDataProvider);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(LucideIcons.userCircle, size: 32, color: theme.colorScheme.primary),
                    const SizedBox(width: 12),
                    Text(
                      'Ficha del Paciente',
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (patientData.idHash.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'ID: ${patientData.idHash.substring(0, 8).toUpperCase()}',
                      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 16),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTextField('Nombres', patientData.firstName, (v) => ref.read(patientDataProvider.notifier).updateField(firstName: v)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('Apellido Paterno', patientData.lastName1, (v) => ref.read(patientDataProvider.notifier).updateField(lastName1: v))),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Apellido Materno', patientData.lastName2, (v) => ref.read(patientDataProvider.notifier).updateField(lastName2: v))),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildTextField('RUT / Pasaporte', patientData.idNumber, (v) => ref.read(patientDataProvider.notifier).updateField(idNumber: v))),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Sexo', patientData.gender, (v) => ref.read(patientDataProvider.notifier).updateField(gender: v))),
              ],
            ),
            const SizedBox(height: 24),
            Text('Edad', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: widget.isLocked || patientData.isAgeUnknown ? null : () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: patientData.dateOfBirth ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        ref.read(patientDataProvider.notifier).updateField(dateOfBirth: date);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(4),
                        color: patientData.isAgeUnknown ? theme.disabledColor.withOpacity(0.1) : null,
                      ),
                      child: Text(
                        patientData.dateOfBirth != null 
                          ? '${patientData.dateOfBirth!.day}/${patientData.dateOfBirth!.month}/${patientData.dateOfBirth!.year}' 
                          : 'Seleccionar Fecha',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Checkbox(
                      value: patientData.isAgeUnknown,
                      onChanged: widget.isLocked ? null : (val) {
                        ref.read(patientDataProvider.notifier).updateField(isAgeUnknown: val);
                      },
                    ),
                    const Text('No sé la fecha exacta'),
                  ],
                ),
              ],
            ),
            if (patientData.isAgeUnknown) ...[
              const SizedBox(height: 16),
              _buildTextField(
                'Edad (Años)', 
                patientData.manualAge?.toString() ?? '', 
                (v) => ref.read(patientDataProvider.notifier).updateField(manualAge: int.tryParse(v)),
                keyboardType: TextInputType.number,
              ),
            ] else if (patientData.calculatedAge != null) ...[
              const SizedBox(height: 8),
              Text('Edad calculada: ${patientData.calculatedAge} años', style: const TextStyle(color: Colors.grey)),
            ],
            const SizedBox(height: 24),
            Text('Contacto', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildTextField('Correo Electrónico', patientData.email, (v) => ref.read(patientDataProvider.notifier).updateField(email: v), keyboardType: TextInputType.emailAddress)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Teléfono', patientData.phone, (v) => ref.read(patientDataProvider.notifier).updateField(phone: v), keyboardType: TextInputType.phone)),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField('Dirección', patientData.address, (v) => ref.read(patientDataProvider.notifier).updateField(address: v)),
            const SizedBox(height: 16),
            _buildTextField('Seguro / Previsión', patientData.insurance, (v) => ref.read(patientDataProvider.notifier).updateField(insurance: v)),
            
            if (patientData.requiresTutor) ...[
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.users, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'Tutor / Representante',
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.orange[800]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('Requerido por la edad del paciente', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 16),
                    _buildTextField(
                      'Nombre del Tutor', 
                      patientData.tutorInfo.name, 
                      (v) => ref.read(patientDataProvider.notifier).updateField(tutorInfo: patientData.tutorInfo.copyWith(name: v))
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: patientData.tutorInfo.relation.isEmpty ? null : patientData.tutorInfo.relation,
                            decoration: const InputDecoration(labelText: 'Parentesco', border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(value: 'Padre', child: Text('Padre')),
                              DropdownMenuItem(value: 'Madre', child: Text('Madre')),
                              DropdownMenuItem(value: 'Esposo/a', child: Text('Esposo/a')),
                              DropdownMenuItem(value: 'Hijo/a', child: Text('Hijo/a')),
                              DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                            ],
                            onChanged: widget.isLocked ? null : (v) => ref.read(patientDataProvider.notifier).updateField(tutorInfo: patientData.tutorInfo.copyWith(relation: v)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            'Teléfono del Tutor', 
                            patientData.tutorInfo.phone, 
                            (v) => ref.read(patientDataProvider.notifier).updateField(tutorInfo: patientData.tutorInfo.copyWith(phone: v)),
                            keyboardType: TextInputType.phone
                          )
                        ),
                      ],
                    ),
                    if (patientData.tutorInfo.relation == 'Otro') ...[
                      const SizedBox(height: 16),
                      _buildTextField(
                        'Especifique Otro Parentesco', 
                        patientData.tutorInfo.customRelation, 
                        (v) => ref.read(patientDataProvider.notifier).updateField(tutorInfo: patientData.tutorInfo.copyWith(customRelation: v))
                      ),
                    ],
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Contactos de Emergencia', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                if (!widget.isLocked)
                  TextButton.icon(
                    icon: const Icon(LucideIcons.plus),
                    label: const Text('Añadir Contacto'),
                    onPressed: () {
                      ref.read(patientDataProvider.notifier).addEmergencyContact(ContactInfo());
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            ...patientData.emergencyContacts.asMap().entries.map((entry) {
              final idx = entry.key;
              final contact = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: _buildTextField('Nombre', contact.name, (v) => ref.read(patientDataProvider.notifier).updateEmergencyContact(idx, contact.copyWith(name: v)))),
                          if (!widget.isLocked)
                            IconButton(
                              icon: const Icon(LucideIcons.trash2, color: Colors.red),
                              onPressed: () => ref.read(patientDataProvider.notifier).removeEmergencyContact(idx),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: contact.relation.isEmpty ? null : contact.relation,
                              decoration: const InputDecoration(labelText: 'Parentesco', border: OutlineInputBorder()),
                              items: const [
                                DropdownMenuItem(value: 'Padre', child: Text('Padre')),
                                DropdownMenuItem(value: 'Madre', child: Text('Madre')),
                                DropdownMenuItem(value: 'Esposo/a', child: Text('Esposo/a')),
                                DropdownMenuItem(value: 'Hijo/a', child: Text('Hijo/a')),
                                DropdownMenuItem(value: 'Otro', child: Text('Otro')),
                              ],
                              onChanged: widget.isLocked ? null : (v) => ref.read(patientDataProvider.notifier).updateEmergencyContact(idx, contact.copyWith(relation: v)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(child: _buildTextField('Teléfono', contact.phone, (v) => ref.read(patientDataProvider.notifier).updateEmergencyContact(idx, contact.copyWith(phone: v)), keyboardType: TextInputType.phone)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, Function(String) onChanged, {TextInputType? keyboardType}) {
    return TextFormField(
      initialValue: value,
      enabled: !widget.isLocked,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }
}
