import 'package:flutter/material.dart';

// commentation needed
Widget textInputBox(
    {required String text,
    String? hintText,
    required TextEditingController controller,
    required String? Function(String?)? validator}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      text,
      style: const TextStyle(fontSize: 20),
    ),
    const SizedBox(height: 3),
    Stack(
      children: [
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 5,
              ),
            ],
          ),
        ),
        TextFormField(
            decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 20, color: Colors.grey[600]),
                hintText: hintText,
                prefixIcon: const Icon(Icons.email),
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.black54, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Colors.blue, width: 1),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                contentPadding: const EdgeInsets.all(5)),
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
                //If the fontsize is changed, the height of the shadow must be changed
                fontSize: 20),
            validator: validator),
      ],
    )
  ]);
}

Widget passwordInputBox(
    {required String text,
    required TextEditingController controller,
    required bool passwordVisible,
    required Function() onPressed,
    required String? Function(String?)? validator}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
      const SizedBox(height: 3),
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
          TextFormField(
              obscureText: !passwordVisible,
              controller: controller,
              keyboardType: TextInputType.visiblePassword,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: onPressed),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: Colors.black54, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  contentPadding: const EdgeInsets.all(5.0)),
              validator: validator),
        ],
      ),
    ],
  );
}
