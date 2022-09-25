import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/screens/common_widgets/service_widget.dart';
import 'package:agent/screens/monthly_orders/domain/utils.dart';
import 'package:agent/screens/profile/domain/notifier/profile_notifier.dart';
import 'package:agent/screens/tasks/data/models/agent_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOrders extends StatelessWidget {
  final List<Map<String, AgentOrder>> orders;

  const ListOrders({
    Key? key,
    required this.orders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///get language
    var local = getAppLang(context);

    final profileWatch = context.watch<ProfileProvider>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(local.invoiceNum)),
              Expanded(
                  flex: 2,
                  child: Text('${local.service} ${local.and} ${local.time}')),
              Text(local.price),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          color: primaryColor,
          height: 2,
        ),
        ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            shrinkWrap: true,
            itemCount: orders.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {

              final price = orders[index].values.single.orderItem.finalPrice == 0 ?
              orders[index].values.single.orderItem.price :
              orders[index].values.single.orderItem.finalPrice;

              return ListTile(
                  subtitle: Text(getTimeByLang(orders[index].values.single.time,
                      profileWatch.locale.languageCode)),
                  leading: SizedBox(
                      width: 80,
                      child: Text(
                        orders[index].values.single.invoiceNumber.toString(),
                        overflow: TextOverflow.ellipsis,
                      )),
                  trailing: Text(
                      '${price.toString()} ${local.kwd}'),
                  title: ServiceWidget(
                    id: orders[index].values.single.orderItem.serviceId,
                  ));
            }),
      ],
    );
  }
}
