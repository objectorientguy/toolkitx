import 'package:flutter/material.dart';
import 'package:toolkit/screens/onboarding/widgets/custom_card.dart';
import 'package:toolkit/screens/permit/permit_details_screen.dart';
import 'package:toolkit/widgets/generic_app_bar.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import '../../widgets/custom_icon_button_row.dart';

class PermitScreen extends StatelessWidget {
  static const routeName = 'PermitScreen';

  const PermitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        title: 'Permit To Work',
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            left: leftRightMargin,
            right: leftRightMargin,
            top: midTiniestSpacing),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomIconButtonRow(
              primaryOnPress: () {},
              secondaryOnPress: () {},
              clearOnPress: () {}),
          const SizedBox(height: midTiniestSpacing),
          Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.only(top: midTinySpacing),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, PermitDetailsScreen.routeName);
                          },
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('WP - 00197 (!)'),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height:
                                    MediaQuery.of(context).size.width * 0.050,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'REQUESTED',
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: midTinySpacing),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'This is just a dummy permit This is just a dummy permit ',
                                  maxLines: 2,
                                ),
                                const SizedBox(height: midTinySpacing),
                                const Text('Andrew oil field'),
                                const SizedBox(height: midTinySpacing),
                                const Text(
                                    'George M Mueller - Pandora-ICT GmbH'),
                                const SizedBox(height: midTinySpacing),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/icons/calendar.png',
                                            height: kImageHeight,
                                            width: kImageWidth),
                                        const SizedBox(width: tiniestSpacing),
                                        const Text('24.05.2023 - 30.05.2023 ')
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/icons/clock.png',
                                            height: kImageHeight,
                                            width: kImageWidth),
                                        const SizedBox(width: tiniestSpacing),
                                        const Text('03:30 - 03:39')
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: midTinySpacing),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      margin: const EdgeInsets.only(
                                          right: 5, bottom: 5),
                                      alignment: Alignment.center,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Expired',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          right: 5, bottom: 5),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'NPI',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                          right: 5, bottom: 5),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'NPW',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: tinySpacing);
                  })),
          const SizedBox(height: tinySpacing)
        ]),
      ),
    );
  }
}
