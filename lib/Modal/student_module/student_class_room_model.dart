class ClassRoomDataList {
  static List<StudentClassRoomModel> classRoomlist = [];
}

class StudentClassRoomModel {
  int? id;
  String? forStuEmp;
  int? circularId;
  String? circularDate;
  String? cirNo;
  int? cirSubject;
  String? cirContent;
  int? forAll;
  int? classId;
  int? sectionId;
  int? streamId;
  int? yearId;
  int? groupId;
  int? isActive;
  int? meetingId;
  String? circularFileUrl;
  int? empId;
  int? classroomId;
  String? stuEmpType;
  int? stuEmpId;
  String? subjectName;
  String? circularDateFormatted;
  String? subjectHead;

  StudentClassRoomModel({
    this.id,
    this.forStuEmp,
    this.circularId,
    this.circularDate,
    this.cirNo,
    this.cirSubject,
    this.cirContent,
    this.forAll,
    this.classId,
    this.sectionId,
    this.streamId,
    this.yearId,
    this.groupId,
    this.isActive,
    this.meetingId,
    this.circularFileUrl,
    this.empId,
    this.classroomId,
    this.stuEmpType,
    this.stuEmpId,
    this.subjectName,
    this.circularDateFormatted,
    this.subjectHead,
  });

  StudentClassRoomModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    forStuEmp = json['ForStuEmp'] ?? "";
    circularId = json['CircularId'] ?? 0;
    circularDate = json['CircularDate'] ?? "";
    cirNo = json['CirNo'] ?? "";
    cirSubject = json['CirSubject'] ?? 0;
    cirContent = json['CirContent'] ?? "";
    forAll = json['ForAll'] ?? 0;
    classId = json['ClassId'] ?? 0;
    sectionId = json['SectionId'] ?? 0;
    streamId = json['StreamId'] ?? 0;
    yearId = json['YearId'] ?? 0;
    groupId = json['GroupId'] ?? 0;
    isActive = json['isActive'] ?? 0;
    meetingId = json['MeetingId'] ?? 0;
    circularFileUrl = json['CircularFileurl'] ?? "";
    empId = json['EMPID'] ?? 0;
    classroomId = json['classroomid'] ?? 0;
    stuEmpType = json['stuemptype'] ?? "";
    stuEmpId = json['stuempid'] ?? 0;
    subjectName = json['SubjectName'] ?? "";
    circularDateFormatted = json['CircularDate1'] ?? "";
    subjectHead = json['subjecthead'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ForStuEmp'] = forStuEmp;
    data['CircularId'] = circularId;
    data['CircularDate'] = circularDate;
    data['CirNo'] = cirNo;
    data['CirSubject'] = cirSubject;
    data['CirContent'] = cirContent;
    data['ForAll'] = forAll;
    data['ClassId'] = classId;
    data['SectionId'] = sectionId;
    data['StreamId'] = streamId;
    data['YearId'] = yearId;
    data['GroupId'] = groupId;
    data['isActive'] = isActive;
    data['MeetingId'] = meetingId;
    data['CircularFileurl'] = circularFileUrl;
    data['EMPID'] = empId;
    data['classroomid'] = classroomId;
    data['stuemptype'] = stuEmpType;
    data['stuempid'] = stuEmpId;
    data['SubjectName'] = subjectName;
    data['CircularDate1'] = circularDateFormatted;
    data['subjecthead'] = subjectHead;
    return data;
  }
}
