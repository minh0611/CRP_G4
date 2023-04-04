import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller,
      required this.isPasswordType});
  final String text;
  final IconData icon;
  final bool isPasswordType;
  final TextEditingController controller;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPasswordType,
      enableSuggestions: widget.isPasswordType,
      autocorrect: widget.isPasswordType,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: Colors.white70),
        labelText: widget.text,
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.9)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
