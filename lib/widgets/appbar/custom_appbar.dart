import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onAddButtonPressed;

  const CustomAppBar({super.key, required this.onAddButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(255, 255, 230, 1),
              Color.fromARGB(255, 255, 200, 36),
              Color.fromARGB(255, 255, 255, 230),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 132, 0),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'My Expense Tracker',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nadim Zubary',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: onAddButtonPressed,
              icon: const Icon(
                Icons.add_circle_outlined,
                color: Colors.black,
                size: 35,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
