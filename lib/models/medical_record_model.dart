
class MedicalRecordModel {
  int? id;
  Map<String,dynamic>? patientData;
  String? patient;
  bool? smoking;
  bool? chewing;
  bool? injection;
  bool? oldSmoker;
  bool? alcohol;
  bool? medicationConsumption;
  int? smokingNumberUnits;
  int? chewingNumberUnits;
  int? injectionNumbernits;
  String? ageFc;
  String? duration;
  String? medication;
  String? familySituation;
  String?bloodType;
  String? socialNumber;
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
  String? respiratoryState;
  String? respiratoryExam;
  String? cardiovascularState;
  String? cardiovascularExam;
  String? digestiveState;
  String? digestiveExam;
  bool? aptitude;
  String? reason;
  String? orlState;
  String? orlExam;
  String? locomotorCase;
  String? locomotorExam;

  MedicalRecordModel({
    this.id,
    this.patientData,
    this.patient,
    this.smoking,
    this.chewing,
    this.injection,
    this.oldSmoker,
    this.alcohol,
    this.medicationConsumption,
    this.smokingNumberUnits,
    this.chewingNumberUnits,
    this.injectionNumbernits,
    this.ageFc,
    this.duration,
    this.medication,
    this.familySituation,
    this.bloodType,
    this.socialNumber,
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
    this.respiratoryState,
    this.respiratoryExam,
    this.cardiovascularState,
    this.cardiovascularExam,
    this.digestiveState,
    this.digestiveExam,
    this.aptitude,
    this.reason,
    this.orlState,
    this.orlExam,
    this.locomotorCase,
    this.locomotorExam,
  });
  

  MedicalRecordModel? fromJson(Map<String,dynamic>json){
    id=json['id'];
    patientData=json["patient_data"];
    patient=json["patient"];
    smoking=json["smoking"];
    chewing=json["chewing"];
    injection=json["injection"];
    oldSmoker=json["oldSmoker"];
    alcohol=json["alcohol"];
    medicationConsumption=json["medication_consumption"];
    smokingNumberUnits=json["smokingNumberUnits"];
    chewingNumberUnits=json["chewingNumberUnits"];
    injectionNumbernits=json["injectionNumbernits"];
    ageFc=json["ageFc"];
    duration=json["duration"];
    medication=json["medication"];
    familySituation=json["familySituation"];
    bloodType=json["bloodType"];
    socialNumber=json["social_number"];
    wieght=json["wieght"];
    height=json["height"];
    hearingRight=json["hearing_right"];
    hearingLeft=json["hearing_left"];
    visualAcuityWithCorrectionLeft=json["visual_acuity_with_correction_left"];
    visualAcuityWithCorrectionRight=json["visual_acuity_with_correction_right"];
    visualAcuityWithoutCorrectionLeft=json["visual_acuity_without_correction_left"];
    visualAcuityWithoutCorrectionRight=json["visual_acuity_without_correction_right"];
    ophtalmologicalState=json["ophtalmological_state"];
    ophtalmologicalExam=json["ophtalmological_exam"];
    skinState=json["skin_state"];
    skinExam=json["skin_exam"];
    ophtalmologicalState=json["ophtalmological_state"];
    ophtalmologicalExam=json["ophtalmological_exam"];
    respiratoryState=json["respiratory_state"];
    respiratoryExam=json["respiratory_exam"];
    cardiovascularState=json["cardiovascular_state"];
    cardiovascularExam=json["cardiovascular_exam"];
    digestiveState=json["digestive_state"];
    digestiveExam=json["digestive_exam"];
    aptitude=json["aptitude"];
    reason=json["reason"];
    orlState=json["orl_state"];
    orlExam=json["orl_exam"];
    locomotorCase=json["locomotor_case"];
    locomotorExam = json["locomotor_exam"];
  }
}