import 'package:flutter/material.dart';
import 'package:itunes_api_search_app/language_constants.dart';
import 'package:itunes_api_search_app/main.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Chapter A'),
            children: <Widget>[
              // Add widgets to be shown when expanded
              ListTile(
                title: Text('En'),
                onTap: () async {
                  Locale locale = await setLocale(ENGLISH);
                  MyApp.setLocale(context, locale);
                },
              ),
              ListTile(
                title: Text('cn'),
                onTap: () async {
                  Locale locale = await setLocale(CHINESE_SIMPLIFIED);
                  MyApp.setLocale(context, locale);
                },
              ),

              ListTile(
                title: Text('hk'),
                onTap: () async {
                  Locale locale = await setLocale(CHINESE_TRADITIONAL);
                  MyApp.setLocale(context, locale);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
