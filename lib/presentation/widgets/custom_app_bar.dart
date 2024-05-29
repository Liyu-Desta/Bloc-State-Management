import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? leadingOnPressed;

  const CustomAppBar({
    required this.title,
    this.leadingOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 166, 70, 183),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: leadingOnPressed ?? () => Navigator.pop(context),
      ),
      
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(5),
          bottom: Radius.circular(3),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
