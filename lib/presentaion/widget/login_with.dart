import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginWith extends StatelessWidget {
  final String text;
  final AssetImage image;
  final GestureTapCallback? onTap;

  const LoginWith(
      {super.key,
      required this.text,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 50,
          width: 250,
           margin: const EdgeInsets.all(10.0),
          // padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1),
                spreadRadius: 1.5,
                blurRadius: 5,
                //offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 5.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(35.0) //
                ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Row(
              children: [
                Image.asset(
                  image.assetName,
                  width: 20,
                  height: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: HexColor('757575'),
                    fontSize: 18,
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
