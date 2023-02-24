import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool tappedSearch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search functionality here
            },
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              // Perform search functionality here
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: 'Enter a search term',
        ),
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