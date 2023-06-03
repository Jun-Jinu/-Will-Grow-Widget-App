import 'package:flutter/material.dart';
import 'package:flutter_widgetkit/flutter_widgetkit.dart';

import 'dart:convert';

void main() {
  runApp(const MaterialApp(home: TextPage()));
}

class TextPage extends StatefulWidget {
  const TextPage({super.key});

  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: textController,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  WidgetKit.setItem(
                      'widgetData',
                      jsonEncode(WidgetData(textController.text)),
                      'group.boardwidget');
                  WidgetKit.reloadAllTimelines();
                },
                child: Text("Push to Widget"))
          ],
        ),
      ),
    );
  }
}

class WidgetData {
  final String text;
  WidgetData(this.text);

  WidgetData.fromJson(Map<String, dynamic> json) : text = json['text'];
  Map<String, dynamic> toJson() => {'text': text};
}
