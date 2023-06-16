abstract class CommentsEvent {}

class FetchComment extends CommentsEvent {
  final String questionResponseId;

  FetchComment({required this.questionResponseId});
}

class SaveComment extends CommentsEvent {
  final Map saveQuestionCommentMap;

  SaveComment({required this.saveQuestionCommentMap});
}
