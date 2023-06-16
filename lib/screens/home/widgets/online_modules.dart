import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/client/client_bloc.dart';
import '../../../blocs/client/client_events.dart';
import '../../../blocs/client/client_states.dart';
import '../../../configs/app_color.dart';
import '../../../configs/app_dimensions.dart';
import '../../../configs/app_spacing.dart';
import '../../../utils/constants/string_constants.dart';
import '../../../utils/database_utils.dart';
import '../../../widgets/error_section.dart';
import '../../checklist/checklist_list_screen.dart';
import '../../checklist/workforce/workforce_list_screen.dart';
import '../../incident/incident_list_screen.dart';
import '../../permit/permit_list_screen.dart';

class OnLineModules extends StatelessWidget {
  const OnLineModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientStates>(builder: (context, state) {
      if (state is HomeScreenFetching) {
        return Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
            child: const Center(child: CircularProgressIndicator()));
      }
      if (state is HomeScreenFetched) {
        return GridView.builder(
            primary: false,
            itemCount: state.availableModules.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: tinier,
                mainAxisSpacing: tinier),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                  onTap: () => navigateToModule(
                      state.availableModules[index].key, context),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kCardRadius)),
                      color: AppColor.lightestBlue,
                      shadowColor: AppColor.ghostWhite,
                      elevation: kCardElevation,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                child: Image.asset(
                                    state.availableModules[index].moduleImage,
                                    height: kModuleIconSize,
                                    width: kModuleIconSize)),
                            const SizedBox(height: xxTinySpacing),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: xxTiniestSpacing,
                                    right: xxTiniestSpacing),
                                child: Text(
                                    DatabaseUtil.getText(state
                                        .availableModules[index].moduleName),
                                    textAlign: TextAlign.center))
                          ])));
            });
      } else if (state is FetchHomeScreenError) {
        return Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
          child: Center(
              child: GenericReloadButton(
                  onPressed: () {
                    context.read<ClientBloc>().add(FetchHomeScreenData());
                  },
                  textValue: StringConstants.kReload)),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  navigateToModule(moduleKey, context) {
    switch (moduleKey) {
      case 'ptw':
        Navigator.pushNamed(context, PermitListScreen.routeName);
        break;
      case 'hse':
        Navigator.pushNamed(context, IncidentListScreen.routeName);
        break;
      case 'checklist':
        Navigator.pushNamed(context, ChecklistScreen.routeName);
        break;
      case 'wf_checklist':
        Navigator.pushNamed(context, WorkForceListScreen.routeName);
        break;
    }
  }
}
