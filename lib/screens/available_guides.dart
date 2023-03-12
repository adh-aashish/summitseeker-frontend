import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/trail_guides.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/services/enquiry.dart';

class TrekGuidesPage extends StatefulWidget {
  final int routeIndex;
  final String startDate;
  final String deadline;
  final Function notificationPage;

  const TrekGuidesPage(
      {Key? key,
      required this.routeIndex,
      required this.startDate,
      required this.deadline,
      required this.notificationPage})
      : super(key: key);

  @override
  State<TrekGuidesPage> createState() => _TrekGuidesPageState();
}

class _TrekGuidesPageState extends State<TrekGuidesPage> {
  // Future<List> fetchGuidesOfRouteById(int id) async {}
  bool isLoading = true;
  List guidesList = [];

  void getGuides() async {
    try {
      List response = await getTrailGuides(widget.routeIndex, widget.startDate);

      setState(() {
        if (response[0]) {
          guidesList = response[1];
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          print("here");
          showSnackBar(false, response[1]);
        }
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }
  }

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

  @override
  void initState() {
    super.initState();
    getGuides();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              "Available Guides",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // actions: [
            //   IconButton(
            //     onPressed: () {
            //       widget.notificationPage();
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(
            //       //       builder: (context) => NotificationPage()),
            //       // );
            //     },
            //     icon: const Icon(Icons.arrow_forward_rounded),
            //     iconSize: 30,
            //   )
            // ],
          ),
          body: Container(
              decoration: const BoxDecoration(
                color: null,
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                const SizedBox(height: 20),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Text(
                //         "Available Guides",
                //         style: TextStyle(
                //           fontSize: 25,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => NotificationPage()),
                //           );
                //         },
                //         icon: const Icon(Icons.arrow_forward_rounded),
                //         iconSize: 30,
                //       )
                //     ],
                //   ),
                // ),
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
                        : ListView.builder(
                            itemCount: guidesList.length,
                            itemBuilder: (context, index) {
                              final guide = guidesList[index];
                              return GestureDetector(
                                onTap: () {
                                  //TODO: prompt hiring the guide.
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: SizedBox(
                                    height: 115,
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.only(
                                          top: 8.0, left: 5, right: 5),
                                      leading: const CircleAvatar(
                                        backgroundImage:
                                            AssetImage('img/hire.png'),
                                      ),
                                      title: Text(
                                          '${guide["first_name"]} ${guide["last_name"]}'),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //     '${guide.treksCompleted} treks completed'),
                                          const SizedBox(height: 10),
                                          Text(
                                              '${guide["gender"] == 'M' ? "Male" : "Female"} guide'),
                                          Text(
                                              'Languages spoken: ${guide["languages"].join(', ')}'),

                                          const SizedBox(height: 5),

                                          Text(
                                            'Rate: Rs ${guide["money_rate"]}/day',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      trailing: ElevatedButton.icon(
                                        onPressed: () async {
                                          List res = await sendEnquiry(
                                              widget.routeIndex,
                                              widget.startDate,
                                              widget.deadline,
                                              guide["id"],
                                              guide["money_rate"]);
                                          if (res[0]) {
                                            showSnackBar(true, "Enquiry sent");
                                            setState(() {
                                              getGuides();
                                              isLoading = true;
                                            });
                                          }
                                        },
                                        icon: const Icon(Icons.add),
                                        label: const Text('Enquire'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.green,
                                            side: const BorderSide(
                                                width: 1, color: Colors.green)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ))
              ])),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.pop(context);
              widget.notificationPage();
            },
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            child: const Icon(Icons.done),
          ),
        ));
  }
}

class TrekGuide {
  final String name;
  final String image;
  final int treksCompleted;
  final String gender;
  final List<String> languagesSpoken;
  final double price;
  final List<int> trekRoutes;

  TrekGuide({
    required this.name,
    required this.image,
    required this.treksCompleted,
    required this.gender,
    required this.languagesSpoken,
    required this.price,
    required this.trekRoutes,
  });
}
