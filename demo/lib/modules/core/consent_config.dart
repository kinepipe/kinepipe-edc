class ConsentConfig {
  // Grupos Especiales
  final bool isForMinors;
  final bool isForElderly;
  final bool isForCognitiveDisability;
  final bool isForVisualDisability;
  final bool isForHearingDisability;
  final bool isForMotorDisability;
  final bool isForPsychiatricDisability;

  // Validaciones Globales
  final bool requireSignature;
  final bool requirePhoto;
  final bool requireAudio;
  final bool requireBiometrics;
  final bool requireSSOConfirmation;

  // Documento
  final String? documentPath;
  final String? documentContent; // Para Markdown directo

  ConsentConfig({
    this.isForMinors = false,
    this.isForElderly = false,
    this.isForCognitiveDisability = false,
    this.isForVisualDisability = false,
    this.isForHearingDisability = false,
    this.isForMotorDisability = false,
    this.isForPsychiatricDisability = false,
    this.requireSignature = true,
    this.requirePhoto = false,
    this.requireAudio = false,
    this.requireBiometrics = false,
    this.requireSSOConfirmation = false,
    this.documentPath,
    this.documentContent,
  });

  ConsentConfig copyWith({
    bool? isForMinors,
    bool? isForElderly,
    bool? isForCognitiveDisability,
    bool? isForVisualDisability,
    bool? isForHearingDisability,
    bool? isForMotorDisability,
    bool? isForPsychiatricDisability,
    bool? requireSignature,
    bool? requirePhoto,
    bool? requireAudio,
    bool? requireBiometrics,
    bool? requireSSOConfirmation,
    String? documentPath,
    String? documentContent,
  }) {
    return ConsentConfig(
      isForMinors: isForMinors ?? this.isForMinors,
      isForElderly: isForElderly ?? this.isForElderly,
      isForCognitiveDisability: isForCognitiveDisability ?? this.isForCognitiveDisability,
      isForVisualDisability: isForVisualDisability ?? this.isForVisualDisability,
      isForHearingDisability: isForHearingDisability ?? this.isForHearingDisability,
      isForMotorDisability: isForMotorDisability ?? this.isForMotorDisability,
      isForPsychiatricDisability: isForPsychiatricDisability ?? this.isForPsychiatricDisability,
      requireSignature: requireSignature ?? this.requireSignature,
      requirePhoto: requirePhoto ?? this.requirePhoto,
      requireAudio: requireAudio ?? this.requireAudio,
      requireBiometrics: requireBiometrics ?? this.requireBiometrics,
      requireSSOConfirmation: requireSSOConfirmation ?? this.requireSSOConfirmation,
      documentPath: documentPath ?? this.documentPath,
      documentContent: documentContent ?? this.documentContent,
    );
  }

  Map<String, dynamic> toJson() => {
    'isForMinors': isForMinors,
    'isForElderly': isForElderly,
    'isForCognitiveDisability': isForCognitiveDisability,
    'isForVisualDisability': isForVisualDisability,
    'isForHearingDisability': isForHearingDisability,
    'isForMotorDisability': isForMotorDisability,
    'isForPsychiatricDisability': isForPsychiatricDisability,
    'requireSignature': requireSignature,
    'requirePhoto': requirePhoto,
    'requireAudio': requireAudio,
    'requireBiometrics': requireBiometrics,
    'requireSSOConfirmation': requireSSOConfirmation,
    'documentPath': documentPath,
    'documentContent': documentContent,
  };

  factory ConsentConfig.fromJson(Map<String, dynamic> json) => ConsentConfig(
    isForMinors: json['isForMinors'] ?? false,
    isForElderly: json['isForElderly'] ?? false,
    isForCognitiveDisability: json['isForCognitiveDisability'] ?? false,
    isForVisualDisability: json['isForVisualDisability'] ?? false,
    isForHearingDisability: json['isForHearingDisability'] ?? false,
    isForMotorDisability: json['isForMotorDisability'] ?? false,
    isForPsychiatricDisability: json['isForPsychiatricDisability'] ?? false,
    requireSignature: json['requireSignature'] ?? true,
    requirePhoto: json['requirePhoto'] ?? false,
    requireAudio: json['requireAudio'] ?? false,
    requireBiometrics: json['requireBiometrics'] ?? false,
    requireSSOConfirmation: json['requireSSOConfirmation'] ?? false,
    documentPath: json['documentPath'],
    documentContent: json['documentContent'],
  );
}
