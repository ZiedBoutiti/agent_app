import 'package:agent/screens/monthly_orders/domain/utils.dart';
import 'package:agent/screens/monthly_orders/presentation/widget/gridview_cards_widget.dart';
import 'package:agent/screens/profile/presentation/widgets/not_found.dart';
import 'package:flutter/material.dart';

class YearlyOrders extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  const YearlyOrders({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///get YEARs
    List<String> dates = [];
    dates = getYearFromDate(data);

    return dates.isNotEmpty
        ? GridviewCardsWidget(
            dataList: dates,
         //monthOrders: [],
     // agentOrders: [],
          )
        : const NotFound();
  }
}
