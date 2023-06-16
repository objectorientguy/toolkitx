import 'package:equatable/equatable.dart';

import '../../../data/models/workforce/workforce_fetch_comment_model.dart';
import '../../../data/models/workforce/workforce_save_comment_model.dart';

abstract class CommentStates extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CommentsInitial extends CommentStates {}

class FetchingComment extends CommentStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CommentFetched extends CommentStates {
  final GetQuestionCommentsModel getQuestionCommentsModel;

  CommentFetched({required this.getQuestionCommentsModel});

  @override
  List<Object?> get props => [getQuestionCommentsModel];
}

class CommentNotFetched extends CommentStates {
  final String quesResponseId;

  CommentNotFetched({required this.quesResponseId});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SavingComment extends CommentStates {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CommentSaved extends CommentStates {
  final SaveQuestionCommentsModel saveQuestionCommentsModel;

  CommentSaved({required this.saveQuestionCommentsModel});

  @override
  List<Object?> get props => [saveQuestionCommentsModel];
}

class CommentNotSaved extends CommentStates {
  final String message;

  CommentNotSaved({required this.message});

  @override
  List<Object?> get props => throw UnimplementedError();
}
