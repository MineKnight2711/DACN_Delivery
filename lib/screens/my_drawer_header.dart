import 'package:flutter/material.dart';

class MyDrawerHeader extends StatelessWidget {
  final String avatarImageUrl;
  final String name;
  final String email;

  const MyDrawerHeader({
    Key? key,
    required this.avatarImageUrl,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 243, 114, 63),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(avatarImageUrl),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
