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

class RapaModule extends ResearchModule {
  @override
  String get id => 'rapa';

  @override
  String get name => 'RAPA';

  @override
  String get description => 'Rapid Assessment of Physical Activity';

  @override
  IconData get icon => LucideIcons.activity;

  @override
  Future<void> initialize() async {}

  @override
  UpdateFrequency get updateFrequency => UpdateFrequency.dynamic;

  @override
  Map<String, Map<String, String>> get translations => {
    'spa': {
      'title': 'Cuestionario RAPA',
      'subtitle': 'Evaluación rápida del nivel de intensidad de actividad física',
      'info_desc': 'Las actividades físicas son actividades en las que usted hace movimientos por diversión, trabajo o para transportarse. Estos movimientos aumentan los latidos de su corazón.',
      'examples_title': 'Ejemplos de Intensidad:',
      'ex_light_title': 'Actividades Ligeras',
      'ex_light_desc': '• Su corazón late un poco más rápido\n• Puede hablar y cantar',
      'ex_mod_title': 'Actividades Moderadas',
      'ex_mod_desc': '• El corazón late más rápido\n• Puede hablar pero no cantar',
      'ex_vig_title': 'Actividades Vigorosas',
      'ex_vig_desc': '• Los latidos aumentan mucho más\n• No puede hablar o es interrumpido por respiraciones',
      'q1': 'Nunca o casi nunca hago actividades físicas.',
      'q2': 'Hago algunas actividades físicas ligeras y/o moderadas, pero no cada semana.',
      'q3': 'Hago algunas actividades físicas ligeras cada semana.',
      'q4': 'Hago actividades físicas moderadas cada semana, pero menos de 5 días a la semana, o menos de 30 min diarios.',
      'q5': 'Hago actividades físicas vigorosas cada semana, pero menos de 3 días por semana, o menos de 20 min diarios.',
      'q6': 'Hago 30 minutos o más de actividades físicas moderadas por día, 5 o más días por semana.',
      'q7': 'Hago 20 minutos o más de actividades físicas vigorosas por día, 3 o más días por semana.',
      'q8': 'Hago actividades para aumentar la fuerza muscular, como levantamiento de pesas, 1 o más veces por semana.',
      'q9': 'Hago actividades para mejorar la flexibilidad, como ejercicios de elasticidad, 1 o más veces por semana.',
      'section_rapa1': 'RAPA 1: Actividad Aeróbica',
      'section_rapa2': 'RAPA 2: Fuerza y Flexibilidad',
      'progress': 'Progreso',
      'result_rapa1': 'Nivel Aeróbico (RAPA 1)',
      'result_rapa2': 'Componente Adicional (RAPA 2)',
      'cat_7': 'Activo',
      'cat_6': 'Activo',
      'cat_5': 'Poco activo regular',
      'cat_4': 'Poco activo regular',
      'cat_3': 'Poco activo regular ligero',
      'cat_2': 'Poco activo',
      'cat_1': 'Sedentario',
      'rec_ok': 'Dentro de lo recomendable',
      'rec_sub': 'Por debajo de lo recomendable (Subóptimo)',
      'r2_3': 'Cumple con ambas: Fuerza muscular y flexibilidad.',
      'r2_2': 'Cumple con flexibilidad.',
      'r2_1': 'Cumple con fuerza muscular.',
      'r2_0': 'Ninguna actividad de fuerza ni flexibilidad.',
      'btn_finish': 'Finalizar y Exportar',
      'signature_label': 'Firma del Paciente',
      'signature_hint': 'Firme aquí',
    },
    'eng': {
      'title': 'RAPA Questionnaire',
      'subtitle': 'Rapid Assessment of Physical Activity level and intensity',
      'info_desc': 'Physical activities are activities where you move and increase your heart rate above its resting rate, whether for pleasure, work, or transportation.',
      'examples_title': 'Intensity Examples:',
      'ex_light_title': 'Light Activities',
      'ex_light_desc': '• Heart beats slightly faster\n• Can talk and sing',
      'ex_mod_title': 'Moderate Activities',
      'ex_mod_desc': '• Heart beats faster\n• Can talk but not sing',
      'ex_vig_title': 'Vigorous Activities',
      'ex_vig_desc': '• Heart rate increases a lot\n• Cannot talk or talking is broken up by breaths',
      'q1': 'I rarely or never do any physical activities.',
      'q2': 'I do some light or moderate physical activities, but not every week.',
      'q3': 'I do some light physical activity every week.',
      'q4': 'I do moderate physical activities every week, but less than 30 minutes a day or 5 days a week.',
      'q5': 'I do vigorous physical activities every week, but less than 20 minutes a day or 3 days a week.',
      'q6': 'I do 30 minutes or more a day of moderate physical activities, 5 or more days a week.',
      'q7': 'I do 20 minutes or more a day of vigorous physical activities, 3 or more days a week.',
      'q8': 'I do activities to increase muscle strength, such as lifting weights or calisthenics, once a week or more.',
      'q9': 'I do activities to improve flexibility, such as stretching or yoga, once a week or more.',
      'section_rapa1': 'RAPA 1: Aerobic',
      'section_rapa2': 'RAPA 2: Strength & Flexibility',
      'progress': 'Progress',
      'result_rapa1': 'Aerobic Level (RAPA 1)',
      'result_rapa2': 'Additional Component (RAPA 2)',
      'cat_7': 'Active',
      'cat_6': 'Active',
      'cat_5': 'Under-active regular',
      'cat_4': 'Under-active regular',
      'cat_3': 'Under-active regular - light',
      'cat_2': 'Under-active',
      'cat_1': 'Sedentary',
      'rec_ok': 'Adequate physical activity',
      'rec_sub': 'Suboptimal physical activity',
      'r2_3': 'Both strength and flexibility activities.',
      'r2_2': 'Flexibility activities only.',
      'r2_1': 'Strength activities only.',
      'r2_0': 'No strength or flexibility activities.',
      'btn_finish': 'Finish and Export',
      'signature_label': 'Patient Signature',
      'signature_hint': 'Sign here',
    }
  };

