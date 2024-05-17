import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plo/views/Terms_of_service_screen/provider/terms_provider.dart';

class CheckBoxWidget extends StatelessWidget {
  final String title;
  final Checkbox checkBox;
  final Function callback;
  final String? subtitle;
  final int? id;
  const CheckBoxWidget(
      {super.key,
      required this.title,
      required this.checkBox,
      required this.callback,
      this.id,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => callback(),
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.scale(scale: 2, child: checkBox),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 75, 74, 74),
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 10),
                subtitle == null
                    ? Container()
                    : Consumer(
                        builder: (context, ref, child) {
                          final termInfo = ref.watch(termsInfoProvider);
                          return Text(
                            subtitle!,
                            style: TextStyle(
                                fontSize: 20,
                                color: id != null
                                    ? termInfo['checkbox$id']!
                                        ? const Color.fromARGB(255, 75, 74, 74)
                                        : Colors.red
                                    : const Color.fromARGB(255, 75, 74, 74),
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 75, 74, 74),
              size: 30,
            )
          ],
        ),
      ),
    );
  }
}
