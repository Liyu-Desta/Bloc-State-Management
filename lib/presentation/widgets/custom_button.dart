import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Key? key; // Add key parameter here

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.key, // Include key parameter in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key, // Pass the key to the ElevatedButton widget
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Roboto',
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 166, 70, 183),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
