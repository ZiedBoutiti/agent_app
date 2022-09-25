import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/app_bar.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/monthly_orders/domain/monthly_service.dart';
import 'package:agent/screens/monthly_orders/presentation/widget/gridview_cards_widget.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/profile/presentation/widgets/not_found.dart';
import 'package:agent/screens/tasks/common_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/utils.dart';

class MonthlyOrders extends StatelessWidget {
  final String year;
  const MonthlyOrders({Key? key, required this.year}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MonthlyService monthlyService = MonthlyService();

    ///get language
    var local = getAppLang(context);

    StreamLoading _streamLoading = StreamLoading();

    final profileWatch = context.watch<ProfileProvider>();

    return Scaffold(
        appBar: AgentBar(
          color: secondColor,
          title: year,
          context: context,
          showBack: true,
        ),
        body: FutureBuilder<DatabaseEvent>(
            future: monthlyService.getMonthsOfYearOrdersKey(year),
            builder:
                (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
              List<Widget> children = [];
              if (snapshot.hasError) {
                children = _streamLoading.hasError(snapshot);
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    children =
                        _streamLoading.connectionStateNone(local.noConnection);

                    break;
                  case ConnectionState.waiting:
                    children =
                        _streamLoading.connectionStateWaiting(local.wait);

                    break;
                  case ConnectionState.done:
                    if (snapshot.data!.snapshot.value == null) {
                      children = <Widget>[const NotFound()];
                    } else {


                      final json = snapshot.data!.snapshot.value
                          as Map<dynamic, dynamic>;

                      ///get months have agent orders
                      List<String> monthsOrder = getMonthOrders(json: json, context: context);



                      children = <Widget>[
                        ///year total income
                        Text(
                          '${local.totalIncome}: ${profileWatch.totalPrice} ${local.kwd}',
                          style: nameProfile.copyWith(
                              color: fieldTextColor, fontSize: 15),
                          textAlign: TextAlign.left,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        ///list of months
                        monthsOrder.isNotEmpty ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GridviewCardsWidget(
                              dataList: monthsOrder,
                              monthly: true,
                              //  monthOrders: monthsOrder,
                            )) :


                        const Center(child: NotFound())
                      ];
                    }
                    break;
                  case ConnectionState.active:
                    // TODO: Handle this case.
                    break;
                }
              }
              return SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              );
            }));
  }
}
