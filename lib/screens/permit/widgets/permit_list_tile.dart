import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/utils/constants/string_constants.dart';
import 'package:toolkit/utils/database_utils.dart';

import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_events.dart';
import '../../../blocs/permit/permit_states.dart';
import '../../../configs/app_spacing.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/custom_snackbar.dart';
import 'permit_list_tile_title.dart';
import 'permit_list_time_subtitle.dart';

class PermitListTile extends StatefulWidget {
  final bool isFromHome;
  final int page;

  const PermitListTile({Key? key, required this.page, required this.isFromHome})
      : super(key: key);

  @override
  State<PermitListTile> createState() => _PermitListTileState();
}

class _PermitListTileState extends State<PermitListTile> {
  var controller = ScrollController(keepScrollOffset: true);
  static List permitListData = [];
  static bool? noMoreData;
  static bool? waitForData;
  static int pageNo = 1;

  @override
  void initState() {
    pageNo = widget.page;
    noMoreData = false;
    permitListData.clear();
    log("pageNo=====>${widget.page}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("SizedBox=====>${context.read<PermitBloc>().state}");
    return BlocConsumer<PermitBloc, PermitStates>(
      buildWhen: (previousState, currentState) =>
          ((currentState is AllPermitsFetched && noMoreData != true) ||
              (currentState is FetchingAllPermits && permitListData.isEmpty)),
      builder: (context, state) {
        log("builder=====>${context.read<PermitBloc>().state}");
        if (state is AllPermitsFetched) {
          log("AllPermitsFetched=====>$AllPermitsFetched");
          if (state.allPermitModel.data!.isNotEmpty) {
            for (var item in state.allPermitModel.data!) {
              permitListData.add(item);
              log("list=====>$permitListData");
            }
            waitForData = false;
            return Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    controller: controller
                      ..addListener(() {
                        if (noMoreData != true && waitForData == false) {
                          if (controller.position.extentAfter < 500) {
                            pageNo++;
                            context.read<PermitBloc>().add(
                                GetAllPermits(page: pageNo, isFromHome: false));
                            waitForData = true;
                          }
                        }
                      }),
                    shrinkWrap: true,
                    itemCount: permitListData.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                          child: Padding(
                              padding: const EdgeInsets.only(top: tinier),
                              child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, PermitDetailsScreen.routeName,
                                        arguments: permitListData[index].id);
                                    log("onTap=====>${context.read<PermitBloc>().state}");
                                  },
                                  title: PermitListTileTitle(
                                      allPermitDatum: permitListData[index]),
                                  subtitle: PermitListTimeSubtitle(
                                      allPermitDatum: permitListData[index]))));
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: tinier);
                    }));
          } else {
            if (state.allPermitModel.status == 204) {
              if (state.filters.isEmpty) {
                return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: Text(DatabaseUtil.getText('no_records_found'))));
              } else {
                return Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3.5),
                        child: const Text(StringConstants.kNoRecordsFilter)));
              }
            } else {
              log("SizedBox=====>${context.read<PermitBloc>().state}");
              return const SizedBox();
            }
          }
        } else if (state is FetchingAllPermits) {
          log("FetchingAllPermits=====>$FetchingAllPermits");
          return Center(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3.5),
                  child: const CircularProgressIndicator()));
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is AllPermitsFetched) {
          if (state.allPermitModel.status == 204 && permitListData.isNotEmpty) {
            log("listenerr======>");
            noMoreData = true;
            log("noMoreData======>$noMoreData");
            showCustomSnackBar(context, StringConstants.kAllDataLoaded, '');
          }
        }
      },
    );
  }
}
