import 'package:flutter/cupertino.dart';

class AlertBox {
  static Future<bool?> showYesOrNoAlertDialogue(
      BuildContext context, String title) async {
    return showCupertinoModalPopup<bool?>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Center(
            child: Text(
              "알림",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 100, 100, 100)),
          ),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context, false),
              child: const Text('취소'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context, true),
              child: const Text('예'),
            ),
          ],
        );
      },
    );
  }
}