import 'package:flutter/material.dart';

class ReportSuccessPage extends StatelessWidget {
  const ReportSuccessPage ({super.key});
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Container(height: 120, width:140, child: Icon(Icons.check_box)),
                SizedBox(height:20),
                FittedBox(
                  child: Text("신고가 정상적으로 접수 되었습니다.", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                FittedBox(child: Text("신고를 검토한 후에 조치를 취하도록 하겠습니다", style: Theme.of(context).textTheme.bodyLarge),),
                Expanded(child: Container()),
                SizedBox(height: 44, width: double.infinity, child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("홈으로 돌아가기")
                ))
              ]
            )
          )
        )
      )
    );
  }
}