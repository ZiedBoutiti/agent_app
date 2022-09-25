// import 'package:agent/config/utils.dart';
// import 'package:agent/resources/colors.dart';
// import 'package:agent/resources/styles.dart';
// import 'package:agent/screens/common_widgets/app_bar.dart';
// import 'package:agent/screens/common_widgets/bottom_bar.dart';
// import 'package:agent/screens/common_widgets/custom_button.dart';
// import 'package:agent/screens/login/data/models/argument_data.dart';
// import 'package:agent/screens/login/domain/notifier/login_notifier.dart';
// import 'package:agent/screens/tasks/common_utils.dart';
// import 'package:agent/screens/tasks/data/order_detail.dart';
// import 'package:agent/screens/tasks/domain/notifier/task_notifier.dart';
// import 'package:agent/screens/tasks/domain/utils/common.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MobTasks extends StatelessWidget {
//   // final ArgumentData argumentData;
//   final List<OrderDetail> listOrder;
//   const MobTasks({Key? key, required this.listOrder}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final task = context.watch<TaskProvider>();
//     final login = context.watch<LoginProvider>();

//     return Container(
//       margin: EdgeInsets.only(top: getScreenHeight(context) / 2 * .1),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(
//               'Hi ${setCapitalize(login.argument.name.toUpperCase())},',
//               style: greetingText,
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: getScreenHeight(context) * .1),
//             child: ListView(
//               shrinkWrap: true,
//               children: [
//                 task.listCurrentOrder.isNotEmpty
//                     ? Wrap(
//                         children: List<Widget>.generate(
//                             task.listCurrentOrder.length,
//                             (i) => Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal:
//                                           getScreenHeight(context) * .1),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       searchForStartTasks(
//                                               taskId: task
//                                                   .listCurrentOrder[i].orderId,
//                                               listStartOrder:
//                                                   task.listStartOrder)
//                                           ? Container()
//                                           : Align(
//                                               alignment: Alignment.topRight,
//                                               child: IconButton(
//                                                   onPressed: () {
//                                                     listOrder.add(task
//                                                         .listCurrentOrder[i]);
//                                                     task.setRemoveOrder(
//                                                         listOrder[i]);
//                                                   },
//                                                   icon:
//                                                       const Icon(Icons.close))),
//                                       Center(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child: Text(
//                                             '#${task.listCurrentOrder[i].orderId.toString()}',
//                                             style: fieldText,
//                                           ),
//                                         ),
//                                       ),
//                                       Center(
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child: Text(
//                                             task.listCurrentOrder[i].orderTitle,
//                                             style: fieldText,
//                                           ),
//                                         ),
//                                       ),
//                                       task.listCurrentOrder[i].clientName != ''
//                                           ? Center(
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(2.0),
//                                                 child: Text(
//                                                   task.listCurrentOrder[i]
//                                                       .clientName,
//                                                   style: fieldText,
//                                                 ),
//                                               ),
//                                             )
//                                           : Container(),
//                                       Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: SizedBox(
//                                           height: 45,
//                                           width:
//                                               getScreenWidth(context) / 2 * .1,
//                                           child: CustomButton(
//                                             isWaiting: false,
//                                             color: searchForStartTasks(
//                                                     taskId: task
//                                                         .listCurrentOrder[i]
//                                                         .orderId,
//                                                     listStartOrder:
//                                                         task.listStartOrder)
//                                                 ? endTaskButton
//                                                 : primaryColor,
//                                             onPressed: () {
//                                               task.handleTaskOrder(
//                                                   taskId: task
//                                                       .listCurrentOrder[i]
//                                                       .orderId);
//                                             },
//                                             title: searchForStartTasks(
//                                                     taskId: task
//                                                         .listCurrentOrder[i]
//                                                         .orderId,
//                                                     listStartOrder:
//                                                         task.listStartOrder)
//                                                 ? 'End Task'
//                                                 : 'Start Task',
//                                             fontSizeTitle: 15,
//                                             radius: 8.0,
//                                           ),
//                                         ),
//                                       ),
//                                       task.listCurrentOrder.length - 1 == i
//                                           ? Container()
//                                           : Container(
//                                               color: disableColor,
//                                               width: 3,
//                                               height: 1,
//                                             )
//                                     ],
//                                   ),
//                                 )
//                         ))
//                     : const Center(
//                         child: Text('There is no Tasks'),
//                       ),
//                 Container(
//                   height: 8,
//                   margin: EdgeInsets.symmetric(
//                       horizontal: getScreenWidth(context) * .1, vertical: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12.0),
//                     color: const Color(0xffbcbcbc),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Coming Tasks',
//                     style: greetingText.copyWith(fontSize: 15),
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//                 listOrder.isNotEmpty
//                     ? Wrap(
//                         children: List<Widget>.generate(
//                             listOrder.length,
//                             (i) => Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal:
//                                           getScreenHeight(context) * .1),
//                                   child: InkWell(
//                                     onTap: () {
//                                       task.setNewOrder(listOrder[i]);
//                                       listOrder.remove(listOrder[i]);
//                                       //TODO delete clicked item
//                                     },
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                       children: [
//                                         Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Text(
//                                               '#${listOrder[i].orderId.toString()}',
//                                               style: fieldText,
//                                             ),
//                                           ),
//                                         ),
//                                         Center(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Text(
//                                               listOrder[i].orderTitle,
//                                               style: fieldText,
//                                             ),
//                                           ),
//                                         ),
//                                         listOrder[i].clientName != ''
//                                             ? Center(
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: Text(
//                                                     listOrder[i].clientName,
//                                                     style: fieldText,
//                                                   ),
//                                                 ),
//                                               )
//                                             : Container(),
//                                         listOrder.length - 1 == i
//                                             ? Container()
//                                             : Container(
//                                                 color: disableColor,
//                                                 width: 3,
//                                                 height: 1,
//                                               )
//                                       ],
//                                     ),
//                                   ),
//                                 )))
//                     : const Center(
//                         child: Text('There is no Tasks'),
//                       ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
