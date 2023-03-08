import 'package:flutter/material.dart';

import 'available_guides.dart';

class TrekkingRoutesPage extends StatefulWidget {
  final List allTrailList;
  final List allRouteGuides = [];
  TrekkingRoutesPage({required this.allTrailList, super.key});

  @override
  State<TrekkingRoutesPage> createState() => _TrekkingRoutesPageState();
}

class _TrekkingRoutesPageState extends State<TrekkingRoutesPage> {
  final List<TrekkingRoute> _routes = [];
  List<TrekkingRoute> _filteredRoutes = [];

  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.allTrailList.length; i++) {
      TrekkingRoute newRoute = TrekkingRoute(
          index: widget.allTrailList[i]["id"],
          name: widget.allTrailList[i]["name"],
          image: widget.allTrailList[i]["image-url"]);
      _routes.add(newRoute);
    }
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrekGuidesPage(
                            routeIndex: route.index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              // widget.allTrailList[index]['image-url']),
                              route.image),
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
                            // widget.allTrailList[index]['name'],
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
