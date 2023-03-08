import 'package:flutter/material.dart';
import 'package:frontend/services/trail_guides.dart';

class TrekGuidesPage extends StatelessWidget {
  final int routeIndex;

  const TrekGuidesPage({Key? key, required this.routeIndex}) : super(key: key);

  // Future<List> fetchGuidesOfRouteById(int id) async {}

  @override
  Widget build(BuildContext context) {
    // Mock data for available trek guides
    // final List<TrekGuide> guides = [
    //   TrekGuide(
    //     name: 'John Doe',
    //     image: 'img/hire.png',
    //     treksCompleted: 23,
    //     gender: 'Male',
    //     languagesSpoken: ['English', 'French'],
    //     price: 50,
    //     trekRoutes: [0, 1, 2],
    //   ),
    //   TrekGuide(
    //     name: 'Jane Smith',
    //     image: 'img/hire.png',
    //     treksCompleted: 12,
    //     gender: 'Female',
    //     languagesSpoken: ['English', 'Spanish'],
    //     price: 40,
    //     trekRoutes: [0, 1, 2],
    //   ),
    //   TrekGuide(
    //     name: 'Bob Brown',
    //     image: 'img/hire.png',
    //     treksCompleted: 8,
    //     gender: 'Male',
    //     languagesSpoken: ['English', 'Hindi'],
    //     price: 30,
    //     trekRoutes: [3, 2],
    //   ),
    // ];

    // Filter the guides based on the selected route index
    // final selectedGuides =
    //     guides.where((guide) => guide.trekRoutes.contains(routeIndex)).toList();

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: null,
          ),
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            const SizedBox(height: 60),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Available Guides",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List>(
                  future: getTrailGuides(routeIndex),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // show the loading snackbar while
                      // final snackBar = SnackBar(
                      //   content: Row(
                      //     children: const [
                      //       CircularProgressIndicator(),
                      //       SizedBox(width: 20),
                      //       Text("Loading data..."),
                      //     ],
                      //   ),
                      // );
                      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return Center(
                        child: Row(
                          children: const [
                            CircularProgressIndicator(),
                            Text("Loading..."),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      final allGuidesOfRoute = snapshot.data!;
                      return ListView.builder(
                        itemCount: allGuidesOfRoute.length,
                        itemBuilder: (context, index) {
                          final guide = allGuidesOfRoute[index];
                          return GestureDetector(
                            onTap: () {
                              //TODO: prompt hiring the guide.
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 4.0),
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
                                    backgroundImage: AssetImage('img/hire.png'),
                                  ),
                                  title: Text(
                                      '${guide["first_name"]} ${guide["last_name"]}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //     '${guide.treksCompleted} treks completed'),
                                      Text('${guide["gender"]} guide'),
                                      Text(
                                          'Languages spoken: ${guide["languages"].join(', ')}'),
                                    ],
                                  ),
                                  trailing:
                                      Text('\$${guide["money_rate"]}/day'),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text('Failed to fetch data: ${snapshot.error}');
                    }
                  }),
            ),
          ]),
        ),
      ),
    );
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
