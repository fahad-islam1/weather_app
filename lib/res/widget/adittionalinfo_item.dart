// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AdditionalInfoitem extends StatelessWidget {
  final String title;
  final Icon icon;

  final String value;
  const AdditionalInfoitem({
    Key? key,
    required this.title,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        icon,
        
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
        value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
