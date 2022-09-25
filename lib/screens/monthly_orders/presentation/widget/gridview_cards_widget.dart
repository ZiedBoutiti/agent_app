import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/screens/monthly_orders/domain/utils.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GridviewCardsWidget extends StatelessWidget {
  final List<String> dataList;
  //final List<Map<String, AgentOrder>> agentOrders;
  // final List<Map<String, List<Map<String, AgentOrder>>>> monthOrders;
  final bool monthly;

  const GridviewCardsWidget({
    Key? key,
    required this.dataList,
    this.monthly = false,
    //required this.agentOrders,
    //  required this.monthOrders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileWatch = context.watch<ProfileProvider>();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: dataList.length,
          itemBuilder: (BuildContext ctx, index) {

            String title = '';

            if (monthly) {
              title = getPeriod(
                  currentDate: dataList[index],
                  lang: profileWatch.locale.languageCode);
            } else {
              title = dataList[index];
            }

            return GestureDetector(
              onTap: () {
                if (monthly) {
                  ///navigate to Tasks Screen
                  Navigator.pushNamed(
                    context,
                    oneMonthOrdersRoute,
                    arguments: dataList[index],
                  );
                } else {
                  ///navigate to Tasks Screen
                  Navigator.pushNamed(
                    context,
                    monthlyOrdersRoute,
                    arguments: dataList[index],
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                      color: secondColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15)),
              ),
            );
          }),
    );
  }
}
