import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toolkit/configs/app_dimensions.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../../../configs/app_spacing.dart';
import '../../../blocs/permit/permit_bloc.dart';
import '../../../blocs/permit/permit_events.dart';

class PTWActionMenu extends StatelessWidget {
  const PTWActionMenu({Key? key}) : super(key: key);

  PopupMenuItem _buildPopupMenuItem(context, String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Text(title, style: Theme.of(context).textTheme.xSmall),
    );
  }

  @override
  Widget build(BuildContext context) {
    List popUpMenuItems = [
      'Generate PDF',
    ];
    return PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCardRadius),
        ),
        iconSize: kIconSize,
        icon: const Icon(Icons.more_vert_outlined),
        offset: const Offset(0, xxTiniestSpacing),
        initialValue: 0,
        onSelected: (value) {
          context.read<PermitBloc>().add(const GeneratePDF());
        },
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) => [
              _buildPopupMenuItem(context, popUpMenuItems[0], 0),
            ]);
  }
}
