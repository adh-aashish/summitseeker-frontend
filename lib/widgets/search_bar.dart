import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool tappedSearch = false;

  bool showFilterDropDown = false;
  RangeValues _currentRangeValues1 = const RangeValues(40, 80);
  RangeValues _currentRangeValues2 = const RangeValues(40, 80);
  RangeValues _currentRangeValues3 = const RangeValues(0, 3000);
  // String dropdownValue1 = 'Option 1';
  // String dropdownValue2 = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              prefixIcon: IconButton(
                color: Colors.white.withOpacity(0.6),
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Perform search functionality here
                },
              ),
              suffixIcon: IconButton(
                color: Colors.white.withOpacity(0.6),
                icon: const Icon(Icons.tune),
                onPressed: () {
                  setState(() {
                    showFilterDropDown = !showFilterDropDown;
                  });
                },
              ),
              hintText: 'Enter a search term',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          showFilterDropDown
              ? Padding(
                  padding: const EdgeInsetsDirectional.only(top: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 340,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 30, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Difficulty",
                            style: TextStyle(
                              color: Color.fromARGB(255, 216, 216, 216),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          tickMarkShape: const RoundSliderTickMarkShape(),
                          activeTickMarkColor:
                              const Color.fromARGB(255, 255, 242, 0),
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              const PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Color.fromARGB(255, 0, 129, 149),
                          valueIndicatorTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: RangeSlider(
                          values: _currentRangeValues1,
                          max: 100,
                          divisions: 10,
                          labels: RangeLabels(
                            _currentRangeValues1.start.round().toString(),
                            _currentRangeValues1.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues1 = values;
                            });
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 30, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Length",
                            style: TextStyle(
                              color: Color.fromARGB(255, 216, 216, 216),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          tickMarkShape: const RoundSliderTickMarkShape(),
                          activeTickMarkColor:
                              const Color.fromARGB(255, 255, 242, 0),
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              const PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor:
                              const Color.fromARGB(255, 0, 129, 149),
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: RangeSlider(
                          values: _currentRangeValues2,
                          max: 100,
                          divisions: 10,
                          labels: RangeLabels(
                            _currentRangeValues2.start.round().toString() +
                                ' KM',
                            _currentRangeValues2.end.round().toString() + ' KM',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues2 = values;
                            });
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(start: 30, top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Altitude",
                            style: TextStyle(
                              color: Color.fromARGB(255, 216, 216, 216),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          tickMarkShape: const RoundSliderTickMarkShape(),
                          activeTickMarkColor: Color.fromARGB(255, 133, 126, 0),
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              const PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor:
                              const Color.fromARGB(255, 0, 129, 149),
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          showValueIndicator: ShowValueIndicator.always,
                        ),
                        child: RangeSlider(
                          values: _currentRangeValues3,
                          max: 8000,
                          divisions: 50,
                          labels: RangeLabels(
                            _currentRangeValues3.start.round().toString() +
                                ' M',
                            _currentRangeValues3.end.round().toString() + ' M',
                          ),
                          onChanged: (RangeValues values) {
                            setState(() {
                              _currentRangeValues3 = values;
                            });
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsetsDirectional.only(
                      //       start: 50, top: 30, end: 50),
                      //   child: Row(
                      //     children: [
                      //       Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             const Text(
                      //               "Terrain",
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 216, 216, 216),
                      //                 fontSize: 17,
                      //               ),
                      //             ),
                      //             const SizedBox(height: 10),
                      //             DropdownButton<String>(
                      //               dropdownColor:
                      //                   Colors.black.withOpacity(0.2),
                      //               style: const TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 16,
                      //               ),
                      //               value: dropdownValue1,
                      //               onChanged: (String? newValue) {
                      //                 setState(() {
                      //                   dropdownValue1 = newValue!;
                      //                 });
                      //               },
                      //               items: <String>[
                      //                 'Option 1',
                      //                 'Option 2',
                      //                 'Option 3',
                      //                 'Option 4'
                      //               ].map<DropdownMenuItem<String>>(
                      //                   (String value) {
                      //                 return DropdownMenuItem<String>(
                      //                   value: value,
                      //                   child: Text(
                      //                     value,
                      //                     style: const TextStyle(
                      //                       color: Color.fromARGB(
                      //                           255, 216, 216, 216),
                      //                       fontSize: 17,
                      //                     ),
                      //                   ),
                      //                 );
                      //               }).toList(),
                      //             ),
                      //           ]),
                      //       const Spacer(),
                      //       Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             const Text(
                      //               "Terrain",
                      //               style: TextStyle(
                      //                 color: Color.fromARGB(255, 216, 216, 216),
                      //                 fontSize: 17,
                      //               ),
                      //             ),
                      //             const SizedBox(height: 10),
                      //             DropdownButton<String>(
                      //               dropdownColor:
                      //                   Colors.black.withOpacity(0.2),
                      //               style: const TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 16,
                      //               ),
                      //               value: dropdownValue2,
                      //               onChanged: (String? newValue) {
                      //                 setState(() {
                      //                   dropdownValue2 = newValue!;
                      //                 });
                      //               },
                      //               items: <String>[
                      //                 'Option 1',
                      //                 'Option 2',
                      //                 'Option 3',
                      //                 'Option 4'
                      //               ].map<DropdownMenuItem<String>>(
                      //                   (String value) {
                      //                 return DropdownMenuItem<String>(
                      //                   value: value,
                      //                   child: Text(
                      //                     value,
                      //                     style: const TextStyle(
                      //                       color: Color.fromARGB(
                      //                           255, 216, 216, 216),
                      //                       fontSize: 17,
                      //                     ),
                      //                   ),
                      //                 );
                      //               }).toList(),
                      //             ),
                      //           ]),
                      //     ],
                      //   ),
                      // )
                    ]),
                  ),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
// InkWell(
//       onTap: () {
//         tappedSearch = true;
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 500),
//         height: 50,
//         width: 100,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: Colors.deepPurple,
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         child: tappedSearch
//             ? const Icon(
//                 Icons.done,
//                 color: Colors.white,
//               )
//             : const Text(
//                 "Login",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                 ),
//               ),
//       ),
//     );