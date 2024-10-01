class HomeworkCommentModel {
  int? replyId;
  int? homeworkId;
  String? commentDate1;
  String? comment;
  int? toReplyCommentId;
  String? fileUrl;
  String? userType;
  int? toReply;

  HomeworkCommentModel({
    this.replyId,
    this.homeworkId,
    this.commentDate1,
    this.comment,
    this.toReplyCommentId,
    this.fileUrl,
    this.userType,
    this.toReply,
  });

  factory HomeworkCommentModel.fromJson(Map<String, dynamic> json) {
    return HomeworkCommentModel(
      replyId: json['ReplyId'],
      homeworkId: json['HomeworkId'],
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
      'ReplyId': replyId,
      'HomeworkId': homeworkId,
      'CommentDate1': commentDate1,
      'Comment': comment,
      'toreplycommentId': toReplyCommentId,
      'FileUrl': fileUrl,
      'UserType': userType,
      'toreply': toReply,
    };
  }
}
