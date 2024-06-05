import 'package:flutter/material.dart';
import 'color.dart' as color;

class CustomImageWidget extends StatelessWidget {
  final String gambarCustom;
  final String konteks;

  const CustomImageWidget(
      {Key? key, required this.konteks, required this.gambarCustom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 164, 166, 167),
            border: Border.all(
              color: Color.fromARGB(255, 164, 166, 167),
              width: 2,
            ),
            image: DecorationImage(
              image: AssetImage(gambarCustom),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              konteks,
              style: TextStyle(fontSize: 12, color: color.AppColor.putihPucat,fontWeight:FontWeight.w400),
            ),
          ),
        )
      ],
    );
  }
}
