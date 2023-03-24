import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/services/reviews.dart';
import 'package:frontend/screens/login_screen.dart';

class RatingDialog extends StatefulWidget {
  late int? trailId;
  late int? guideId;
  late int? touristId;

  RatingDialog({this.trailId, this.guideId, this.touristId, super.key});
  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 0.0;
  String _review = '';

  void reviews(String url, Map data) async {
    try {
      List response = await submitReview(url, data);

      setState(() {
        if (response[0]) {
          print(response[1]);
          // showSnackBar(true, response[1]);
        } else if (response[1] == 'token_expired') {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
          );
        } else {
          // showSnackBar(false, response[1]);
        }
      });
    } catch (e) {
      // showSnackBar(false, e.toString());
    }
  }

  // void showSnackBar(bool success,
  //     [String message = "Unknown error occurred."]) {
  //   final snackBar = SnackBar(
  //       content: Text(message),
  //       action: SnackBarAction(
  //         label: "Close",
  //         onPressed: () {},
  //       ),
  //       backgroundColor:
  //           (success = true) ? Colors.green[800] : Colors.red[800]);
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Rate and Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              hintText: 'Write a review',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _review = value;
              });
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: Text('Submit'),
          onPressed: () async {
            Map data = {};
            String url = '';
            data["comment"] = _review;
            data["rating"] = _rating;
            data["difficulty"] = 8;
            if (widget.trailId != null) {
              url = 'http://74.225.249.44/api/reviews/trail/${widget.trailId}/';
              print("trailId selected");
            }
            if (widget.guideId != null) {
              url = 'http://74.225.249.44/api/reviews/guide/${widget.guideId}/';
            }
            if (widget.touristId != null) {
              url =
                  'http://74.225.249.44/api/reviews/tourist/${widget.touristId}/';
            }
            print(url);
            Navigator.pop(context);
            reviews(url, data);
          },
        ),
      ],
    );
  }
}
