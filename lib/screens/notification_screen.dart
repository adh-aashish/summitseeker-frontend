import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/notification.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/services/enquiry.dart';

// import 'available_guides.dart';

class NotificationPage extends StatefulWidget {
  // final _refreshKey;
  const NotificationPage({super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = true;
  List enquiredGuideList = [];
  List acceptedGuideList = [];
  bool isGuide = true;

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getEnquiredAndAcceptedGuidesList();
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
                  isGuide
                      ? const Tab(text: "Enquiries")
                      : const Tab(text: "Enquired"),
                  isGuide
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
                          isGuide
                              ? Center()
                              : Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: null,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 30),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: enquiredGuideList.length,
                                            itemBuilder: (context, index) {
                                              final guide =
                                                  enquiredGuideList[index]
                                                      ["guide"]["user"];
                                              final enquiry =
                                                  enquiredGuideList[index];
                                              return GestureDetector(
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
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          isGuide
                              ? Center()
                              : Center(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: null,
                                    ),
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 60),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: acceptedGuideList.length,
                                            itemBuilder: (context, index) {
                                              final guide =
                                                  acceptedGuideList[index]
                                                      ["guide"]["user"];
                                              final enquiry =
                                                  acceptedGuideList[index];
                                              return GestureDetector(
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
                                              );
                                            },
                                          ),
                                        ),
                                      ],
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
