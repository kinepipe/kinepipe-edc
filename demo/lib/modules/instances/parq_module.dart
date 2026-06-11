import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:signature/signature.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../module_registry.dart';
import '../core/module_enums.dart';
import '../../core/providers/evaluation_session_provider.dart';
import '../../core/services/pdf_service.dart';
import '../../core/providers/patient_data_provider.dart';
import '../../core/providers/vital_signs_provider.dart';

class ParQModule extends ResearchModule {
  @override
  String get id => 'parq';

  @override
  String get name => 'PAR-Q & YOU';

  @override
  String get description => 'Cuestionario de Aptitud para la Actividad Física';

  @override
  IconData get icon => LucideIcons.clipboardCheck;

  @override
  Future<void> initialize() async {}

  @override
  UpdateFrequency get updateFrequency => UpdateFrequency.dynamic;

  @override
  Map<String, Map<String, String>> get translations => {
    'spa': {
      'title': 'PAR-Q & YOU',
      'subtitle': 'Cuestionario de Aptitud para la Actividad Física',
      'info_who': '¿Para quién es este cuestionario?',
      'info_content': 'La actividad física regular es saludable y sana. Sin embargo, algunos individuos deben consultar a un médico antes de iniciar un programa de ejercicio o actividad física.',
      'progress': 'Progreso de la encuesta',
      'result_safe': 'Apto para actividad física',
      'result_risk': 'Se requiere consulta médica',
      'result_safe_msg': 'Usted contestó NO honestamente a todas las preguntas, entonces puede estar razonablemente seguro que puede comenzar a ser más activo físicamente.',
      'result_risk_msg': 'Si usted contestó SÍ a una o más preguntas: Hable con su médico por teléfono o en persona ANTES de empezar a estar más activo físicamente.',
      'declaration': 'Yo he leído, entendido y completado el cuestionario. Todas las preguntas fueron respondidas a mi entera satisfacción.',
      'signature_label': 'Firma del Participante',
      'signature_hint': 'Dibuje su firma aquí',
      'btn_finish': 'Finalizar y Generar Reporte',
      'q1': '¿Alguna vez su médico le ha indicado que usted tiene un problema cardiovascular, y que solamente puede llevar a cabo ejercicios o actividad física si lo refiere un médico?',
      'q2': '¿Sufre de dolores frecuentes en el pecho cuando realiza algún tipo de actividad física?',
      'q3': '¿En el último mes, le ha dolido el pecho cuando no estaba haciendo actividad física?',
      'q4': '¿Con frecuencia pierde el equilibrio debido a mareos, o alguna vez ha perdido el conocimiento?',
      'q5': '¿Tiene problemas en los huesos o articulaciones (por ejemplo, en la espalda, rodillas o cadera) que pudiera agravarse al aumentar la actividad física?',
      'q6': '¿Al presente, le receta su médico medicamentos para la presión arterial o problemas con el corazón?',
      'q7': '¿Existe alguna otra razón por la cual no debería participar en un programa de actividad física?',
      'illness_label': '¿Tiene alguna enfermedad temporal (como resfriado o fiebre)?',
      'pregnancy_label': '¿Está embarazada o sospecha estarlo?',
      'health_change_label': '¿Ha habido algún cambio en su salud que obligue a responder SÍ a alguna pregunta anterior?',
      'bp_label': '¿Es su presión arterial superior a 144/94?',
      'bp_manual': 'Presión Arterial ingresada manualmente: ',
      'bp_vital': 'Presión Arterial obtenida de Signos Vitales: ',
      'delay_illness': 'DEMORE EL INICIO: Lo sugerido es esperar hasta que se recupere por completo.',
      'delay_pregnancy': 'DEMORE EL INICIO: Hable con su médico antes de comenzar a estar físicamente más activa.',
      'alert_health_change': 'POR FAVOR: Es importante que esta situación se le informe a su médico o entrenador personal.',
    },
    'eng': {
      'title': 'PAR-Q & YOU',
      'subtitle': 'Physical Activity Readiness Questionnaire',
      'info_who': 'Who is this questionnaire for?',
      'info_content': 'Physical activity is fun and healthy. However, some people should consult their doctor before becoming much more physically active.',
      'progress': 'Survey Progress',
      'result_safe': 'Fit for physical activity',
      'result_risk': 'Medical consultation required',
      'result_safe_msg': 'You can reasonably be sure that you can start becoming more physically active. Begin slowly and progress gradually.',
      'result_risk_msg': 'Talk to your doctor by phone or in person BEFORE you start becoming much more physically active. Tell your doctor about the PAR-Q and which questions you answered YES.',
      'declaration': 'I have read, understood, and completed the questionnaire. All questions were answered to my full satisfaction.',
      'signature_label': "Participant's Signature",
      'signature_hint': 'Draw your signature here',
      'btn_finish': 'Finish and Generate Report',
      'q1': 'Has your doctor ever said that you have a heart condition and that you should only do physical activity recommended by a doctor?',
      'q2': 'Do you feel pain in your chest when you do physical activity?',
      'q3': 'In the past month, have you had chest pain when you were not doing physical activity?',
      'q4': 'Do you lose your balance because of dizziness or do you ever lose consciousness?',
      'q5': 'Do you have a bone or joint problem that could be made worse by a change in your physical activity?',
      'q6': 'Is your doctor currently prescribing drugs for your blood pressure or heart condition?',
      'q7': 'Do you know of any other reason why you should not do physical activity?',
      'illness_label': 'Do you have a temporary illness (such as a cold or fever)?',
      'pregnancy_label': 'Are you pregnant or suspect you might be?',
      'health_change_label': 'Has there been any change in your health that requires you to answer YES to any previous question?',
      'bp_label': 'Is your blood pressure higher than 144/94?',
      'bp_manual': 'Manually entered Blood Pressure: ',
      'bp_vital': 'Blood Pressure fetched from Vital Signs: ',
      'delay_illness': 'DELAY START: It is suggested to wait until you fully recover.',
      'delay_pregnancy': 'DELAY START: Talk to your doctor before becoming much more physically active.',
      'alert_health_change': 'PLEASE: It is important that you inform your doctor or personal trainer about this situation.',
    }
  };

