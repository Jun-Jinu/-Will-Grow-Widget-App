import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_widgetkit/flutter_widgetkit.dart';
import 'package:provider/provider.dart';

import './ui/post/post_viewmodel.dart';
import './ui/post/post_view.dart';

import './ui/new_post/new_post_view.dart';
import './ui/new_post/new_post_viewmodel.dart';

import './ui/setting/setting_view.dart';
import './ui/setting/setting_viewmodel.dart';

import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PostListViewModel>(
            create: (_) => PostListViewModel(), child: PostListView()),
        ChangeNotifierProvider<NewPostViewModel>(
            create: (_) => NewPostViewModel(), child: NewPostView()),
        ChangeNotifierProvider<SettingsViewModel>(
            create: (_) => SettingsViewModel(), child: SettingsView()),
      ],
      child: MaterialApp(
        onGenerateRoute: (route) => onGenerateRoute(route),
        debugShowCheckedModeBanner: false,
        title: '나의 앱 ~',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          primarySwatch: Colors.purple,
        ),
        initialRoute: '/',
      ),
    );
  }
}

// 라우팅
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return CustomPageRoute(page: PostListView());
    case '/newpost':
      return CustomPageRoute(page: NewPostView());
    case '/settings':
      return CustomPageRoute(page: SettingsView());
    default:
      // Handle unknown routes here
      return null;
  }
}

// 화면 전환 애니메이션 제거 라우터
class CustomPageRoute extends PageRouteBuilder {
  final Widget page;

  CustomPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              child,
        );

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}








// void main() {
//   runApp(const MaterialApp(home: TextPage()));
// }

// class TextPage extends StatefulWidget {
//   const TextPage({super.key});

//   @override
//   State<TextPage> createState() => _TextPageState();
// }

// class _TextPageState extends State<TextPage> {
//   var textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 250,
//               child: TextField(
//                 controller: textController,
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   WidgetKit.setItem(
//                       'widgetData',
//                       jsonEncode(WidgetData(textController.text)),
//                       'group.boardwidget');
//                   WidgetKit.reloadAllTimelines();
//                 },
//                 child: Text("Push to Widget"))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WidgetData {
//   final String text;
//   WidgetData(this.text);

//   WidgetData.fromJson(Map<String, dynamic> json) : text = json['text'];
//   Map<String, dynamic> toJson() => {'text': text};
// }
