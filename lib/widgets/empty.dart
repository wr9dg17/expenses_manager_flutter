import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  final String title;

  const Empty({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 150,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
