// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TimeHourItem extends StatelessWidget {
  final String time;
  final String text;
  final Icon icon;

  const TimeHourItem({
    Key? key,
    required this.time,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: 100,
        child: Column(
          children: [
            Text(
              time,
              maxLines: 1,
              style: const TextStyle(
                  fontSize: 23, overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(
              height: 10,
            ),
            icon,
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
