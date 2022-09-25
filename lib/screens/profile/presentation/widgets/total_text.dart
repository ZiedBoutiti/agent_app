


import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/styles.dart';
import 'package:flutter/material.dart';

///TOTAL TEXT VIEW
class TotalText extends StatelessWidget {
  final double price;
  final bool todayTotal;
  final int count;
  const TotalText({
    Key? key,
    required this.price,
    required this.count,
    required this.todayTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///get language
    var local = getAppLang(context);

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(
              top: 5,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(
                    'assets/shield.png',
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  '${todayTotal ? local.todayTasks : local.totalTasks}: $count',
                  style:
                  nameProfile.copyWith(color: fieldTextColor, fontSize: 15),
                  textAlign: TextAlign.left,
                )
              ],
            )),
        Container(
          margin: const EdgeInsets.only(
            top: 5,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.monetization_on,
                color: secColor,
                size: 35,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                '${todayTotal ? local.todayIncome : local.totalIncome}: $price',
                style:
                nameProfile.copyWith(color: fieldTextColor, fontSize: 15),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
      ],
    );
  }
}
