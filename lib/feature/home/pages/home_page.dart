import 'package:flutter/material.dart';
import 'package:whatsapp_messenger/common/widgets/custom_icon_button.dart';
import 'package:whatsapp_messenger/feature/home/pages/call_home_page.dart';
import 'package:whatsapp_messenger/feature/home/pages/chat_home_page.dart';
import 'package:whatsapp_messenger/feature/home/pages/status_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("WhatsApp"),
            elevation: 1,
            actions: [
              CustomIconButton(onTap: () {}, icon: Icons.search),
              CustomIconButton(onTap: () {}, icon: Icons.more_vert)
            ],
            bottom: const TabBar(
                indicatorWeight: 3,
                labelStyle: TextStyle(fontWeight: FontWeight.bold, height: 4),
                splashFactory: NoSplash.splashFactory,
                tabs: [Text('CHATS'), Text('STATUS'), Text('CALLS')]),
          ),
          body: const TabBarView(
              children: [ChatHomePage(), StatusHomePage(), CallHomePage()]),
        ));
  }
}
