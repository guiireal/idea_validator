import 'package:flutter/material.dart';

class Answer extends StatelessWidget {

  final String text;
  final void Function() onPressed;

  const Answer(this.text, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          fixedSize: MaterialStateProperty.all(const Size(320, 30)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
