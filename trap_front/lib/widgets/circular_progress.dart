import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
            child: CircularProgressIndicator(
              color: Colors.orangeAccent,
              backgroundColor: Colors.blueGrey,
              // valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              
            ),
            
            // Text('Un pb est survenu');
          );
  }
}
  // }
  // buildShowDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       });
  // }

