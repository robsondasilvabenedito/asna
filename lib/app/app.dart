import 'package:flutter/material.dart';
import 'package:asna/app/common/model/args.dart';
import 'package:asna/app/common/provider/app_provider.dart';
import 'package:asna/app/common/widget/tag_list.dart';
import 'package:asna/app/features/home/home_view.dart';
import 'package:asna/app/features/note/note_view.dart';
import 'package:asna/app/features/tag/tag_view.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  // routes
  static const String routeHome = "/";
  static const String routeNote = "/route";
  static const String routeTag = "/tag";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => TagListProvider()),
      ],
      child: MaterialApp(
        title: "FL_Notes",
        home: const HomeView(),
        onGenerateRoute: (settings) {
          final Args? args = settings.arguments as Args?;

          switch (settings.name) {
            case routeHome:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomeView(),
              );
            case routeNote:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    NoteView(note: args!.note!, tags: args.tags!),
              );
            case routeTag:
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    TagView(tag: args!.tag!),
              );
            default:
              return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const HomeView());
          }
        },
      ),
    );
  }
}
