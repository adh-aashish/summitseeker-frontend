import 'package:flutter/material.dart';
import 'package:frontend/widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var images = {
    "to-do-list.png": "Todo List",
    "hire.png": "Hire Guide",
    "survey.png": "Take Survey",
    "contact.png": "Contact Us"
  };
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //search_bar,
            const SizedBox(height: 20.0),
            Row(
              children: const [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 20),
                  child: Text(
                    "Summit Seekers",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 20, end: 20),
              child: SearchBar(),
            ),
            const SizedBox(height: 35.0),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  //indicator:
                  // CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                  tabs: const [
                    Tab(text: "Trending"),
                    Tab(text: "Recommended"),
                    Tab(text: "Friends"),
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              color: Colors.white,
              width: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // BlocProvider.of<AppCubits>(context)
                          //     .detailPage(info[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: const DecorationImage(
                                image: AssetImage(
                                  "img/mountain.jpeg",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // BlocProvider.of<AppCubits>(context)
                          //     .detailPage(info[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: const DecorationImage(
                                image: AssetImage(
                                  "img/mountain.jpeg",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // BlocProvider.of<AppCubits>(context)
                          //     .detailPage(info[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: const DecorationImage(
                                image: AssetImage(
                                  "img/mountain.jpeg",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Explore more",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 120,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // margin: const EdgeInsets.only(right: 50),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color.fromARGB(255, 204, 204, 204),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "img/" + images.keys.elementAt(index)),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              images.values.elementAt(index),
                              style: TextStyle(
                                color: Color.fromARGB(255, 121, 121, 121),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
