import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/client/client_bloc.dart';
import 'package:toolkit/blocs/client/client_states.dart';
import 'package:toolkit/configs/app_spacing.dart';
import 'package:toolkit/widgets/custom_card.dart';
import 'package:toolkit/screens/root/root_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';
import 'package:toolkit/widgets/error_section.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';

import '../../blocs/client/client_events.dart';
import '../../configs/app_dimensions.dart';

class ClientListScreen extends StatelessWidget {
  static const routeName = 'ClientListScreen';

  const ClientListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ClientBloc>().add(FetchClientList());
    return Scaffold(
        appBar: GenericAppBar(title: DatabaseUtil.getText('ClientList')),
        body: BlocConsumer<ClientBloc, ClientStates>(
            buildWhen: (previousState, currentState) =>
                currentState is ClientListFetching ||
                currentState is ClientListFetched ||
                currentState is FetchClientListError,
            listener: (context, state) {
              if (state is ClientListFetched) {
                if (state.clientListModel.data!.length == 1) {
                  Navigator.pushNamed(context, RootScreen.routeName,
                      arguments: true);
                }
              }
            },
            builder: (context, state) {
              if (state is ClientListFetching) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ClientListFetched) {
                return Padding(
                  padding: const EdgeInsets.only(
                      left: leftRightMargin,
                      right: leftRightMargin,
                      top: topBottomPadding),
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(children: [
                        ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.clientListModel.data!.length,
                            itemBuilder: (context, index) {
                              return CustomCard(
                                  child: InkWell(
                                      onTap: () {
                                        context
                                            .read<ClientBloc>()
                                            .add(
                                                SelectClient(
                                                    hashKey: state
                                                        .clientListModel
                                                        .data![index]
                                                        .hashkey
                                                        .toString(),
                                                    apiKey: state
                                                        .clientListModel
                                                        .data![index]
                                                        .apikey,
                                                    image: state.clientListModel
                                                        .data![index].hashimg));
                                        Navigator.pushNamed(
                                            context, RootScreen.routeName,
                                            arguments: true);
                                      },
                                      child: CachedNetworkImage(
                                          fit: BoxFit.fitHeight,
                                          imageUrl: state.clientListModel
                                              .data![index].hashimg,
                                          placeholder: (context, url) => const Center(
                                              child: SizedBox(
                                                  height:
                                                      kImageCircularProgressIndicatorSize,
                                                  width:
                                                      kImageCircularProgressIndicatorSize,
                                                  child: CircularProgressIndicator(
                                                      strokeWidth:
                                                          kCircularIndicatorStrokeWidth))),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                                  Icons.error_outline_sharp,
                                                  size: kIconSize))));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: xxxSmallerSpacing);
                            }),
                        const SizedBox(height: topBottomPadding)
                      ])),
                );
              } else if (state is FetchClientListError) {
                return Center(
                  child: GenericReloadButton(
                      onPressed: () {
                        context.read<ClientBloc>().add(FetchClientList());
                      },
                      textValue: StringConstants.kReload),
                );
              } else {
                return const SizedBox();
              }
            }));
  }
}
