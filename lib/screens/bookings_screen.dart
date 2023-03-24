import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/notification.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool isLoading = true;
  List bookingList = [];

  final ScrollController _scrollController = ScrollController();

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

  void getHiringTouristList() async {
    try {
      List response = await getNotificationsForGuides();

      setState(() {
        if (response[0]) {
          print(response[1]);
          bookingList = response[1]["Hired"];
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
    getHiringTouristList();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bookings'),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                : Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: null,
                      ),
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: (() {
                          List<Widget> widgets = [];
                          if (bookingList.isEmpty) {
                            return [
                              const Center(
                                child: Text("No Enquiries."),
                              ),
                            ];
                          } else {
                            for (int index = 0;
                                index < bookingList.length;
                                index++) {
                              final tourist = bookingList[index]["tourist"];
                              final enquiry = bookingList[index];
                              widgets.add(
                                const SizedBox(height: 20),
                              );
                              widgets.add(
                                GestureDetector(
                                  onTap: () {
                                    //TODO: prompt hiring the guide.
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SizedBox(
                                      height: 115,
                                      child: InkWell(
                                        onTap: () {
                                          // Handle tap on the row
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              const CircleAvatar(
                                                backgroundImage:
                                                    AssetImage('img/hire.png'),
                                              ),
                                              const SizedBox(width: 30.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${tourist["user"]["first_name"]} ${tourist["user"]["last_name"]}',
                                                      style: const TextStyle(
                                                        //   color: Colors.grey[400],
                                                        color:
                                                            Color(0xffBB86FC),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.0,
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
                                                        'Email : ${tourist["user"]["email"]}'),
                                                    Text(
                                                        'Contact No. : ${tourist["user"]["contactNum"]}'),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  String phone =
                                                      'tel:${tourist["user"]["contactNum"]}';
                                                  if (await canLaunchUrl(
                                                      Uri.parse(phone))) {
                                                    await launchUrl(
                                                        Uri.parse(phone));
                                                  } else {
                                                    throw 'Could not launch $phone';
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  foregroundColor: Colors.green,
                                                  side: const BorderSide(
                                                    width: 1,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                // icon: const Icon(Icons
                                                //     .arrow_right),
                                                child: const Text("Contact"),
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
                  ),
          ),
        ),
      ),
    );
  }
}
