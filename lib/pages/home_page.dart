import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'event_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   return Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center  ,
        children: [
          SvgPicture.asset("assets/images/logo.svg",
            color: Colors.blue,
          ),
          const  Text(" Hi, You are welcome",
            style : TextStyle(
                fontSize: 35,
                fontFamily: 'Poppins'
            ),
          ),
          const Text("Nos meilleurs articles électroniques pour vous!",
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),

          Padding(padding: EdgeInsets.only(top: 20)),
        ],
      ),
   );
  }
}