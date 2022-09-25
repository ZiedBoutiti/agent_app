import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/app_bar.dart';
import 'package:agent/screens/common_widgets/stream_messages.dart';
import 'package:agent/screens/monthly_orders/domain/monthly_service.dart';
import 'package:agent/screens/monthly_orders/domain/notifier/month_notifier.dart';
import 'package:agent/screens/monthly_orders/domain/utils.dart';
import 'package:agent/screens/monthly_orders/presentation/widget/day_panel_widget.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/profile/presentation/widgets/not_found.dart';
import 'package:agent/screens/tasks/common_utils.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:agent/screens/tasks/data/models/order.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OneMonthOrders extends StatelessWidget {
  final String date;
  const OneMonthOrders({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///Monthly service
    MonthlyService monthlyService = MonthlyService();

    ///get language
    var local = getAppLang(context);

    final profileWatch = context.watch<ProfileProvider>();

    final monthlyProvider = context.watch<MonthlyProvider>();

    StreamLoading _streamLoading = StreamLoading();

    ///View
    return Scaffold(
      appBar: AgentBar(
        color: secondColor,
        title:
            '${getPeriod(currentDate: date, lang: profileWatch.locale.languageCode)} [${date.substring(0, 4)}]',
        context: context,
        showBack: true,
      ),
      body: FutureBuilder<DatabaseEvent>(
          future: monthlyService.getOrdersByMonthStream(date: date),
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
                  children = _streamLoading.connectionStateWaiting(local.wait);

                  break;
                case ConnectionState.done:
                  if (snapshot.data!.snapshot.value == null) {
                    children = <Widget>[const NotFound()];
                  } else {
                    final json =
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;

                    ///Orders [key,values] (key = root)
                    List<Map<String, List<Map<String, Order>>>> dayOrders = [];

                    dayOrders = getDayOrders(json);

                    ///list orders in one month
                    List<Map<String, List<Map<String, AgentOrder>>>>
                        agentMonthOrders =
                        fetchListOrdersInMonth(dayOrders, context);



                    if (agentMonthOrders.isEmpty) {
                      children = <Widget>[const NotFound()];
                    } else {
                      children = <Widget>[
                        Text(
                          '${local.totalIncome}: ${monthlyProvider.totalIncome} ${local.kwd}',
                          style: nameProfile.copyWith(
                              color: fieldTextColor, fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DayPanelWidget(
                          orders: agentMonthOrders,
                          lang: profileWatch.locale.languageCode,
                        )
                      ];
                    }
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
          }),
    );
  }
}
