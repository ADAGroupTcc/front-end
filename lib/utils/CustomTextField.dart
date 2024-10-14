import 'package:flutter/material.dart';

const Color branco = Color(0xFFFFFAFE);
const Color preto = Color(0xFF0D0D0D);
const Color cinzar = Color(0x4dfffafe);

class CustomTextField extends StatefulWidget {
  final String label;
  final TextInputType inputType;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key, required this.label, required this.inputType, this.controller});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return FocusScope(
        child: Focus(
            onFocusChange: (focus) {
              setState(() {
                _hasFocus = focus;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.064),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 3),
                    child: TextField(
                      controller: _controller,
                      keyboardType: widget.inputType,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: cinzar,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: branco,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 11.0,
                          )),
                    ),
                  ),
                  Positioned(
                      left: _hasFocus || _controller.text.isNotEmpty ? 0 : 12,
                      top: _hasFocus || _controller.text.isNotEmpty ? -4 : 32,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: screenWidth * 0.043,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ))
                ],
              ),
            )));
  }
}