  @override
  Map<String, dynamic> get clinimetrics => {
    'name': 'PAR-Q+ (Physical Activity Readiness Questionnaire for Everyone)',
    'description': 'Herramienta de cribado pre-participación diseñada para identificar individuos que deben consultar a un médico antes de aumentar sus niveles de actividad física.',
    'reliability': {
      'test_retest': '0.99 (r) en periodos de 3 meses',
      'internal_consistency': '0.98 (Cronbach alpha)',
      'intra_observer': '0.987 (ICC)',
    },
    'validity': {
      'sensitivity': '0.90 para identificar riesgo cardiovascular',
      'specificity': '1.00 para identificar individuos sanos',
    },
    'reference_values': [
      {
        'population': 'Población General',
        'sem': 'N/A (Cuestionario Categórico)',
        'mcid': 'N/A (Herramienta de Cribado)',
        'cutoff': 'Cualquier "SÍ" requiere consulta médica o ePARmed-X+',
      }
    ],
    'references': [
      'Shirley Ryan AbilityLab - Rehabilitation Measures Database',
      'PAR-Q+ Collaboration - ePARmed-X+ documentation',
      'Warburton et al. (2011) - The Physical Activity Readiness Questionnaire for Everyone (PAR-Q+)',
    ]
  };

  @override
  Future<void> printToPdf(BuildContext context) async {}

  @override
  Widget buildEvaluationView(BuildContext context, {required bool isLocked, Map<String, dynamic>? customConfig}) {
    return ParQEvaluationView(module: this, isLocked: isLocked);
  }
}

class ParQEvaluationView extends ConsumerStatefulWidget {
  final ParQModule module;
  final bool isLocked;

  const ParQEvaluationView({
    super.key,
    required this.module,
    required this.isLocked,
  });

  @override
  ConsumerState<ParQEvaluationView> createState() => _ParQEvaluationViewState();
}

class _ParQEvaluationViewState extends ConsumerState<ParQEvaluationView> {
  final Map<int, bool?> _responses = {
    1: null, 2: null, 3: null, 4: null, 5: null, 6: null, 7: null
  };

  bool? _hasIllness;
  bool? _isPregnant;
  bool? _hasHealthChanged;
  bool? _highBpManual;

  late SignatureController _signatureController;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  bool _isHighBp() {
    final vitalSigns = ref.read(vitalSignsProvider);
    if (vitalSigns.hasBloodPressure) {
      return vitalSigns.isBloodPressureHigh;
    }
    return _highBpManual == true;
  }

  bool get _hasYes => _responses.values.any((v) => v == true) || _isHighBp() || _hasHealthChanged == true;
  bool get _hasDelay => _hasIllness == true || _isPregnant == true;
  
