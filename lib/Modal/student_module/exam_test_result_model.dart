class ExamTestResultModel {
  final int examId;
  final String exam;
  final String subjectName;
  final String isAbsent;
  final double maxMarks;
  final String total;
  final String grades;
  final String percentage;
  final String subAssessment;
  final int displayOrderNo;

  ExamTestResultModel({
    required this.examId,
    required this.exam,
    required this.subjectName,
    required this.isAbsent,
    required this.maxMarks,
    required this.total,
    required this.grades,
    required this.percentage,
    required this.subAssessment,
    required this.displayOrderNo,
  });

  factory ExamTestResultModel.fromJson(Map<String, dynamic> json) {
    return ExamTestResultModel(
      examId: json['ExamId'] ?? 0,
      exam: json['Exam'] ?? '',
      subjectName: json['SubjectName'] ?? '',
      isAbsent: json['isabsent'] ?? 'N',
      maxMarks: (json['maxmarks'] ?? 0.0).toDouble(),
      total: json['total'] ?? '0',
      grades: json['Grades'] ?? '',
      percentage: json['percentage'] ?? '0.0',
      subAssessment: json['Subassessment'] ?? '',
      displayOrderNo: json['DisplayOrderNo'] ?? 0,
    );
  }

  // Method to convert an instance to a map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'ExamId': examId,
      'Exam': exam,
      'SubjectName': subjectName,
      'isabsent': isAbsent,
      'maxmarks': maxMarks,
      'total': total,
      'Grades': grades,
      'percentage': percentage,
      'Subassessment': subAssessment,
      'DisplayOrderNo': displayOrderNo,
    };
  }
}
