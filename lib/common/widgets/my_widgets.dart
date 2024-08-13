import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget alertInputBox({required BuildContext context, required String title, required String content}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
      ),
    ],
  );
}

PopupMenuItem<Object> dropMenuItem({
  required dynamic val,
  Widget? iconData,
  required String text,
  double? textFontSize = 15,
}) {
  return PopupMenuItem(
    value: val,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: iconData!,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: textFontSize,
          ),
        ),
      ],
    ),
  );
}

Widget dropMenu({
  required List<PopupMenuEntry<dynamic>> Function(BuildContext) items,
  required Function(dynamic) onSelected,
  Widget? child,
}) {
  return PopupMenuButton(
    itemBuilder: items,
    onSelected: onSelected,
    child: child,
  );
}

Widget shadowBox({
  required double width,
  required double height,
  required double circularRadius,
  required Offset offset,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(circularRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 4,
          offset: offset,
        ),
      ],
    ),
  );
}

Widget pfpStack({
  required File? pfpImage,
  required ImageProvider<Object>? bgImage,
  required List<PopupMenuEntry<dynamic>> Function(BuildContext) items,
  required Function(dynamic) onSelected,
}) {
  return Stack(
    children: [
      CircleAvatar(
        radius: 62,
        backgroundColor: Colors.transparent,
        backgroundImage: pfpImage != null ? FileImage(pfpImage) : bgImage,
      ),
      Positioned(
        right: -1,
        bottom: 0,
        child: PopupMenuButton(
          itemBuilder: items,
          onSelected: onSelected,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/profile_plus.png",
              width: 42.5,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget textFormFieldErr({
  TextInputType? inputType,
  List<TextInputFormatter>? inputRules,
  required double circularRadius,
  required String? Function(String?) validator,
  TextInputAction? textInputAction,
  TextEditingController? controller,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    inputFormatters: inputRules,
    style: const TextStyle(color: Colors.black),
    decoration: InputDecoration(
      fillColor: Colors.white,
      filled: true,
      isDense: true,
      errorStyle: const TextStyle(
        fontSize: 12.0,
        color: Color(0xFFFF0000),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.black),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.red),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circularRadius),
        borderSide: const BorderSide(color: Colors.black),
      ),
    ),
    validator: validator,
    textInputAction: textInputAction,
  );
}

Widget textFormFieldErrWithShadow({
  required String? textAbove,
  double? width = 300,
  double? height = 55,
  double? radius = 9.0,
  required Offset shadowOffset,
  TextEditingController? controller,
  List<TextInputFormatter>? inputRules,
  required String? Function(String?) validator,
  TextInputAction? textInputAction = TextInputAction.next,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          textAbove!,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      Stack(
        children: [
          shadowBox(
            width: width!,
            height: height!,
            circularRadius: radius!,
            offset: shadowOffset,
          ),
          textFormFieldErr(
            circularRadius: radius,
            controller: controller,
            inputRules: inputRules,
            validator: validator,
            textInputAction: textInputAction,
          ),
        ],
      ),
    ],
  );
}

// Widget sizedButtonWithShadow({
//   double? width = 300,
//   double? height = 55,
//   double? radius = 9.0,
//   required Offset shadowOffset,
//   required void Function()? onPressed,
//   required String buttonText,
//   //cum cum cum
// }) {
//   return Stack(
//     children: [
//       shadowBox(
//         width: width!,
//         height: height!,
//         circularRadius: radius!,
//         offset: shadowOffset,
//       ),
//       SizedBox(
//         width: width,
//         height: height,
//         child: ElevatedButton(
//           style: ButtonStyle(
//             elevation: WidgetStateProperty.all(0),
//             backgroundColor: WidgetStateProperty.all(
//               const Color(0xFFCCE7FF),
//             ),
//             shape: WidgetStateProperty.all(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//             ),
//           ),
//           onPressed: onPressed,
//           child: Text(
//             buttonText,
//             style: const TextStyle(
//               fontSize: 20.0,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       )
//     ],
//   );
// }