  bool get _isComplete {
    final patientData = ref.read(patientDataProvider);
    final isFemale = patientData.gender.toLowerCase() == 'femenino' || patientData.gender.toLowerCase() == 'mujer' || patientData.gender.isEmpty;
    final vitalSigns = ref.read(vitalSignsProvider);

    bool coreQuestions = _responses.values.every((v) => v != null);
    bool delayQuestions = _hasIllness != null && (!isFemale || _isPregnant != null);
    bool bpQuestion = vitalSigns.hasBloodPressure || _highBpManual != null;
    bool changeQuestion = _hasHealthChanged != null;

    return coreQuestions && delayQuestions && bpQuestion && changeQuestion;
  }

  double get _progress {
    int total = 7 + 1 + 1 + 1; // 7 core + illness + change + bp
    int answered = _responses.values.where((v) => v != null).length;
    
    final patientData = ref.read(patientDataProvider);
    final isFemale = patientData.gender.toLowerCase() == 'femenino' || patientData.gender.toLowerCase() == 'mujer' || patientData.gender.isEmpty;
    if (isFemale) total++; // Add pregnancy to total
    
    if (_hasIllness != null) answered++;
    if (_isPregnant != null && isFemale) answered++;
    if (_hasHealthChanged != null) answered++;
    
    final vitalSigns = ref.read(vitalSignsProvider);
    if (vitalSigns.hasBloodPressure || _highBpManual != null) answered++;

    return answered / total;
  }

  void _updateAnswer(int id, bool value) {
    if (widget.isLocked) return;
    setState(() {
      _responses[id] = value;
    });
    ref.read(evaluationSessionProvider.notifier).updateCurrentModuleProgress(_progress);
  }

