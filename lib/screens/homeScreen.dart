// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fua/cubits/account/account_cubits.dart';
import 'package:fua/cubits/account/account_logic.dart';
import 'package:fua/cubits/notifications/notifications_cubit.dart';
import 'package:fua/cubits/notifications/notifications_logic.dart';
import 'package:fua/cubits/slider/slider_cubit.dart';
import 'package:fua/cubits/slider/slider_logic.dart';
import 'package:fua/screens/bookService.dart';
import 'package:fua/screens/jobDescriptionScreen.dart';
import 'package:fua/screens/welcomePage.dart';
import 'package:fua/screens/workerList.dart';
import 'package:fua/services/currentUser.dart';
import 'package:fua/services/imagesSlider.dart';
import 'package:fua/services/notificationsService.dart';
import 'package:fua/services/requestedJobs.dart';
import 'package:fua/services/searchWorker.dart';

import 'package:fua/widgets/quickLinks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fua/screens/notificationScreen.dart';

import 'package:fua/services/authServise.dart';

enum CurrentScreen { couresel, search }

class HomePage extends StatefulWidget {
  User? user;
  String? email;
  HomePage([this.email, this.user]);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CurrentScreen currentScreen = CurrentScreen.couresel;

  var textController = TextEditingController();
  // List<Worker> workers = [];
  AuthService authService = AuthService();
  SearchWorker searchWorker = SearchWorker();
  RequestedJobService jobService = RequestedJobService();
  CurrentUserService currentUserService = CurrentUserService();
  String searchKeyWord = "";
  String username = "";

  @override
  void initState() {
    currentUserService.getUser(widget.email);
    // User user=currentUserService.getSingleUser
    // print("hello");
    // print(user);
    initialization();
    RequestedJobService().getRequestedJobs(widget.email);
    super.initState();
  }

  // print('go!');
  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return BlocProvider(
                      create: (context) => NotificationsCubit(
                            notificationService: NotificationService(),
                            id: "6",
                          ),
                      child: NotificationLogicScreen(
                        id: "1",
                      ));
                },
              ),
            );
          },
          child: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 252, 249, 249),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    await authService.logout();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return WelcomePage();
                    }));
                  },
                ),
                IconButton(
                    icon: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return BlocProvider(
                      //           create: (context) => AccountCubit(
                      //                 currentUserService: CurrentUserService(),
                      //                 email: widget.email,
                      //               ),
                      //           child: AccountLogicScreen(
                      //             email: widget.email,
                      //           ));
                      //     },
                      //   ),
                      // );
                    })
              ],
            ),
          ),
        ],
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(
                  10,
                )),
                color: Colors.blue,
              ),
              height: 100,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Text("Welcome",style:TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            "img/fua.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),

            Container(
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Book A Service",
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return BookService(
                          email: widget.email,
                        );
                      }));
                    },
                  ),
                  ElevatedButton(
                    child: Text(
                      "Task Completion",
                    ),
                    onPressed: () {
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute(builder: (context) {
                      //   return BookService(
                      //     email: widget.email,
                      //   );
                      // }));

                      // RequestedJobService().getRequestedJobs(widget.email);
                    },
                  ),
                ],
              )),
            ),
            // Container(
            //   margin: const EdgeInsets.all(5),
            //   height: 70,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(
            //       20,
            //     )),
            //   ),
            //   width: double.maxFinite,
            //   //replace row with map screen
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Expanded(
            //             child: Container(
            //               padding: const EdgeInsets.all(10),
            //               width: double.maxFinite,
            //               child: TextField(
            //                 controller: textController,
            //                 textCapitalization: TextCapitalization.words,
            //                 onChanged: searchWorkerbyQuery,
            //                 decoration: const InputDecoration(
            //                   labelText: "Search Workers By Location",
            //                   hintText: 'e.g Umoja I',
            //                   contentPadding: EdgeInsets.symmetric(
            //                       vertical: 10.0, horizontal: 20.0),
            //                   border: OutlineInputBorder(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(32.0)),
            //                   ),
            //                   enabledBorder: OutlineInputBorder(
            //                     borderSide: BorderSide(
            //                         color: Colors.lightBlueAccent, width: 1.0),
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(32.0)),
            //                   ),
            //                   focusedBorder: OutlineInputBorder(
            //                     borderSide: BorderSide(
            //                         color: Colors.lightBlueAccent, width: 2.0),
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(32.0)),
            //                   ),
            //                   // suffixIcon: Center(child: Icon(Icons.search)),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            const Divider(),
            Container(
              child: currentScreen == CurrentScreen.couresel
                  ? BlocProvider(
                      create: (context) => SliderCubit(
                        imageService: ImageService(),
                      ),
                      child: SliderCubitLogics(),
                    )
                  : Container(
                      height: 10,
                      child: FutureBuilder<WorkerList>(
                        future: searchWorker.getWorkerBySearch(searchKeyWord),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Worker> workers = snapshot.data!.workers;
                            return ListView(
                              children: [
                                ...workers.map((worker) {
                                  return ListTile(
                                    title: Text(worker.location),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: ((context) {
                                            return WorkersListScreen(
                                                title: worker.location,
                                                workers: workers);
                                          }),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ],
                            );
                          } else {
                            return Center(
                              child: const CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
            ),
            QuickLinks(),
            Expanded(
              // height: 500,
              child: Column(
                children: [
                  const Text(
                    "Requested Jobs",
                  ),
                  FutureBuilder<List<RequestedJobs>>(
                    future: jobService.getRequestedJobs("test@gmail.com"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<RequestedJobs>? jobs = snapshot.data;

                        return Column(
                          children: [
                            ...jobs!.map((jobs) {
                              return Card(
                                child: ListTile(
                                  leading: Text((jobs.id).toString()),
                                  title: Text(
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                      ),
                                      "Date Requested: ${jobs.dateRequested.toString().substring(0, 10)}"),
                                  subtitle: Text(jobs.workDescription),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return JobDescriptionScreen(
                                          requestedJobs: jobs,
                                        );
                                      }));
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        );
                      } else {
                        return Center(
                          child: const CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchWorkerbyQuery(String query) {
    setState(() {
      currentScreen = CurrentScreen.search;
      searchKeyWord = query.toLowerCase();
      // var response = searchWorker.getWorkerBySearch(query.toLowerCase());

      print(searchKeyWord);
    });

    if (query == "") {
      setState(() {
        currentScreen = CurrentScreen.couresel;
      });
    }

    //   final suggestions = allWorkers.where((worker) {
    //     final location = worker.location.toLowerCase();
    //     final input = query.toLowerCase();
    //     return location.contains(input);
    //   }).toList();
    //   print(query);

    //   setState(() {
    //     worker = suggestions;
    //   });
  }
}
