import 'package:flutter/material.dart';
import 'package:toolkit/configs/app_color.dart';
import 'package:toolkit/configs/app_theme.dart';
import '../../../configs/app_spacing.dart';

class CustomTimeline extends StatelessWidget {
  const CustomTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: mediumSpacing),
      child: ListView.builder(
        itemCount: 23,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildDateAndTime(index),
              const SizedBox(width: tinySpacing),
              _buildVerticalTimelinePath(index, context),
              const SizedBox(width: tinySpacing),
              _buildContent(index, context)
            ],
          );
        },
      ),
    );
  }

  Widget _buildVerticalTimelinePath(int index, context) {
    return Column(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.lightGrey,
          ),
        ),
        Visibility(
          visible: index != 23 - 1,
          child: Container(
            width: 1.0, // Adjust the width as needed
            height: MediaQuery.of(context).size.height *
                0.13, // Adjust the height as needed
            color: AppColor.lightGrey,
          ),
        )
      ],
    );
  }

  Widget _buildDateAndTime(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/calendar.png', height: 15, width: 15),
            const SizedBox(width: tiniestSpacing),
            const Text('24.05.2023')
          ],
        ),
        const SizedBox(height: midTiniestSpacing),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/icons/clock.png', height: 15, width: 15),
            const SizedBox(width: tiniestSpacing),
            const Text('03:30')
          ],
        )
      ],
    );
  }

  Widget _buildContent(int index, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sumit Despande',
          style: Theme.of(context).textTheme.small.copyWith(
              fontWeight: FontWeight.w700, color: AppColor.mediumBlack),
        ),
        const SizedBox(height: tiniestSpacing),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.490,
            child: Text(
              'The permit has been approved by : Service Department The permit has been approved by : Service Department',
              style: Theme.of(context)
                  .textTheme
                  .xSmall
                  .copyWith(color: AppColor.grey),
              maxLines: 5,
            )),
      ],
    );
  }
}
