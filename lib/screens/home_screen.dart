import 'package:flutter/material.dart';
import 'package:frontend/widgets/search_bar.dart';
import 'mother_screen.dart';

class HomeScreen extends StatefulWidget {
  final List trendingList;
  const HomeScreen({required this.trendingList, super.key});
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
            const SizedBox(height: 50.0),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.only(start: 30),
                  child: Text(
                    "Summit Seekers",
                    style: TextStyle(
                      color: Color.fromARGB(255, 239, 239, 239),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage('assets/traveller_avatar.png'),
                  ),
                )
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
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  //indicator:
                  // CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                  tabs: const [
                    Tab(text: "Trending"),
                    Tab(text: "Recommended"),
                    Tab(text: "New"),
                  ],
                ),
              ),
            ),
            Container(
              height: 300,
              color: Colors.white.withOpacity(0),
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
                          margin: const EdgeInsets.only(
                              right: 15, top: 15, bottom: 15),
                          width: 200,
                          height: 300,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.trendingList[index]['image-url']),
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset:
                                    Offset(2, 2), // changes position of shadow
                              ),
                            ],
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
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(
                                    2, 2), // changes position of shadow
                              ),
                            ],
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
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Text(
                "Explore more...",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 229, 229, 229),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
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
                                color: const Color.fromARGB(255, 204, 204, 204)
                                    .withOpacity(0.2),
                                image: DecorationImage(
                                    opacity: 0.7,
                                    image: AssetImage(
                                        "img/${images.keys.elementAt(index)}"),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              images.values.elementAt(index),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 159, 159, 159),
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
