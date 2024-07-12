// import 'package:flutter/material.dart';

// class CustomButton extends StatelessWidget {
//   final String? text;
//   final VoidCallback onPressed;
//   final Icon? icon;

//   const CustomButton({Key? key, this.text, required this.onPressed, this.icon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//       width: 150,
//       height: 40,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFFCCE7FF),
//           foregroundColor: Colors.black,
//           //padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//           textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           side: const BorderSide(color: Colors.transparent),
//           shadowColor: const Color.fromARGB(200, 0, 0, 0),
//           elevation: 5,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (icon != null) ...[icon!],
//             SizedBox(width: 8),
//             if (text != null) Text(text!),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final Icon? icon;

  const CustomButton({Key? key, this.text, required this.onPressed, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFCCE7FF),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!],
            if (icon != null) const SizedBox(width: 8),
            if (text != null) Flexible(child: Text(text!)),
          ],
        ),
      ),
    );
  }
}
