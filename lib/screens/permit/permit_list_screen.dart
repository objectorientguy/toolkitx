import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/permit/permit_bloc.dart';
import 'package:toolkit/blocs/permit/permit_events.dart';
import 'package:toolkit/blocs/permit/permit_states.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import 'package:toolkit/data/models/status_tag_model.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/screens/permit/widgets/date_time.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';
import '../../widgets/icon_and_text_row.dart';
import '../../widgets/status_tag.dart';

class PermitListScreen extends StatelessWidget {
  static const routeName = 'PermitListScreen';

  const PermitListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PermitBloc>().add(const GetAllPermits());
    return Scaffold(
        appBar: const GenericAppBar(title: 'Permit To Work'),
        body: Padding(
          padding: const EdgeInsets.only(
              left: leftRightMargin,
              right: leftRightMargin,
              top: midTiniestSpacing),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomIconButtonRow(
                isEnabled: true,
                primaryOnPress: () {},
                secondaryOnPress: () {},
                clearOnPress: () {}),
            const SizedBox(height: midTiniestSpacing),
            BlocBuilder<PermitBloc, PermitStates>(builder: (context, state) {
              if (state is AllPermitsFetched) {
                return Expanded(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.allPermitModel.data!.length,
                        itemBuilder: (context, index) {
                          return CustomCard(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: midTinySpacing),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PermitDetailsScreen.routeName);
                                },
                                title: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            state.allPermitModel.data![index]
                                                .permit!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .small
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.black)),
                                        const SizedBox(width: tiniestSpacing),
                                        Image.asset('assets/icons/warning.png',
                                            height: kImageHeight,
                                            width: kImageWidth)
                                      ],
                                    ),
                                    Text(
                                      state.allPermitModel.data![index].status!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .xSmall
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColor.deepBlue),
                                    ),
                                  ],
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      top: midTinySpacing),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.allPermitModel.data![index]
                                            .description!,
                                        maxLines: 3,
                                      ),
                                      const SizedBox(height: midTinySpacing),
                                      IconAndTextRow(
                                          title: state.allPermitModel
                                              .data![index].location!,
                                          icon: 'location'),
                                      const SizedBox(height: midTinySpacing),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconAndTextRow(
                                              title: state.allPermitModel
                                                  .data![index].pname!,
                                              icon: 'human_avatar_three'),
                                          IconAndTextRow(
                                              title: state.allPermitModel
                                                  .data![index].pcompany!,
                                              icon: 'office'),
                                        ],
                                      ),
                                      const SizedBox(height: midTinySpacing),
                                      DateTimeRow(
                                          allPermitDatum: state
                                              .allPermitModel.data![index]),
                                      const SizedBox(height: midTinySpacing),
                                      StatusTag(tags: [
                                        StatusTagModel(
                                            title: (state.allPermitModel
                                                        .data![index].expired ==
                                                    '2')
                                                ? 'Expired'
                                                : '',
                                            bgColor: AppColor.errorRed),
                                        StatusTagModel(
                                            title: (state
                                                        .allPermitModel
                                                        .data![index]
                                                        .npiStatus ==
                                                    '1')
                                                ? 'NPI'
                                                : '',
                                            bgColor: AppColor.yellow),
                                        StatusTagModel(
                                            title: (state
                                                        .allPermitModel
                                                        .data![index]
                                                        .npwStatus ==
                                                    '1')
                                                ? 'NPW'
                                                : '',
                                            bgColor: AppColor.yellow),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: tinySpacing);
                        }));
              } else if (state is FetchingAllPermits) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const SizedBox();
              }
            }),
          ]),
        ));
  }
}
