import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../configs/app_color.dart';
import '../../../../data/models/checklist/workforce/workforce_questions_list_model.dart';

class QuestionListTitleSection extends StatelessWidget {
  final Questionlist questionList;

  const QuestionListTitleSection({Key? key, required this.questionList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RichText(
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          maxLines: 5,
          text: TextSpan(
              text: '${questionList.title}?',
              style: Theme.of(context)
                  .textTheme
                  .small
                  .copyWith(color: AppColor.black, fontWeight: FontWeight.w500),
              children: [
                (questionList.ismandatory == 1)
                    ? TextSpan(
                        text: ' *', style: Theme.of(context).textTheme.medium)
                    : const TextSpan()
              ])),
    );
  }
}
