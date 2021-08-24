//import 'package:eclinic_mobile/modules/patient_view/medical_record.dart';

class MedicalRecordModel {
  //int? id;
  Map<String,dynamic>? patientData;
  String? patient;
  int? socialID;
  String? biometricID;
  bool? tobacoConsumption;
  String? tobacoTakenAs;
  int? numberUnits;
  bool ? alcoholConsumption;
  bool? medicationConsumption;
  String ?medications;
  String? other;
  String? generalDiseases;
  String? surgicalIntervention;
  String? congenitalCondition;
  String? allergicReaction;
  String? wieght;
  String? height;
  String? hearingRight;
  String? hearingLeft;
  String? visualAcuityWithCorrectionLeft;
  String? visualAcuityWithCorrectionRight;
  String? visualAcuityWithoutCorrectionLeft;
  String? visualAcuityWithoutCorrectionRight;
  String? skinState;
  String? skinExam;
  String? ophtalmologicalState;
  String? ophtalmologicalExam;
  String? orlState;
  String? orlExam;
  String? locomotorCase;
  String? locomotorExam;
  String? respiratoryState;
  String? respiratoryExam;
  String? cardiovascularState;
  String? cardiovascularExam;
  String? digestiveState;
  String? digestiveExam;
  bool? aptitude;
  String? reason;
  String? orientationSpecialist;
  String? orientationCause;
  String? orientationResponse;

  MedicalRecordModel({
    this.patientData,
    this.patient,
    this.socialID,
    this.biometricID,
    this.tobacoConsumption,
    tobacoTakenAs,
    this.numberUnits,
    this.alcoholConsumption,
    this.medicationConsumption,
    this.medications,
    this.other,
    this.generalDiseases,
    this.surgicalIntervention,
    this.congenitalCondition,
    this.allergicReaction,
    this.wieght,
    this.height,
    this.hearingRight,
    this.hearingLeft,
    this.visualAcuityWithCorrectionLeft,
    this.visualAcuityWithCorrectionRight,
    this.visualAcuityWithoutCorrectionLeft,
    this.visualAcuityWithoutCorrectionRight,
    this.skinState,
    this.skinExam,
    this.ophtalmologicalState,
    this.ophtalmologicalExam,
    this.orlState,
    this.orlExam,
    this.locomotorCase,
    this.locomotorExam,
    this.respiratoryState,
    this.respiratoryExam,
    this.cardiovascularState,
    this.cardiovascularExam,
    this.digestiveState,
    this.digestiveExam,
    this.aptitude,
    this.reason,
    this.orientationSpecialist,
    this.orientationCause,
    this.orientationResponse,
  });
  

  MedicalRecordModel? fromJson(Map<String,dynamic>json){
    //id=json['id'];
    patientData=json["patient_data"];
    patient=json["patient"];
    socialID=json["social_number"];
    biometricID=json["biometric"];
    tobacoConsumption=json["tobaco_consumption"];
    tobacoTakenAs=json["tobaco_taken_as"];
    numberUnits=json["number_units"];
    alcoholConsumption=json["alcohol_consumption"];
    medicationConsumption=json["medication_consumption"];
    medications=json["medications"];
    other=json["other"];
    generalDiseases=json["general_diseases"];
    surgicalIntervention=json["surgical_intervention"];
    congenitalCondition=json["congenital_condition"];
    allergicReaction=json["allergic_reaction"];
    wieght=json["wieght"];
    height=json["height"];
    hearingRight=json["hearing_right"];
    hearingLeft=json["hearing_left"];
    visualAcuityWithCorrectionLeft=json["visual_acuity_with_correction_left"];
    visualAcuityWithCorrectionRight=json["visual_acuity_with_correction_right"];
    visualAcuityWithoutCorrectionLeft=json["visual_acuity_without_correction_left"];
    visualAcuityWithoutCorrectionRight=json["visual_acuity_without_correction_right"];
    skinState=json["skin_state"];
    skinExam=json["skin_exam"];
    ophtalmologicalState=json["ophtalmological_state"];
    ophtalmologicalExam=json["ophtalmological_exam"];
    orlState=json["orl_state"];
    orlExam=json["orl_exam"];
    locomotorCase=json["locomotor_case"];
    locomotorExam=json["locomotor_exam"];
    respiratoryState=json["respiratory_state"];
    respiratoryExam=json["respiratory_exam"];
    cardiovascularState=json["cardiovascular_state"];
    cardiovascularExam=json["cardiovascular_exam"];
    digestiveState=json["digestive_state"];
    digestiveExam=json["digestive_exam"];
    aptitude=json["aptitude"];
    reason=json["reason"];
    orientationSpecialist=json["orientation_specialist"];
    orientationCause=json["orientation_cause"];
    orientationResponse=json["orientation_response"];
  }
}