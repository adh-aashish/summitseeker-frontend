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

  DateTime selectedStartDate = DateTime.now();
  DateTime selectedDeadlineDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendar,
      // Use dropdown mode
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectDeadlineDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendar,
      // Use dropdown mode
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null && picked != selectedDeadlineDate) {
      setState(() {
        selectedDeadlineDate = picked;
      });
    }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Enter route name',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),

              //--------------------------------------------------//

              ((_searchController.text.isNotEmpty) &&
                      !(_filteredRoutes
                          .any((obj) => obj.name == _searchController.text)))
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _filteredRoutes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(_filteredRoutes[index].name),
                          onTap: () {
                            _searchController.text =
                                _filteredRoutes[index].name;
                          },
                        );
                      },
                    )
                  : Container(),
              //------------------------------------------------------//
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Starting Date:     ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => _selectStartDate(context),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 27, 27, 27)),
                            ),
                            child: const Text('Change date'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Deadline Date:     ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${selectedDeadlineDate.year}-${selectedDeadlineDate.month}-${selectedDeadlineDate.day}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () => _selectDeadlineDate(context),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 27, 27, 27)),
                            ),
                            child: const Text('Change date'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 36),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  String startDate = '';
                  String deadline = '';
                  String month = '';
                  String day = '';
                  if (selectedStartDate.month < 10) {
                    month = '0${selectedStartDate.month}';
                  } else {
                    month = '${selectedStartDate.month}';
                  }
                  if (selectedStartDate.day < 10) {
                    day = '0${selectedStartDate.day}';
                  } else {
                    day = '${selectedStartDate.day}';
                  }
                  startDate = '${selectedStartDate.year}-$month-$day';

                  if (selectedDeadlineDate.month < 10) {
                    month = '0${selectedDeadlineDate.month}';
                  } else {
                    month = '${selectedDeadlineDate.month}';
                  }
                  if (selectedDeadlineDate.day < 10) {
                    day = '0${selectedDeadlineDate.day}';
                  } else {
                    day = '${selectedDeadlineDate.day}';
                  }

                  deadline = '${selectedDeadlineDate.year}-$month-$day';
                  // print(startDate);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrekGuidesPage(
                        routeIndex: _filteredRoutes[0].index,
                        startDate: startDate,
                        deadline: deadline,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
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
