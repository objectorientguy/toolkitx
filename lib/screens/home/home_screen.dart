import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/blocs/client/client_bloc.dart';
import 'package:toolkit/blocs/client/client_events.dart';
import 'package:toolkit/blocs/client/client_states.dart';
import 'package:toolkit/blocs/home/home_bloc.dart';
import 'package:toolkit/blocs/home/home_events.dart';
import 'package:toolkit/screens/home/widgets/date_time_section.dart';
import 'package:toolkit/screens/home/widgets/modules_grid_layout.dart';

import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const SetDateAndTime());
    context.read<HomeBloc>().add(const StartTimer());
    context.read<ClientBloc>().add(FetchHomeScreenData());
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(kBodyMargin),
            child: BlocBuilder<ClientBloc, ClientStates>(
                builder: (context, state) {
              if (state is HomeScreenFetching) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeScreenFetched) {
                return Column(children: [
                  const SizedBox(height: xxxSmallerSpacing),
                  CachedNetworkImage(
                      height: kHomeScreenImageHeight,
                      imageUrl: state.image,
                      placeholder: (context, url) => const Center(
                            child: SizedBox(
                              height: kImageCircularProgressIndicatorSize,
                              width: kImageCircularProgressIndicatorSize,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline_sharp,
                          size: kIconSize)),
                  const SizedBox(height: xxxSmallerSpacing),
                  DateAndTimeSection(
                      dateTimeOffset:
                          state.processClientModel.data!.timezoneoffset!),
                  const SizedBox(height: xxxSmallerSpacing),
                  Expanded(
                      child: ScrollConfiguration(
                          behavior: const ScrollBehavior()
                              .copyWith(overscroll: false),
                          child: SingleChildScrollView(
                              child: ModulesGridLayout(
                                  availableModules: state.availableModules)))),
                ]);
              } else {
                return const SizedBox();
              }
            })));
  }
}
