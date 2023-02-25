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
            color: Colors.white.withOpacity(0.6),
            icon: Icon(Icons.search),
            onPressed: () {
              // Perform search functionality here
            },
          ),
          suffixIcon: IconButton(
            color: Colors.white.withOpacity(0.6),
            icon: Icon(Icons.tune),
            onPressed: () {
              // Perform search functionality here
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