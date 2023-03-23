import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/services/trail_details.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/services/user_profile.dart';

class DetailPage extends StatefulWidget {
  final int routeId;
  const DetailPage({super.key, required this.routeId});

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  bool isLoading = true;
  List reviewList = [];
  Map trailInfo = {};

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
    print(message);
  }

  void getTrailInfo() async {
    try {
      List response = await getTrailDetails(widget.routeId);

      setState(() {
        if (response[0]) {
          trailInfo = response[1];
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, response[1]);
        }
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }

    try {
      List response = await getTrailReviews(widget.routeId);

      setState(() {
        if (response[0]) {
          reviewList = response[1];
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(false, response[1]);
        }
        reviewList = [
          {
            "first_name": "Aashish",
            "last_name": "Adhikari",
            "rating": 4.5,
            "comment":
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ",
            "photo":
                "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png",
          },
          {
            "first_name": "Aashish",
            "last_name": "Adhikari",
            "rating": 4.5,
            "comment":
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's ",
            "photo":
                "https://cdn.pixabay.com/photo/2013/07/13/10/07/man-156584__340.png",
          }
        ];
        isLoading = false;
      });
    } catch (e) {
      showSnackBar(false, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getTrailInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
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
              : Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://74.225.249.44${trailInfo["mapImage"]}"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 50,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // BlocProvider.of<AppCubits>(context).goHome();
                            },
                            icon: const Icon(Icons.arrow_back_outlined),
                            color: Colors.black,
                            iconSize: 40,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 320,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        width: MediaQuery.of(context).size.width,
                        // height: double.infinity,
                        //height: 500,
                        decoration: const BoxDecoration(
                          color: Color(0xff121212),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                trailInfo["name"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color(0xffBB86FC),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Solukhumbu, Nepal",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              RatingBarIndicator(
                                rating: trailInfo["average_rating"].toDouble(),
                                direction: Axis.horizontal,
                                itemCount: 5,
                                // itemPadding:
                                //     const EdgeInsets.symmetric(horizontal: 2.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 20,
                              ),
                              const SizedBox(height: 30),
                              const Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                height: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Text(
                                      "No. of days: ${trailInfo["days"]}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Difficulty: ${trailInfo["average_difficulty"]}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                "Reviews",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                children: (() {
                                  List<Widget> widgets = [];
                                  if (reviewList.isEmpty) {
                                    return [
                                      const Center(child: Text("No Reviews."))
                                    ];
                                  } else {
                                    for (int index = 0;
                                        index < reviewList.length;
                                        index++) {
                                      widgets.add(const SizedBox(height: 20));
                                      widgets.add(
                                        Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                              reviewList[index]
                                                                  ["photo"]),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            '${reviewList[index]["first_name"]} ${reviewList[index]["last_name"]} '),
                                                        const SizedBox(
                                                            height: 2),
                                                        RatingBarIndicator(
                                                          rating: 3.5,
                                                          direction:
                                                              Axis.horizontal,
                                                          itemCount: 5,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      2.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          itemSize: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Text(reviewList[index]
                                                    ["comment"]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  return widgets;
                                }()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
