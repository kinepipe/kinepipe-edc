import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactInfo {
  final String name;
  final String relation; // padre, madre, esposo/a, otro
  final String customRelation; // para cuando elige "otro"
  final String phone;

  ContactInfo({this.name = '', this.relation = '', this.customRelation = '', this.phone = ''});

  ContactInfo copyWith({String? name, String? relation, String? customRelation, String? phone}) {
    return ContactInfo(
      name: name ?? this.name,
      relation: relation ?? this.relation,
      customRelation: customRelation ?? this.customRelation,
      phone: phone ?? this.phone,
    );
  }
}

class PatientData {
  final String firstName;
  final String lastName1;
  final String lastName2;
  final DateTime? dateOfBirth;
  final int? manualAge;
  final bool isAgeUnknown;
  final String gender;
  final String email;
  final String phone;
  final String idNumber; // RUT / RUN / PASSPORT
  final String address;
  final String insurance;
  final ContactInfo tutorInfo;
  final List<ContactInfo> emergencyContacts;

  final String idHash; // Hash SHA-256

  PatientData({
    this.firstName = '',
    this.lastName1 = '',
    this.lastName2 = '',
    this.dateOfBirth,
    this.manualAge,
    this.isAgeUnknown = false,
    this.gender = '',
    this.email = '',
    this.phone = '',
    this.idNumber = '',
    this.address = '',
    this.insurance = '',
    ContactInfo? tutorInfo,
    List<ContactInfo>? emergencyContacts,
    String? idHash,
  }) : tutorInfo = tutorInfo ?? ContactInfo(),
       emergencyContacts = emergencyContacts ?? [],
       idHash = idHash ?? _generateHash(idNumber, firstName, lastName1, dateOfBirth);

  static String _generateHash(String rut, String fName, String lName, DateTime? dob) {
    if (rut.isEmpty && fName.isEmpty) return '';
    final dobStr = dob != null ? '${dob.year}${dob.month}${dob.day}' : 'nodob';
    final rawString = '${rut.trim().toLowerCase()}_${fName.trim().toLowerCase()}_${lName.trim().toLowerCase()}_$dobStr';
    final bytes = utf8.encode(rawString);
    return sha256.convert(bytes).toString();
  }

  int? get calculatedAge {
    if (isAgeUnknown) return manualAge;
    if (dateOfBirth == null) return null;
    
    final today = DateTime.now();
    int age = today.year - dateOfBirth!.year;
    if (today.month < dateOfBirth!.month || 
        (today.month == dateOfBirth!.month && today.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  bool get requiresTutor {
    final age = calculatedAge;
    if (age == null) return false;
    return age < 18 || age > 75;
  }

  String get fullName => '$firstName $lastName1 $lastName2'.trim();

  PatientData copyWith({
    String? firstName,
    String? lastName1,
    String? lastName2,
    DateTime? dateOfBirth,
    int? manualAge,
    bool? isAgeUnknown,
    String? gender,
    String? email,
    String? phone,
    String? idNumber,
    String? address,
    String? insurance,
    ContactInfo? tutorInfo,
    List<ContactInfo>? emergencyContacts,
    String? idHash,
  }) {
    return PatientData(
      firstName: firstName ?? this.firstName,
      lastName1: lastName1 ?? this.lastName1,
      lastName2: lastName2 ?? this.lastName2,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      manualAge: manualAge ?? this.manualAge,
      isAgeUnknown: isAgeUnknown ?? this.isAgeUnknown,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      idNumber: idNumber ?? this.idNumber,
      address: address ?? this.address,
      insurance: insurance ?? this.insurance,
      tutorInfo: tutorInfo ?? this.tutorInfo,
      emergencyContacts: emergencyContacts ?? this.emergencyContacts,
      idHash: idHash ?? _generateHash(
        idNumber ?? this.idNumber, 
        firstName ?? this.firstName, 
        lastName1 ?? this.lastName1, 
        dateOfBirth ?? this.dateOfBirth
      ),
    );
  }
}

class PatientDataNotifier extends Notifier<PatientData> {
  @override
  PatientData build() {
    return PatientData();
  }

  void updateField({
    String? firstName,
    String? lastName1,
    String? lastName2,
    DateTime? dateOfBirth,
    int? manualAge,
    bool? isAgeUnknown,
    String? gender,
    String? email,
    String? phone,
    String? idNumber,
    String? address,
    String? insurance,
    ContactInfo? tutorInfo,
    List<ContactInfo>? emergencyContacts,
  }) {
    state = state.copyWith(
      firstName: firstName,
      lastName1: lastName1,
      lastName2: lastName2,
      dateOfBirth: dateOfBirth,
      manualAge: manualAge,
      isAgeUnknown: isAgeUnknown,
      gender: gender,
      email: email,
      phone: phone,
      idNumber: idNumber,
      address: address,
      insurance: insurance,
      tutorInfo: tutorInfo,
      emergencyContacts: emergencyContacts,
    );
  }

  void addEmergencyContact(ContactInfo contact) {
    state = state.copyWith(emergencyContacts: [...state.emergencyContacts, contact]);
  }

  void removeEmergencyContact(int index) {
    final newList = List<ContactInfo>.from(state.emergencyContacts);
    newList.removeAt(index);
    state = state.copyWith(emergencyContacts: newList);
  }

  void updateEmergencyContact(int index, ContactInfo contact) {
    final newList = List<ContactInfo>.from(state.emergencyContacts);
    newList[index] = contact;
    state = state.copyWith(emergencyContacts: newList);
  }
}

final patientDataProvider = NotifierProvider<PatientDataNotifier, PatientData>(PatientDataNotifier.new);
