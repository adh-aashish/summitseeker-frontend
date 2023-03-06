import 'package:flutter/material.dart';

import 'available_guides.dart';

class TrekkingRoutesPage extends StatefulWidget {
  @override
  _TrekkingRoutesPageState createState() => _TrekkingRoutesPageState();
}

class _TrekkingRoutesPageState extends State<TrekkingRoutesPage> {
  final List<TrekkingRoute> _routes = [
    TrekkingRoute(index: 0, name: 'Route 1', image: 'img/mountain.jpeg'),
    TrekkingRoute(index: 0, name: 'Route 2', image: 'img/mountain2.png'),
    TrekkingRoute(index: 0, name: 'Route 3', image: 'img/welcome-one.png'),
    TrekkingRoute(index: 0, name: 'Route 4', image: 'img/welcome-two.png'),
    TrekkingRoute(index: 0, name: 'Route 5', image: 'img/mountain.jpeg'),
  ];

  List<TrekkingRoute> _filteredRoutes = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredRoutes = _routes;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String searchTerm = _searchController.text;
    setState(() {
      _filteredRoutes = _routes
          .where((route) =>
              route.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        decoration: const BoxDecoration(
          color: null,
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for routes',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: _filteredRoutes.length,
                itemBuilder: (BuildContext context, int index) {
                  TrekkingRoute route = _filteredRoutes[index];
                  return GestureDetector(
                    onTap: () {
                      //TODO: get guides for that route by its index no. from the server
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrekGuidesPage(
                            routeIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(route.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          color: Colors.black.withOpacity(0.5),
                          child: Text(
                            route.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
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
    );
  }
}

class TrekkingRoute {
  final int index;
  final String name;
  final String image;

  TrekkingRoute({required this.index, required this.name, required this.image});
}
