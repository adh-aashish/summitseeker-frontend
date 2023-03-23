import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/notification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/services/enquiry.dart';

// import 'available_guides.dart';

class NotificationPage extends StatefulWidget {
  // final _refreshKey;
  late bool isGuide;
  NotificationPage({required this.isGuide, super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  List enquiredGuideList = [];
  List enquiresList = [];
  List acceptedGuideList = [];
  List hireList = [];

  void showSnackBar(bool success,
      [String message = "Unknown error occurred."]) {
    final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: "Close",
          onPressed: () {},
        ),
        backgroundColor:
            (success = true) ? Colors.green[800] : Colors.red[800]);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void getEnquiredAndAcceptedGuidesList() async {
    // enquired guide list
    try {
      List response = await getNotificationsForTourist();

      setState(() {
        if (response[0]) {
          enquiredGuideList = response[1]["All"];
          acceptedGuideList = response[1]["Accepted"];
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, response[1]);
        }
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }
  }

  void getEnquiresAndBookedTouristList() async {
    try {
      List response = await getNotificationsForGuides();

      setState(() {
        if (response[0]) {
          print(response[1]);
          enquiresList = response[1]["All"];
          hireList = response[1]["requested"];
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, response[1]);
        }
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    // widget.isGuide = false;
    _tabController = TabController(length: 2, vsync: this);
    if (widget.isGuide) {
      getEnquiresAndBookedTouristList();
    } else {
      getEnquiredAndAcceptedGuidesList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        //backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  widget.isGuide
                      ? const Tab(text: "Enquiries")
                      : const Tab(text: "Enquired"),
                  widget.isGuide
                      ? const Tab(text: "Bookings")
                      : const Tab(text: "Accepted"),
                ],
              ),
              Expanded(
                child: isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SpinKitFadingFour(
                              color: Colors.white,
                              size: 30.0,
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Loading...',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      )
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          widget.isGuide
                              ? Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: null,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: (() {
                                        List<Widget> widgets = [];
                                        if (enquiresList.isEmpty) {
                                          return [
                                            const Center(
                                              child: Text("No Enquiries."),
                                            ),
                                          ];
                                        } else {
                                          for (int index = 0;
                                              index < enquiresList.length;
                                              index++) {
                                            final guide = enquiresList[index]
                                                ["guide"]["user"];
                                            final enquiry = enquiresList[index];
                                            widgets.add(
                                              const SizedBox(height: 20),
                                            );
                                            widgets.add(
                                              GestureDetector(
                                                onTap: () {
                                                  //TODO: prompt hiring the guide.
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: SizedBox(
                                                    height: 115,
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              left: 5,
                                                              right: 5),
                                                      leading:
                                                          const CircleAvatar(
                                                        backgroundImage:
                                                            AssetImage(
                                                                'img/hire.png'),
                                                      ),
                                                      title: Text(
                                                          '${guide["first_name"]} ${guide["last_name"]}'),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              '${enquiry["trail"]["name"]}'),
                                                          Text(
                                                              'Status: ${enquiry["status"] == "RQ" ? 'Pending' : 'Accepted'}'),
                                                          Text(
                                                            'Rate: Rs ${enquiry["money_rate"]}/day',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: enquiry[
                                                                  "status"] ==
                                                              'RQ'
                                                          ? ElevatedButton.icon(
                                                              onPressed:
                                                                  () async {
                                                                print(enquiry[
                                                                        "guide"]
                                                                    ["id"]);
                                                                List res =
                                                                    await cancelEnquiry(
                                                                        enquiry[
                                                                            "id"]);
                                                                if (res[0]) {
                                                                  showSnackBar(
                                                                      true,
                                                                      "Enquiry Deleted");
                                                                  setState(() {
                                                                    getEnquiredAndAcceptedGuidesList();
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                }
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close),
                                                              label: const Text(
                                                                  'Cancel'),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                foregroundColor:
                                                                    Colors.red,
                                                                side: const BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            )
                                                          : ElevatedButton.icon(
                                                              onPressed:
                                                                  () async {
                                                                // List res = await sendEnquiry(
                                                                //     widget.routeIndex,
                                                                //     widget.startDate,
                                                                //     widget.deadline,
                                                                //     guide["id"],
                                                                //     guide["money_rate"]);
                                                                // if (res[0]) {
                                                                //   showSnackBar(
                                                                //       true, "Enquiry sent");
                                                                //   setState(() {
                                                                //     getGuides();
                                                                //     isLoading = true;
                                                                //   });
                                                                // }
                                                              },
                                                              icon: const Icon(
                                                                  Icons.add),
                                                              label: const Text(
                                                                  'Enquire'),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                foregroundColor:
                                                                    Colors
                                                                        .green,
                                                                side: const BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        return widgets;
                                      }()),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: null,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: (() {
                                        List<Widget> widgets = [];

                                        if (enquiredGuideList.isEmpty) {
                                          return [
                                            const Center(
                                                child: Text("No Enquiries."))
                                          ];
                                        } else {
                                          for (int index = 0;
                                              index < enquiredGuideList.length;
                                              index++) {
                                            final guide =
                                                enquiredGuideList[index]
                                                    ["guide"]["user"];
                                            final enquiry =
                                                enquiredGuideList[index];
                                            widgets.add(
                                              const SizedBox(height: 20),
                                            );
                                            widgets.add(
                                              GestureDetector(
                                                onTap: () {
                                                  //TODO: prompt hiring the guide.
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: SizedBox(
                                                    height: 115,
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              left: 5,
                                                              right: 5),
                                                      leading:
                                                          const CircleAvatar(
                                                        backgroundImage:
                                                            AssetImage(
                                                                'img/hire.png'),
                                                      ),
                                                      title: Text(
                                                          '${guide["first_name"]} ${guide["last_name"]}'),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              '${enquiry["trail"]["name"]}'),
                                                          Text(
                                                              'Status: ${enquiry["status"] == "RQ" ? 'Pending' : 'Accepted'}'),
                                                          Text(
                                                            'Rate: Rs ${enquiry["money_rate"]}/day',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: enquiry[
                                                                  "status"] ==
                                                              'RQ'
                                                          ? ElevatedButton.icon(
                                                              onPressed:
                                                                  () async {
                                                                print(enquiry[
                                                                        "guide"]
                                                                    ["id"]);
                                                                List res =
                                                                    await cancelEnquiry(
                                                                        enquiry[
                                                                            "id"]);
                                                                if (res[0]) {
                                                                  showSnackBar(
                                                                      true,
                                                                      "Enquiry Deleted");
                                                                  setState(() {
                                                                    getEnquiredAndAcceptedGuidesList();
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                }
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close),
                                                              label: const Text(
                                                                  'Cancel'),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                foregroundColor:
                                                                    Colors.red,
                                                                side: const BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                            )
                                                          : ElevatedButton.icon(
                                                              onPressed:
                                                                  () async {
                                                                // List res = await sendEnquiry(
                                                                //     widget.routeIndex,
                                                                //     widget.startDate,
                                                                //     widget.deadline,
                                                                //     guide["id"],
                                                                //     guide["money_rate"]);
                                                                // if (res[0]) {
                                                                //   showSnackBar(
                                                                //       true, "Enquiry sent");
                                                                //   setState(() {
                                                                //     getGuides();
                                                                //     isLoading = true;
                                                                //   });
                                                                // }
                                                              },
                                                              icon: const Icon(
                                                                  Icons.add),
                                                              label: const Text(
                                                                  'Enquire'),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                foregroundColor:
                                                                    Colors
                                                                        .green,
                                                                side: const BorderSide(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        return widgets;
                                      }()),
                                    ),
                                  ),
                                ),
                          widget.isGuide
                              ? Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: null,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: (() {
                                        List<Widget> widgets = [];
                                        if (hireList.isEmpty) {
                                          return [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Center(
                                                child:
                                                    Text("No Accepted Guides."))
                                          ];
                                        } else {
                                          for (int index = 0;
                                              index < hireList.length;
                                              index++) {
                                            widgets.add(
                                              const SizedBox(height: 20),
                                            );
                                            final guide = hireList[index]
                                                ["guide"]["user"];
                                            final enquiry = hireList[index];
                                            widgets.add(
                                              GestureDetector(
                                                onTap: () {
                                                  //TODO: prompt hiring the guide.
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: SizedBox(
                                                    height: 115,
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              left: 5,
                                                              right: 5),
                                                      leading:
                                                          const CircleAvatar(
                                                        backgroundImage:
                                                            AssetImage(
                                                                'img/hire.png'),
                                                      ),
                                                      title: Text(
                                                          '${guide["first_name"]} ${guide["last_name"]}'),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              '${enquiry["trail"]["name"]}'),
                                                          Text(
                                                              'Status: ${enquiry["status"] == "RQ" ? 'Pending' : 'Accepted'}'),
                                                          Text(
                                                            'Rate: Rs ${enquiry["money_rate"]}/day',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing:
                                                          ElevatedButton.icon(
                                                        onPressed: () async {
                                                          // List res = await sendEnquiry(
                                                          //     widget.routeIndex,
                                                          //     widget.startDate,
                                                          //     widget.deadline,
                                                          //     guide["id"],
                                                          //     guide["money_rate"]);
                                                          // if (res[0]) {
                                                          //   showSnackBar(
                                                          //       true, "Enquiry sent");
                                                          //   setState(() {
                                                          //     getGuides();
                                                          //     isLoading = true;
                                                          //   });
                                                          // }
                                                        },
                                                        icon: const Icon(
                                                            Icons.add),
                                                        label:
                                                            const Text('Hire'),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          foregroundColor:
                                                              Colors.green,
                                                          side:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        return widgets;
                                      }()),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: null,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: (() {
                                        List<Widget> widgets = [];
                                        if (acceptedGuideList.isEmpty) {
                                          return [
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Center(
                                                child:
                                                    Text("No Accepted Guides."))
                                          ];
                                        } else {
                                          for (int index = 0;
                                              index < acceptedGuideList.length;
                                              index++) {
                                            widgets.add(
                                              const SizedBox(height: 20),
                                            );
                                            final guide =
                                                acceptedGuideList[index]
                                                    ["guide"]["user"];
                                            final enquiry =
                                                acceptedGuideList[index];
                                            widgets.add(
                                              GestureDetector(
                                                onTap: () {
                                                  //TODO: prompt hiring the guide.
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 4.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: SizedBox(
                                                    height: 115,
                                                    child: ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.only(
                                                              top: 8.0,
                                                              left: 5,
                                                              right: 5),
                                                      leading:
                                                          const CircleAvatar(
                                                        backgroundImage:
                                                            AssetImage(
                                                                'img/hire.png'),
                                                      ),
                                                      title: Text(
                                                          '${guide["first_name"]} ${guide["last_name"]}'),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 5),
                                                          Text(
                                                              '${enquiry["trail"]["name"]}'),
                                                          Text(
                                                              'Status: ${enquiry["status"] == "RQ" ? 'Pending' : 'Accepted'}'),
                                                          Text(
                                                            'Rate: Rs ${enquiry["money_rate"]}/day',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing:
                                                          ElevatedButton.icon(
                                                        onPressed: () async {
                                                          // List res = await sendEnquiry(
                                                          //     widget.routeIndex,
                                                          //     widget.startDate,
                                                          //     widget.deadline,
                                                          //     guide["id"],
                                                          //     guide["money_rate"]);
                                                          // if (res[0]) {
                                                          //   showSnackBar(
                                                          //       true, "Enquiry sent");
                                                          //   setState(() {
                                                          //     getGuides();
                                                          //     isLoading = true;
                                                          //   });
                                                          // }
                                                        },
                                                        icon: const Icon(
                                                            Icons.add),
                                                        label:
                                                            const Text('Hire'),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          foregroundColor:
                                                              Colors.green,
                                                          side:
                                                              const BorderSide(
                                                                  width: 1,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        return widgets;
                                      }()),
                                    ),
                                  ),
                                ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
