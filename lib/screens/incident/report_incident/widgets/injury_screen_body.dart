import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_theme.dart';

import '../../../../blocs/report_new_incident/report_new_incident_bloc.dart';
import '../../../../blocs/report_new_incident/report_new_incident_states.dart';
import '../../../../configs/app_spacing.dart';
import '../../../../utils/constants/string_constants.dart';
import '../../../../widgets/primary_button.dart';
import '../../../onboarding/widgets/text_field.dart';
import '../../widgets/injury_grid_multi_select.dart';
import '../../widgets/injury_nature_expansion_tile.dart';

class InjuryScreenBody extends StatelessWidget {
  const InjuryScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportIncidentBloc, ReportIncidentStates>(
        builder: (context, state) {
      if (state is InjuriesScreenMultiselectLoaded) {
        return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringConstants.kNameOfInjuredPerson,
                    style: Theme.of(context).textTheme.medium),
                const SizedBox(height: tiniestSpacing),
                const TextFieldWidget(hintText: StringConstants.kName),
                const SizedBox(height: tinySpacing),
                Text(StringConstants.kCompanyOfInjuredPerson,
                    style: Theme.of(context).textTheme.medium),
                const SizedBox(height: tiniestSpacing),
                const TextFieldWidget(hintText: StringConstants.kCompanyName),
                const SizedBox(height: tinySpacing),
                Text(StringConstants.kNatureOfInjury,
                    style: Theme.of(context).textTheme.medium),
                const SizedBox(height: tiniestSpacing),
                InjuryNatureExpansionTile(
                    injuryNatureSelected: state.selectedInjuryNature,
                    selectedInjuredArea: state.selectedInjuredArea,
                    injuryNature: state.injuryNature),
                const SizedBox(height: tinySpacing),
                InjuryMultiSelect(
                    injuryNatureSelected: state.selectedInjuryNature,
                    selectedInjuredArea: state.selectedInjuredArea,
                    injuryArea: state.injuredArea),
                const SizedBox(height: mediumSpacing),
                PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textValue: StringConstants.kSave),
                const SizedBox(height: tinySpacing)
              ],
            ));
      } else {
        return const SizedBox();
      }
    });
  }
}