  @override
  Map<String, dynamic> get clinimetrics => {
    'name': 'Rapid Assessment of Physical Activity (RAPA)',
    'description': 'Un cuestionario de 9 ítems que evalúa rápidamente los niveles de actividad física en adultos, incluyendo actividad aeróbica (RAPA 1) y fuerza/flexibilidad (RAPA 2).',
    'reliability': {
      'test_retest': 'Excelente (ICC = 0.94 - 0.996) en adultos mayores. Kappa ponderado > 0.81',
      'internal_consistency': 'Buena',
    },
    'validity': {
      'concurrent': 'Adecuada correlación con PACE (r=0.56) y CHAMPS (r=0.54).',
      'convergent': 'Adecuada correlación negativa con TUG time (r = -0.435) y positiva con SPPB (r=0.536).',
    },
    'reference_values': [
      {
        'population': 'Población General (Adultos)',
        'sem': '0.9',
        'mcid': '2.49 (MDC95)',
        'cutoff': 'RAPA 1: >= 6 (Activo/Adecuado). < 6 (Subóptimo)',
      }
    ],
    'references': [
      'Topolski et al. (2006) - The Rapid Assessment of Physical Activity (RAPA) Among Older Adults.',
      'Shirley Ryan AbilityLab - Rehabilitation Measures Database (RAPA).',
      'Pérez et al. (2015) - Validación de la escala RAPA en población adulta chilena.'
    ]
  };

  @override
  Future<void> printToPdf(BuildContext context) async {}

  @override
  Widget buildEvaluationView(BuildContext context, {required bool isLocked, Map<String, dynamic>? customConfig}) {
    return RapaEvaluationView(module: this, isLocked: isLocked);
  }
}

class RapaEvaluationView extends ConsumerStatefulWidget {
  final RapaModule module;
  final bool isLocked;

  const RapaEvaluationView({
    super.key,
    required this.module,
    required this.isLocked,
  });

  @override
  ConsumerState<RapaEvaluationView> createState() => _RapaEvaluationViewState();
}

class _RapaEvaluationViewState extends ConsumerState<RapaEvaluationView> {
  final Map<int, bool?> _responses = {
    1: null, 2: null, 3: null, 4: null, 5: null, 6: null, 7: null, 8: null, 9: null
  };

