import 'package:flutter/material.dart';

import '../../../core/resources/colors.dart';

class ChooseAnAppointment extends StatelessWidget {
  final String appointment;
  final GestureTapCallback? tab;
  final Color color;
  final String day;
  final String date;

  const ChooseAnAppointment({
    super.key,
    required this.appointment,
    required this.tab,
    required this.color,
    required this.day,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tab,
      child: Container(
        height: 70,
        width: 200,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: ColorManager.switchColor,
            width: 2.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(35.0) //
              ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Center(
              child: Text(
                appointment,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Center(
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
