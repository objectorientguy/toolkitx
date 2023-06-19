import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../blocs/checklist/systemUser/pdf/sys_user_pdf_bloc.dart';
import '../../../../blocs/checklist/systemUser/pdf/sys_user_pdf_events.dart';
import '../../../../blocs/checklist/systemUser/pdf/sys_user_pdf_states.dart';
import '../../../../utils/constants/api_constants.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/custom_snackbar.dart';
import '../../../../widgets/progress_bar.dart';

class FetchPdfSection extends StatelessWidget {
  final String responseId;

  const FetchPdfSection({Key? key, required this.responseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchPdfBloc, FetchPdfStates>(
      listener: (context, state) {
        if (state is FetchingPdf) {
          ProgressBar.show(context);
        } else if (state is PdfFetched) {
          ProgressBar.dismiss(context);
          launchUrlString(
            '${ApiConstants.baseDocUrl}${state.decryptedFile}.pdf',
            mode: LaunchMode.externalApplication,
          );
        } else if (state is FetchPdfError) {
          ProgressBar.dismiss(context);
          showCustomSnackBar(context, StringConstants.kSomethingWentWrong,
              StringConstants.kOk);
        }
      },
      child: Visibility(
          visible: responseId != "",
          child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.topRight,
                shadowColor: Colors.transparent),
            onPressed: () {
              context
                  .read<FetchPdfBloc>()
                  .add(FetchPdf(responseId: responseId));
            },
            child: const Text('Download Pdf'),
          )),
    );
  }
}