  late SignatureController _signatureController;

  String _t(String key) {
    final cleanKey = key.startsWith('rapa.') ? key.substring(5) : key;
    
    String lang = 'spa';
    try {
      lang = context.locale.languageCode == 'es' ? 'spa' : 'eng';
    } catch (_) {}
    
    final localDict = widget.module.translations[lang] ?? widget.module.translations['spa'];
    if (localDict != null && localDict.containsKey(cleanKey)) {
      return localDict[cleanKey]!;
    }
    
    return key.tr();
  }

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

  bool get _isComplete => _responses.values.every((v) => v != null);

  double get _progress {
    int answered = _responses.values.where((v) => v != null).length;
    return answered / 9.0;
  }

  int get _rapa1Score {
    for (int i = 7; i >= 1; i--) {
      if (_responses[i] == true) return i;
    }
    return 1; // Default
  }

  int get _rapa2Score {
    bool hasStrength = _responses[8] == true;
    bool hasFlex = _responses[9] == true;
    if (hasStrength && hasFlex) return 3;
    if (!hasStrength && hasFlex) return 2;
    if (hasStrength && !hasFlex) return 1;
    return 0;
  }

  void _updateAnswer(int id, bool value) {
    if (widget.isLocked) return;
    setState(() {
      _responses[id] = value;
    });
    ref.read(evaluationSessionProvider.notifier).updateCurrentModuleProgress(_progress);
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
              ]),
              const SizedBox(height: 16),
              _buildMetricSection('Validez (Validity)', [
                'Concurrente: ${data['validity']['concurrent']}',
                'Convergente: ${data['validity']['convergent']}',
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

  Future<void> _handlePdfAction({bool isPrint = true}) async {
    final signature = await _signatureController.toPngBytes();
    final patientData = ref.read(patientDataProvider);
    
    int score1 = _rapa1Score;
    int score2 = _rapa2Score;
    bool isOk = score1 >= 6;

    final List<pw.Widget> pdfContent = [
      pw.Header(level: 1, text: 'Reporte Clínico RAPA'),
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
      pw.Text('RESULTADOS:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
      pw.SizedBox(height: 5),
      pw.Text('RAPA 1 (Aeróbico): ${_t('cat_$score1')} (Puntuación: $score1/7)'),
      pw.Text('Estado: ${isOk ? _t('rec_ok') : _t('rec_sub')}', style: pw.TextStyle(color: isOk ? PdfColors.green : PdfColors.orange, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 10),
      pw.Text('RAPA 2 (Fuerza/Flexibilidad): Puntuación $score2/3'),
      pw.Text('- ${_t('r2_$score2')}'),
      pw.SizedBox(height: 20),
      pw.Text('Respuestas del Cuestionario:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      ...List.generate(9, (index) {
        final id = index + 1;
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 4),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('$id. '),
              pw.Expanded(child: pw.Text(_t('q$id'))),
              pw.SizedBox(width: 10),
              pw.Text(_responses[id] == true ? '[ SÍ ]' : '[ NO ]'),
            ],
          ),
        );
      }),
      pw.SizedBox(height: 30),
      pw.Text(_t('signature_label')),
    ];

    if (isPrint) {
      await PdfService.printReport(
        title: 'RAPA',
        subtitle: 'Rapid Assessment of Physical Activity',
        content: pdfContent,
        signatureImage: signature,
      );
    } else {
      await PdfService.exportPdf(
        title: 'RAPA',
        subtitle: 'Rapid Assessment of Physical Activity',
        content: pdfContent,
        signatureImage: signature,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme, context),
          const SizedBox(height: 24),
          _buildExamplesPanel(theme),
          const SizedBox(height: 24),
          _buildProgressBar(theme),
          const SizedBox(height: 32),
          
          Text(_t('section_rapa1'), style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
          const SizedBox(height: 16),
          ...List.generate(7, (index) => _buildQuestionCard(index + 1, theme)),
          
          const SizedBox(height: 32),
          Text(_t('section_rapa2'), style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
          const SizedBox(height: 16),
          ...List.generate(2, (index) => _buildQuestionCard(index + 8, theme)),

          const SizedBox(height: 32),
          if (_isComplete) _buildResultPanel(theme).animate().fadeIn().slideY(begin: 0.1),
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
                  Icon(LucideIcons.activity, size: 32, color: theme.colorScheme.primary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _t('title'),
                      style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(
                _t('subtitle'),
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

  Widget _buildExamplesPanel(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.image, size: 18),
              const SizedBox(width: 8),
              Text(_t('examples_title'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIntensityColumn(theme, _t('ex_light_title'), _t('ex_light_desc'), [
                  'rapa_light_walk.png', 'rapa_light_stretch.png', 'rapa_light_sweep.png'
                ]),
                const SizedBox(width: 16),
                _buildIntensityColumn(theme, _t('ex_mod_title'), _t('ex_mod_desc'), [
                  'rapa_mod_walk.png', 'rapa_mod_aerobics.png', 'rapa_mod_weights.png', 'rapa_mod_dance.png'
                ]),
                const SizedBox(width: 16),
                _buildIntensityColumn(theme, _t('ex_vig_title'), _t('ex_vig_desc'), [
                  'rapa_vig_stairs_fixed.png', 'rapa_vig_volley.png', 'rapa_vig_jog.png', 'rapa_vig_soccer.png'
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIntensityColumn(ThemeData theme, String title, String desc, List<String> images) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(desc, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: images.map((img) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('assets/modules/rapa/$img', width: 60, height: 60, fit: BoxFit.cover, errorBuilder: (c,e,s) => Container(width:60, height:60, color: Colors.grey[800], child: const Icon(LucideIcons.imageOff, size: 20))),
            )).toList(),
          )
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
            Text(_t('progress'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: response == null 
            ? theme.cardColor 
            : (isYes ? theme.colorScheme.primaryContainer.withOpacity(0.2) : theme.cardColor.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: response == null 
              ? theme.dividerColor.withOpacity(0.2) 
              : (isYes ? theme.colorScheme.primary.withOpacity(0.5) : theme.dividerColor.withOpacity(0.1)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: response == null 
                  ? theme.dividerColor.withOpacity(0.2) 
                  : (isYes ? theme.colorScheme.primary : Colors.grey),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$id',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              _t('q$id'),
              style: const TextStyle(fontWeight: FontWeight.w500, height: 1.3),
            ),
          ),
          const SizedBox(width: 16),
          Row(
            children: [
              _buildChoiceButton(
                label: 'SÍ',
                isSelected: isYes,
                color: theme.colorScheme.primary,
                onTap: () => _updateAnswer(id, true),
              ),
              const SizedBox(width: 8),
              _buildChoiceButton(
                label: 'NO',
                isSelected: isNo,
                color: Colors.grey,
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
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
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

  Widget _buildResultPanel(ThemeData theme) {
    int score1 = _rapa1Score;
    int score2 = _rapa2Score;
    bool isOk = score1 >= 6;
    Color r1Color = isOk ? Colors.green : Colors.orange;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Diagnóstico de Actividad Física', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          
          // RAPA 1
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(isOk ? LucideIcons.checkCircle2 : LucideIcons.alertTriangle, color: r1Color, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_t('result_rapa1'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(_t('cat_$score1'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: r1Color)),
                    const SizedBox(height: 4),
                    Text(isOk ? _t('rec_ok') : _t('rec_sub'), style: TextStyle(color: r1Color.withOpacity(0.8))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: r1Color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Text('$score1/7', style: TextStyle(fontWeight: FontWeight.bold, color: r1Color, fontSize: 16)),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          
          // RAPA 2
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(LucideIcons.dumbbell, color: theme.colorScheme.secondary, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_t('result_rapa2'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(_t('r2_$score2'), style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: theme.colorScheme.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Text('$score2/3', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.secondary, fontSize: 16)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _t('signature_label'),
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor.withOpacity(0.2)),
          ),
          child: Stack(
            children: [
              Signature(
                controller: _signatureController,
                height: 150,
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
                          Text(_t('signature_hint')),
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
            onPressed: (!_isComplete || widget.isLocked) ? null : () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Módulo Finalizado')));
            },
            icon: const Icon(LucideIcons.checkCircle),
            label: Text(_t('btn_finish')),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