  Future<void> _handleFinish() async {
    // Logic to save and mark as complete
    ref.read(evaluationSessionProvider.notifier).updateCurrentModuleProgress(1.0);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Módulo finalizado con éxito')),
    );
  }

  Future<void> _handlePdfAction({bool isPrint = true}) async {
    final signature = await _signatureController.toPngBytes();
    final patientData = ref.read(patientDataProvider);
    final vitalSigns = ref.read(vitalSignsProvider);
    
    final List<pw.Widget> pdfContent = [
      pw.Header(level: 1, text: 'Reporte Clínico PAR-Q'),
      pw.SizedBox(height: 10),
      pw.Container(
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          color: PdfColors.grey100,
          border: pw.Border.all(color: PdfColors.grey300),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Paciente: ${patientData.fullName}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Text('RUT/ID: ${patientData.idNumber} | Edad: ${patientData.calculatedAge ?? 'N/A'} años'),
            pw.Text('Fecha de Evaluación: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
          ]
        ),
      ),
      pw.SizedBox(height: 15),
      pw.Text('Estado: ${_hasYes ? 'REQUIERE CONSULTA MÉDICA' : 'APTO PARA ACTIVIDAD FÍSICA'}', 
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: _hasYes ? PdfColors.red : PdfColors.green)),
      if (_hasDelay)
        pw.Text('Aviso: Requiere demora de inicio por condición temporal.', style: pw.TextStyle(color: PdfColors.orange)),
      pw.SizedBox(height: 20),
      ...List.generate(7, (index) {
        final id = index + 1;
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('$id. '),
              pw.Expanded(child: pw.Text('parq.q$id'.tr())),
              pw.SizedBox(width: 10),
              pw.Text(_responses[id] == true ? '[ SÍ ]' : '[ NO ]', 
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ],
          ),
        );
      }),
      pw.SizedBox(height: 15),
      pw.Text('Condiciones Especiales:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 8),
      if (vitalSigns.hasBloodPressure)
        pw.Text('- Presión Arterial (Signos Vitales): ${vitalSigns.systolicBP}/${vitalSigns.diastolicBP} mmHg')
      else
        pw.Text('- Presión Arterial Alta Manual: ${_highBpManual == true ? 'SÍ' : 'NO'}'),
      pw.Text('- Enfermedad Temporal: ${_hasIllness == true ? 'SÍ' : 'NO'}'),
      if (_isPregnant != null)
        pw.Text('- Embarazo: ${_isPregnant == true ? 'SÍ' : 'NO'}'),
      pw.Text('- Cambio en Salud: ${_hasHealthChanged == true ? 'SÍ' : 'NO'}'),
      pw.SizedBox(height: 20),
      pw.Paragraph(text: 'parq.declaration'.tr()),
    ];

    if (isPrint) {
      await PdfService.printReport(
        title: 'PAR-Q & YOU',
        subtitle: 'Reporte Clínico de Aptitud Física',
        content: pdfContent,
        signatureImage: signature,
      );
    } else {
      await PdfService.exportPdf(
        title: 'PAR-Q & YOU',
        subtitle: 'Reporte Clínico Digital',
        content: pdfContent,
        signatureImage: signature,
      );
    }
  }

  void _showClinimetricsModal(BuildContext context) {
    final data = widget.module.clinimetrics;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[600], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 24),
              Row(
                children: [
                  Icon(LucideIcons.info, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(child: Text(data['name'], style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold))),
                ],
              ),
              const SizedBox(height: 16),
              Text(data['description'], style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 24),
              _buildMetricSection('Confiabilidad (Reliability)', [
                'Test-Retest: ${data['reliability']['test_retest']}',
                'Consistencia Interna: ${data['reliability']['internal_consistency']}',
                'Intra-observador: ${data['reliability']['intra_observer']}',
              ]),
              const SizedBox(height: 16),
              _buildMetricSection('Validez (Validity)', [
                'Sensibilidad: ${data['validity']['sensitivity']}',
                'Especificidad: ${data['validity']['specificity']}',
              ]),
              const SizedBox(height: 24),
              const Text('Valores de Referencia / Clínicos', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Table(
                border: TableBorder.all(color: Colors.grey.withOpacity(0.3)),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
                    children: [
                      _cell('Población', isHeader: true),
                      _cell('SEM', isHeader: true),
                      _cell('MCID', isHeader: true),
                      _cell('Corte', isHeader: true),
                    ]
                  ),
                  ... (data['reference_values'] as List).map((v) => TableRow(
                    children: [
                      _cell(v['population']),
                      _cell(v['sem']),
                      _cell(v['mcid']),
                      _cell(v['cutoff']),
                    ]
                  )).toList(),
                ],
              ),
              const SizedBox(height: 24),
              const Text('Referencias clave', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ... (data['references'] as List).map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text('• $r', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              )).toList(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: isHeader ? FontWeight.bold : FontWeight.normal)),
    );
  }

  Widget _buildMetricSection(String title, List<String> metrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        ...metrics.map((m) => Text('• $m', style: const TextStyle(fontSize: 13))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final patientData = ref.watch(patientDataProvider);
    final isFemale = patientData.gender.toLowerCase() == 'femenino' || patientData.gender.toLowerCase() == 'mujer' || patientData.gender.isEmpty;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, context),
          const SizedBox(height: 24),
          _buildInfoPanel(theme),
          const SizedBox(height: 24),
          _buildProgressBar(theme),
          const SizedBox(height: 24),
          ...List.generate(7, (index) => _buildQuestionCard(index + 1, theme)),
          const SizedBox(height: 24),
          
          Text('Condiciones Especiales', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildCustomQuestionCard('bp_label', _highBpManual, (val) => setState(() => _highBpManual = val), theme, isVitalSign: true),
          _buildCustomQuestionCard('illness_label', _hasIllness, (val) => setState(() => _hasIllness = val), theme),
          if (isFemale) _buildCustomQuestionCard('pregnancy_label', _isPregnant, (val) => setState(() => _isPregnant = val), theme),
          _buildCustomQuestionCard('health_change_label', _hasHealthChanged, (val) => setState(() => _hasHealthChanged = val), theme),

          const SizedBox(height: 32),
          if (_isComplete) _buildAdvancedResultPanel(theme).animate().fadeIn().slideY(begin: 0.1),
          const SizedBox(height: 32),
          _buildSignatureSection(theme),
          const SizedBox(height: 40),
          _buildActionButtons(theme),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.clipboardCheck, size: 32, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'parq.title'.tr(),
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(
                'parq.subtitle'.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          icon: const Icon(LucideIcons.info, size: 20),
          onPressed: () => _showClinimetricsModal(context),
          tooltip: 'Información Clinimétrica',
        ),
      ],
    );
  }

  Widget _buildInfoPanel(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.secondaryContainer),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.info, size: 18, color: theme.colorScheme.secondary),
              const SizedBox(width: 8),
              Text('parq.info_who'.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text('parq.info_content'.tr(), style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildProgressBar(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('parq.progress'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text('${(_progress * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: _progress,
            minHeight: 8,
            backgroundColor: theme.dividerColor.withOpacity(0.1),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(int id, ThemeData theme) {
    final response = _responses[id];
    final isYes = response == true;
    final isNo = response == false;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: response == null 
            ? theme.cardColor 
            : (isYes ? Colors.red.withOpacity(0.05) : Colors.green.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: response == null 
              ? theme.dividerColor.withOpacity(0.2) 
              : (isYes ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: response == null 
                      ? theme.dividerColor.withOpacity(0.2) 
                      : (isYes ? Colors.red : Colors.green),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$id',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'parq.q$id'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.w500, height: 1.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildChoiceButton(
                label: 'SÍ',
                isSelected: isYes,
                color: Colors.red,
                onTap: () => _updateAnswer(id, true),
              ),
              const SizedBox(width: 12),
              _buildChoiceButton(
                label: 'NO',
                isSelected: isNo,
                color: Colors.green,
                onTap: () => _updateAnswer(id, false),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceButton({
    required String label,
    required bool isSelected,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: widget.isLocked ? null : onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? color : color.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomQuestionCard(String translationKey, bool? response, Function(bool?) onChanged, ThemeData theme, {bool isVitalSign = false}) {
    final vitalSigns = ref.read(vitalSignsProvider);
    final isYes = response == true;
    final isNo = response == false;

    if (isVitalSign && vitalSigns.hasBloodPressure) {
      final isHigh = vitalSigns.isBloodPressureHigh;
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.primaryContainer),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(LucideIcons.activity),
                const SizedBox(width: 8),
                Expanded(child: Text('parq.bp_vital'.tr() + '${vitalSigns.systolicBP}/${vitalSigns.diastolicBP}', style: const TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 8),
            Text(isHigh ? 'Presión Arterial Elevada (Riesgo)' : 'Presión Arterial Normal', style: TextStyle(color: isHigh ? Colors.red : Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: response == null 
            ? theme.cardColor 
            : (isYes ? Colors.red.withOpacity(0.05) : Colors.green.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: response == null 
              ? theme.dividerColor.withOpacity(0.2) 
              : (isYes ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('parq.$translationKey'.tr(), style: const TextStyle(fontWeight: FontWeight.w500, height: 1.4)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildChoiceButton(
                label: 'SÍ',
                isSelected: isYes,
                color: Colors.red,
                onTap: () {
                  onChanged(true);
                  ref.read(evaluationSessionProvider.notifier).updateCurrentModuleProgress(_progress);
                },
              ),
              const SizedBox(width: 12),
              _buildChoiceButton(
                label: 'NO',
                isSelected: isNo,
                color: Colors.green,
                onTap: () {
                  onChanged(false);
                  ref.read(evaluationSessionProvider.notifier).updateCurrentModuleProgress(_progress);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvancedResultPanel(ThemeData theme) {
    final isRisk = _hasYes;
    final isDelay = _hasDelay;
    
    Color color = Colors.green;
    IconData icon = LucideIcons.checkCircle2;
    String title = 'parq.result_safe'.tr();
    String message = 'parq.result_safe_msg'.tr();

    if (isRisk) {
      color = Colors.red;
      icon = LucideIcons.shieldAlert;
      title = 'parq.result_risk'.tr();
      message = 'parq.result_risk_msg'.tr();
      if (_hasHealthChanged == true) {
        message += '\n\n' + 'parq.alert_health_change'.tr();
      }
    } else if (isDelay) {
      color = Colors.orange;
      icon = LucideIcons.clock;
      title = 'Requiere Demora';
      message = _hasIllness == true ? 'parq.delay_illness'.tr() : 'parq.delay_pregnancy'.tr();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          Text(message, style: TextStyle(color: color.withOpacity(0.8), height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildSignatureSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'parq.signature_label'.tr(),
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
          ),
          child: Stack(
            children: [
              Signature(
                controller: _signatureController,
                height: 200,
                backgroundColor: Colors.transparent,
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  icon: const Icon(LucideIcons.trash2, size: 20),
                  onPressed: widget.isLocked ? null : () => _signatureController.clear(),
                ),
              ),
              if (!widget.isLocked)
                IgnorePointer(
                  child: Center(
                    child: Opacity(
                      opacity: 0.2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(LucideIcons.penTool, size: 32),
                          const SizedBox(height: 8),
                          Text('parq.signature_hint'.tr()),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: (!_isComplete || widget.isLocked) ? null : () => _handlePdfAction(isPrint: true),
                icon: const Icon(LucideIcons.printer),
                label: const Text('Imprimir'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: (!_isComplete || widget.isLocked) ? null : () => _handlePdfAction(isPrint: false),
                icon: const Icon(LucideIcons.fileDown),
                label: const Text('Exportar PDF'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: (!_isComplete || widget.isLocked) ? null : _handleFinish,
            icon: const Icon(LucideIcons.checkCircle),
            label: const Text('Finalizar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
