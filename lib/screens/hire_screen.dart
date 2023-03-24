import 'package:flutter/material.dart';
import 'available_guides.dart';

class TrekkingRoutesPage extends StatefulWidget {
  final List allTrailList;
  final List allRouteGuides = [];
  final Function notificationPage;
  TrekkingRoutesPage(
      {required this.allTrailList, required this.notificationPage, super.key});

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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hiring Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Enter route name',
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
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
                          'Starting Date             ',
                          style: TextStyle(
                            color: Color(0xffBB86FC),
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
                            // child: ElevatedButton(
                            //   onPressed: () => _selectStartDate(context),
                            //   style: ButtonStyle(
                            //     backgroundColor:
                            //         MaterialStateProperty.all<Color>(
                            //             const Color.fromARGB(255, 27, 27, 27)),
                            //   ),
                            //   child: const Text('Change date'),
                            // ),
                            child: IconButton(
                              icon: const Icon(Icons.calendar_month),
                              // color: const Color(0xffBB86FC),
                              color: Colors.grey[400],
                              iconSize: 30,
                              tooltip: 'Select date',
                              onPressed: () => _selectStartDate(context),
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
                          'Deadline Date           ',
                          style: TextStyle(
                            color: const Color(0xffBB86FC),
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
                            child: IconButton(
                              icon: const Icon(Icons.calendar_month),
                              color: Colors.grey[400],
                              iconSize: 30,
                              tooltip: 'Select date',
                              onPressed: () => _selectStartDate(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      String startDate = '';
                      int deadline = 3;
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

                      deadline = 3;
                      // print(startDate);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrekGuidesPage(
                            routeIndex: _filteredRoutes[0].index,
                            startDate: startDate,
                            deadline: deadline,
                            notificationPage: widget.notificationPage,
                          ),
                        ),
                      );
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
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
