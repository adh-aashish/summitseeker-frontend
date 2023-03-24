import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/notification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/services/enquiry.dart';
import 'package:frontend/widgets/rating_dialog.dart';
import 'package:frontend/screens/user_profile_screen.dart';

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
  List acceptedGuideList = [];
  List enquiresList = [];
  List hireList = [];
  List responseList = [];
  List reviewTrailList = [];
  List reviewGuideList = [];
  List reviewTouristList = [];

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
          reviewTrailList = response[1]["trails"];
          reviewGuideList = response[1]["guides"];
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
          enquiresList = response[1]["Requested"];
          responseList = response[1]["Responded"];
          reviewTrailList = response[1]['trails'];
          reviewTouristList = response[1]['tourists'];
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
    _tabController = TabController(length: 3, vsync: this);
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
                  // widget.isGuide
                  //     ? const Tab(text: "Responses")
                  //     : const Tab(text: ""),
                  widget.isGuide
                      ? const Tab(text: "Responses")
                      : const Tab(text: "Accepted"),
                  const Tab(text: "Reviews")
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
                                  // Enquiries
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
                                            final tourist =
                                                enquiresList[index]["tourist"];
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
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Handle tap on the row
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'img/hire.png'),
                                                            ),
                                                            const SizedBox(
                                                                width: 30.0),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    '${tourist["user"]["first_name"]} ${tourist["user"]["last_name"]}',
                                                                    style:
                                                                        const TextStyle(
                                                                      // color: Colors.grey[400],
                                                                      color: Color(
                                                                          0xffBB86FC),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Text(
                                                                      '${enquiry["trail"]["name"]}'),
                                                                  Text(
                                                                      'Start Date: ${enquiry["start_date"]}'),
                                                                  Text(
                                                                    'Rate: Rs ${enquiry["money_rate"]}/day',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                      'Deadline: ${enquiry["deadLine"]} days')
                                                                ],
                                                              ),
                                                            ),
                                                            IconButton(
                                                              onPressed:
                                                                  () async {
                                                                List res =
                                                                    await sendResponse(
                                                                        enquiry[
                                                                            "id"],
                                                                        "RJ");
                                                                if (res[0]) {
                                                                  showSnackBar(
                                                                      false,
                                                                      "Request Rejected");
                                                                  setState(() {
                                                                    getEnquiresAndBookedTouristList();
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                }
                                                              },
                                                              icon: const Icon(Icons
                                                                  .cancel_outlined),
                                                              color: Colors.red,
                                                              iconSize: 35,
                                                            ),
                                                            IconButton(
                                                              onPressed:
                                                                  () async {
                                                                List res =
                                                                    await sendResponse(
                                                                        enquiry[
                                                                            "id"],
                                                                        "AC");
                                                                if (res[0]) {
                                                                  showSnackBar(
                                                                      true,
                                                                      "Request Accepted");
                                                                  setState(() {
                                                                    getEnquiresAndBookedTouristList();
                                                                    isLoading =
                                                                        true;
                                                                  });
                                                                }
                                                              },
                                                              icon: const Icon(Icons
                                                                  .check_circle_outline),
                                                              color:
                                                                  Colors.green,
                                                              iconSize: 35,
                                                            ),
                                                          ],
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
                                  // Enquired
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
                                  // Response
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: null,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: (() {
                                        List<Widget> widgets = [];
                                        if (responseList.isEmpty) {
                                          return [
                                            const Center(
                                              child: Text("No Enquiries."),
                                            ),
                                          ];
                                        } else {
                                          for (int index = 0;
                                              index < responseList.length;
                                              index++) {
                                            final tourist =
                                                responseList[index]["tourist"];
                                            final enquiry = responseList[index];
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
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Handle tap on the row
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              backgroundImage:
                                                                  AssetImage(
                                                                      'img/hire.png'),
                                                            ),
                                                            const SizedBox(
                                                                width: 30.0),
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    '${tourist["user"]["first_name"]} ${tourist["user"]["last_name"]}',
                                                                    style:
                                                                        const TextStyle(
                                                                      // color: Colors.grey[400],
                                                                      color: Color(
                                                                          0xffBB86FC),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16.0,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 3,
                                                                  ),
                                                                  Text(
                                                                      '${enquiry["trail"]["name"]}'),
                                                                  Text(
                                                                      'Start Date: ${enquiry["start_date"]}'),
                                                                  Text(
                                                                    'Rate: Rs ${enquiry["money_rate"]}/day',
                                                                    style: const TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Text(
                                                                      'Deadline: ${enquiry["deadLine"]} days')
                                                                ],
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                // List res =
                                                                //     await sendResponse();
                                                                // if (res[0]) {
                                                                //   showSnackBar(
                                                                //       true,
                                                                //       "Enquiry sent");
                                                                //   setState(() {
                                                                //     // getGuides();
                                                                //     isLoading =
                                                                //         true;
                                                                //   });
                                                                // }
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                foregroundColor:
                                                                    enquiry["status"] ==
                                                                            "AC"
                                                                        ? Colors
                                                                            .green
                                                                        : Colors
                                                                            .red,
                                                                side:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color: enquiry[
                                                                              "status"] ==
                                                                          "AC"
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red,
                                                                ),
                                                              ),
                                                              // icon: const Icon(Icons
                                                              //     .arrow_right),
                                                              child: Text(enquiry[
                                                                          "status"] ==
                                                                      "AC"
                                                                  ? "Accepted"
                                                                  : "Rejected"),
                                                            ),
                                                          ],
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
                                  // Accepted
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
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserProfilePage(
                                                        guide["id"],
                                                        userId: guide["id"],
                                                      ),
                                                    ),
                                                  ); //TODO: prompt hiring the guide.
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
                                                              'Status: ${enquiry["status"] == "RQ" ? 'Pending' : enquiry["status"] == "AC" ? "Accepted" : "Hired"}'
                                                              ''),
                                                          Text(
                                                            'Rate: Rs ${enquiry["money_rate"]}/day',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(enquiry[
                                                                      "email"] !=
                                                                  null
                                                              ? 'Email:${enquiry["email"]} '
                                                              : ""),
                                                          Text(enquiry[
                                                                      "contactNum"] !=
                                                                  null
                                                              ? 'Contact No. :${enquiry["contactNum"]} '
                                                              : "")
                                                        ],
                                                      ),
                                                      trailing:
                                                          ElevatedButton.icon(
                                                        onPressed: () async {
                                                          List res =
                                                              await finalHire(
                                                                  enquiry[
                                                                      "id"]);
                                                          if (res[0]) {
                                                            showSnackBar(true,
                                                                "Enquiry sent");
                                                            setState(() {
                                                              getEnquiredAndAcceptedGuidesList();
                                                              isLoading = true;
                                                            });
                                                          }
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
                          Center(
                            // Reviews
                            child: Container(
                              decoration: const BoxDecoration(
                                color: null,
                              ),
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: (() {
                                  List<Widget> widgets = [];
                                  if (reviewTrailList.isEmpty &&
                                      reviewTouristList.isEmpty &&
                                      reviewGuideList.isEmpty) {
                                    return [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Center(
                                          child: Text("Nothing to Review."))
                                    ];
                                  } else {
                                    for (int index = 0;
                                        index < reviewTrailList.length;
                                        index++) {
                                      widgets.add(
                                        const SizedBox(height: 20),
                                      );
                                      final trail = reviewTrailList[index];
                                      widgets.add(
                                        GestureDetector(
                                          onTap: () {
                                            //TODO: prompt hiring the guide.
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: SizedBox(
                                              height: 115,
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: 8.0,
                                                        left: 5,
                                                        right: 5),
                                                leading: const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'img/mountain.jpeg'),
                                                ),
                                                title: Text(
                                                    '${trail["trail_name"]}'),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    SizedBox(height: 5),
                                                    Text('Leave a review!'),
                                                  ],
                                                ),
                                                trailing: ElevatedButton.icon(
                                                  onPressed: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          RatingDialog(
                                                        trailId: trail["id"],
                                                      ),
                                                    );
                                                    setState(() {
                                                      getEnquiresAndBookedTouristList();
                                                      getEnquiredAndAcceptedGuidesList();
                                                      isLoading = true;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add),
                                                  label: const Text('Review'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    foregroundColor:
                                                        Colors.green,
                                                    side: const BorderSide(
                                                        width: 1,
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    for (int index = 0;
                                        index < reviewGuideList.length;
                                        index++) {
                                      widgets.add(
                                        const SizedBox(height: 20),
                                      );
                                      final guide = reviewGuideList[index];
                                      widgets.add(
                                        GestureDetector(
                                          onTap: () {
                                            //TODO: prompt hiring the guide.
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: SizedBox(
                                              height: 115,
                                              child: ListTile(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        top: 8.0,
                                                        left: 5,
                                                        right: 5),
                                                leading: const CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'img/hire.png'),
                                                ),
                                                title: Text(
                                                    '${guide["guide_full_name"]}'),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: const [
                                                    SizedBox(height: 5),
                                                    Text('Leave a review!'),
                                                  ],
                                                ),
                                                trailing: ElevatedButton.icon(
                                                  onPressed: () async {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          RatingDialog(
                                                        guideId: guide["id"],
                                                      ),
                                                    );
                                                    setState(() {
                                                      getEnquiredAndAcceptedGuidesList();
                                                      getEnquiresAndBookedTouristList();
                                                      isLoading = true;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.add),
                                                  label: const Text('Review'),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    foregroundColor:
                                                        Colors.green,
                                                    side: const BorderSide(
                                                        width: 1,
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  for (int index = 0;
                                      index < reviewTouristList.length;
                                      index++) {
                                    widgets.add(
                                      const SizedBox(height: 20),
                                    );
                                    final tourist = reviewTouristList[index];
                                    widgets.add(
                                      GestureDetector(
                                        onTap: () {
                                          //TODO: prompt hiring the guide.
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: SizedBox(
                                            height: 115,
                                            child: ListTile(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 8.0,
                                                      left: 5,
                                                      right: 5),
                                              leading: const CircleAvatar(
                                                backgroundImage:
                                                    AssetImage('img/hire.jpeg'),
                                              ),
                                              title: Text(
                                                  '${tourist["tourist_full_name"]}'),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  SizedBox(height: 5),
                                                  Text('Leave a review!'),
                                                ],
                                              ),
                                              trailing: ElevatedButton.icon(
                                                onPressed: () async {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        RatingDialog(
                                                      touristId: tourist["id"],
                                                    ),
                                                  );
                                                  setState(() {
                                                    getEnquiresAndBookedTouristList();
                                                    getEnquiredAndAcceptedGuidesList();
                                                    isLoading = true;
                                                  });
                                                },
                                                icon: const Icon(Icons.add),
                                                label: const Text('Review'),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  foregroundColor: Colors.green,
                                                  side: const BorderSide(
                                                      width: 1,
                                                      color: Colors.green),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return widgets;
                                }()),
                              ),
                            ),
                          )
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
