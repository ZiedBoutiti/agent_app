import 'package:agent/config/utils.dart';
import 'package:agent/resources/colors.dart';
import 'package:agent/resources/constants.dart';
import 'package:agent/resources/styles.dart';
import 'package:agent/screens/common_widgets/app_bar.dart';
import 'package:agent/screens/common_widgets/bottom_bar.dart';
import 'package:agent/screens/common_widgets/custom_button.dart';
import 'package:agent/screens/login/data/models/agent_data.dart';
import 'package:agent/screens/login/data/models/argument_data.dart';
import 'package:agent/screens/login/data/repository/login_repository.dart';
import 'package:agent/screens/login/domain/notifier/login_notifier.dart';
import 'package:agent/screens/login/domain/services/login_service.dart';
import 'package:agent/screens/login/domain/utils/common.dart';
import 'package:agent/screens/tasks/common_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class MobLogin extends StatefulWidget {
  const MobLogin({Key? key}) : super(key: key);

  @override
  State<MobLogin> createState() => _MobLoginState();
}

class _MobLoginState extends State<MobLogin> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool hide = true;

  final LoginRepository _loginRepository = LoginRepository();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final login = context.watch<LoginProvider>();
    return Scaffold(
        appBar: AgentBar(
          color: secondColor,
          title: loginTitle,
          context: context,
          showBack: false,
          //size: getScreenHeight(context) * .2,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: login.listNames.isNotEmpty
                ? EdgeInsets.only(top: getScreenHeight(context) * .1)
                : null,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //readData
                  // StreamBuilder<DatabaseEvent>(
                  //     stream: _loginRepository.readAgentList(),
                  //     builder: (BuildContext context,
                  //         AsyncSnapshot<DatabaseEvent> snapshot) {
                  //       List<Widget> children;
                  //       if (snapshot.hasError) {
                  //         children = <Widget>[
                  //           const Icon(
                  //             Icons.error_outline,
                  //             color: Colors.red,
                  //             size: 60,
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(top: 16),
                  //             child: Text('Error: ${snapshot.error}'),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.only(top: 8),
                  //             child:
                  //                 Text('Stack trace: ${snapshot.stackTrace}'),
                  //           ),
                  //         ];
                  //       } else {
                  //         switch (snapshot.connectionState) {
                  //           case ConnectionState.none:
                  //             children = const <Widget>[
                  //               Icon(
                  //                 Icons.info,
                  //                 color: Colors.blue,
                  //                 size: 60,
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsets.only(top: 16),
                  //                 child: Text('Select a lot'),
                  //               )
                  //             ];
                  //             break;
                  //           case ConnectionState.waiting:
                  //             children = const <Widget>[
                  //               SizedBox(
                  //                 width: 60,
                  //                 height: 60,
                  //                 child: CircularProgressIndicator(),
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsets.only(top: 16),
                  //                 child: Text('Awaiting bids...'),
                  //               )
                  //             ];
                  //             break;
                  //           case ConnectionState.active:
                  //             List<Agent> agent = [];
                  //             final json =
                  //             snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  //             json.forEach((key, value) {
                  //               agent.add(Agent.fromJson(value));
                  //             });
                  //             children = <Widget>[
                  //               Padding(
                  //                 padding: const EdgeInsets.only(top: 16),
                  //                 child: Text('${agent[0].name}'),
                  //               )
                  //             ];
                  //             break;
                  //           case ConnectionState.done:
                  //             List<Agent> agent = [];
                  //             final json = snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                  //             json.forEach((key, value) {
                  //               agent.add(Agent.fromJson(value));
                  //             });
                  //             children = <Widget>[
                  //               Padding(
                  //                 padding: const EdgeInsets.only(top: 16),
                  //                 child: Text('\$${snapshot.data!.snapshot.value}'),
                  //               )
                  //             ];
                  //             break;
                  //         }
                  //       }
                  //       return Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: children,
                  //       );
                  //     }),

                  //   FirebaseAnimatedList(
                  //     shrinkWrap: true,
                  //   controller: _scrollController,
                  //   query: _loginRepository.readAgentList(),
                  //   itemBuilder: (context, snapshot, animation, index) {
                  //     List<Agent> agents = [];
                  //     final json = snapshot.value as Map<dynamic, dynamic>;
                  //     print(json);
                  //     // json.forEach((key, value) {
                  //     //   agents.add(Agent.fromJson(value));
                  //     // });
                  //     final agent = Agent.fromJson(json);
                  //     return Text(agent.name);
                  //   },
                  // ),

                  //             FutureBuilder<dynamic>(
                  //             future: loginService.readData(), // a previously-obtained Future<String> or null
                  // builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  //               if(snapshot.hasData){
                  //
                  //                 return Column(
                  //                   children: [
                  //                     //get order key
                  //                    // Text(snapshot.data[0]['key']),
                  //                     //get agent info
                  //                     // Text(snapshot.data['login']),
                  //                     // Text(snapshot.data['password']),
                  //                     // Text(snapshot.data['name']),
                  //                     // Text(snapshot.data['picture']),
                  //                     // Text(snapshot.data['status']),
                  //                     // Text(snapshot.data['service_key']),
                  //                     //get service (agent)
                  //                     // Text(snapshot.data['icon']),
                  //                     // Text(snapshot.data['keyCtegory']),
                  //                     // Text(snapshot.data['nameAr']),
                  //                     // Text(snapshot.data['nameEn']),
                  //                     // Text(snapshot.data['price'].toString()),
                  //                     //get all agent
                  //                     //TODO get agent info
                  //                     Text('${snapshot.data}'),
                  //                   ],
                  //                 );
                  //               }else{
                  //                 return Container();
                  //               }
                  // }),
                  ///List of agents
                  login.listNames.isNotEmpty
                      ? ListView.builder(
                          itemCount: login.listNames.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.pushReplacementNamed(context, );
                                //   login.setClickedName(login.listNames[index]);
                                Navigator.pushNamed(context, bottomBarRoute);
                                //   Navigator.pushNamed(context,tasksRoute, arguments: ArgumentData(name: login.listNames[index])  );
                              },
                              child: ListTile(
                                  leading: const Icon(Icons.person),
                                  trailing: Text(
                                    index.toString(),
                                    style: fieldText,
                                  ),
                                  title: Text(login.listNames[index])),
                            );
                          })
                      : Container(),

                  ///Login section
                  Container(
                    margin: login.listNames.isEmpty
                        ? EdgeInsets.only(top: getScreenHeight(context) * .2)
                        : null,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            controller: userNameController,
                            autofocus: false,
                            style: fieldText,
                            decoration: InputDecoration(
                              border: formBorderStyle,
                              hintText: 'Username',
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 6.0, top: 8.0),
                              disabledBorder: formBorderStyle.copyWith(
                                borderSide:
                                    const BorderSide(color: disableColor),
                              ),
                              focusedBorder: formBorderStyle,
                              enabledBorder: formBorderStyle,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'fill empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Stack(
                            alignment: const Alignment(0, 0),
                            children: <Widget>[
                              TextFormField(
                                controller: passController,
                                obscureText: hide,
                                autofocus: false,
                                style: fieldText,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'password',
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 6.0, top: 8.0),
                                  disabledBorder: formBorderStyle.copyWith(
                                    borderSide:
                                        const BorderSide(color: disableColor),
                                  ),
                                  focusedBorder: formBorderStyle,
                                  enabledBorder: formBorderStyle,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'fill empty';
                                  }
                                  return null;
                                },
                              ),
                              Positioned(
                                  right: 15,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        hide = !hide;
                                      });
                                    },
                                    icon: hide == false
                                        ? const FaIcon(
                                            FontAwesomeIcons.eye,
                                            size: 24,
                                          )
                                        : const FaIcon(
                                            FontAwesomeIcons.eyeSlash,
                                            size: 24,
                                          ),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: CustomButton(
                                  isWaiting: false,
                                  color: primaryColor,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Processing Data")));
                                      //check username and password

                                      login.setNewName(
                                          userNameController.text.toString());
                                      userNameController.text = '';
                                      passController.text = '';
                                    }
                                  },
                                  title: 'Sign In',
                                  fontSizeTitle: 25,
                                  radius: 18.0,
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
