import 'package:flutter/material.dart';

import 'available_guides.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for available trek guides
    final List<TrekGuide> guides = [
      TrekGuide(
        name: 'John Doe',
        image: 'img/hire.png',
        treksCompleted: 23,
        gender: 'Male',
        languagesSpoken: ['English', 'French'],
        price: 50,
        trekRoutes: [0, 1, 2],
      ),
      TrekGuide(
        name: 'Jane Smith',
        image: 'img/hire.png',
        treksCompleted: 12,
        gender: 'Female',
        languagesSpoken: ['English', 'Spanish'],
        price: 40,
        trekRoutes: [0, 1, 2],
      ),
      TrekGuide(
        name: 'Bob Brown',
        image: 'img/hire.png',
        treksCompleted: 8,
        gender: 'Male',
        languagesSpoken: ['English', 'Hindi'],
        price: 30,
        trekRoutes: [3, 2],
      ),
    ];
    //end of mock data.

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
                tabs: const [
                  Tab(text: "Enquired"),
                  Tab(text: "Accepted"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Center(
                      child: Container(
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
                            child: ListView.builder(
                              itemCount: guides.length,
                              itemBuilder: (context, index) {
                                final guide = guides[index];
                                return GestureDetector(
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
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.only(
                                            top: 8.0, left: 5, right: 5),
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              AssetImage(guide.image),
                                        ),
                                        title: Text(guide.name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${guide.treksCompleted} treks completed'),
                                            Text('${guide.gender} guide'),
                                            Text(
                                                'Languages spoken: ${guide.languagesSpoken.join(', ')}'),
                                          ],
                                        ),
                                        trailing: Text('\$${guide.price}/day'),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Accepted Tab",
                        style: TextStyle(color: Colors.white),
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
