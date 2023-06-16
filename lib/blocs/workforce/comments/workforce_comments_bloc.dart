import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/workforce/comments/workforce_comments_events.dart';
import 'package:toolkit/blocs/workforce/comments/workforce_comments_states.dart';
import 'package:toolkit/repositories/workforce/workforce_repository.dart';

import '../../../data/cache/cache_keys.dart';
import '../../../data/cache/customer_cache.dart';
import '../../../data/models/workforce/workforce_fetch_comment_model.dart';
import '../../../data/models/workforce/workforce_save_comment_model.dart';
import '../../../di/app_module.dart';

class CommentBloc extends Bloc<CommentsEvent, CommentStates> {
  final WorkForceRepository _workForceRepository = getIt<WorkForceRepository>();
  final CustomerCache _customerCache = getIt<CustomerCache>();
  Map allDataForChecklistMap = {};
  String questionResponseId = '';

  CommentBloc() : super(CommentsInitial()) {
    on<FetchComment>(_fetchQuestionComments);
    on<SaveComment>(_saveQuestionComments);
  }

  FutureOr<void> _fetchQuestionComments(
      FetchComment event, Emitter<CommentStates> emit) async {
    emit(FetchingComment());
    try {
      log("comment mapp=========>$allDataForChecklistMap");
      allDataForChecklistMap["questionResponseId"] = event.questionResponseId;
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      GetQuestionCommentsModel getQuestionCommentsModel =
          await _workForceRepository.fetchComment(
              allDataForChecklistMap["questionResponseId"], hashCode);
      emit(CommentFetched(getQuestionCommentsModel: getQuestionCommentsModel));
    } catch (e) {
      emit(CommentNotFetched(
          quesResponseId: allDataForChecklistMap["questionResponseId"]));
    }
  }

  FutureOr<void> _saveQuestionComments(
      SaveComment event, Emitter<CommentStates> emit) async {
    emit(SavingComment());
    try {
      String hashCode = (await _customerCache.getHashCode(CacheKeys.hashcode))!;
      if (event.saveQuestionCommentMap["comments"] == null ||
          event.saveQuestionCommentMap["comments"].toString().trim().isEmpty) {
        emit(CommentNotSaved(message: 'Please enter comment!'));
      } else {
        Map saveQuestionCommentMap = {
          "id": allDataForChecklistMap["userId"],
          "queresponseid": allDataForChecklistMap["questionResponseId"],
          "comments": event.saveQuestionCommentMap["comments"],
          "filenames": '',
          "hashcode": hashCode
        };
        SaveQuestionCommentsModel saveQuestionCommentsModel =
            await _workForceRepository.saveComment(saveQuestionCommentMap);
        emit(
            CommentSaved(saveQuestionCommentsModel: saveQuestionCommentsModel));
        log("mapppp======>$saveQuestionCommentMap");
      }
    } catch (e) {
      emit(CommentNotSaved(message: e.toString()));
    }
  }
}
