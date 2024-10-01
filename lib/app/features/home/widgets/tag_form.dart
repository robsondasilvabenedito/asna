import 'package:flutter/material.dart';

class TagForm extends StatelessWidget {
  const TagForm({
    super.key,
    this.controller,
    this.confirmFunction,
  });

  /// Controller
  ///
  /// Input controller.
  final TextEditingController? controller;

  /// OnConfirm
  ///
  /// Confirm function.
  final void Function()? confirmFunction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFE4C59E),
      titlePadding: const EdgeInsets.only(bottom: 10),
      title: Container(
              decoration: const BoxDecoration(
      color: Color(0xFFBD743D),
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              ),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: const Text(
      "New Tag",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xFF322C2B),
      ),
              ),
            ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.all(10),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          label: Text("Name"),
          labelStyle: TextStyle(color: Color(0xFF322C2B)),
          hintText: "favorite...",
          errorStyle: TextStyle(color: Color.fromARGB(255, 187, 70, 61)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF322C2B))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF322C2B))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF322C2B))),
        ),
      ),
      actionsPadding: const EdgeInsets.all(10),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.close_sharp,
                  color: Color(0xFF322C2B),
                ))),
        GestureDetector(
            onTap: confirmFunction,
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.check_sharp,
                  color: Color(0xFF322C2B),
                ))),
      ],
    );
  }
}
