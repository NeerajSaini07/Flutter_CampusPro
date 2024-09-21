class ClassRoomCommentModel {
  int? commentId;
  int? circularId;
  String? commentDate1;
  String? comment;
  int? toReplyCommentId;
  String? fileUrl;
  String? userType;
  int? toReply;

  ClassRoomCommentModel({
    this.commentId,
    this.circularId,
    this.commentDate1,
    this.comment,
    this.toReplyCommentId,
    this.fileUrl,
    this.userType,
    this.toReply,
  });

  factory ClassRoomCommentModel.fromJson(Map<String, dynamic> json) {
    return ClassRoomCommentModel(
      commentId: json['CommentId'],
      circularId: json['CircularId'],
      commentDate1: json['CommentDate1'],
      comment: json['Comment'],
      toReplyCommentId: json['toreplycommentId'],
      fileUrl: json['FileUrl'],
      userType: json['UserType'],
      toReply: json['toreply'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CommentId': commentId,
      'CircularId': circularId,
      'CommentDate1': commentDate1,
      'Comment': comment,
      'toreplycommentId': toReplyCommentId,
      'FileUrl': fileUrl,
      'UserType': userType,
      'toreply': toReply,
    };
  }
}
