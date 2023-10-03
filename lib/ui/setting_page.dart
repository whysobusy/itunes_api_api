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
            title: Text(translation(context).language),
            children: <Widget>[
              // Add widgets to be shown when expanded
              ListTile(
                title: Text(translation(context).english),
                onTap: () async {
                  Locale locale = await setLocale(ENGLISH);
                  if (!context.mounted) return;
                  MyApp.setLocale(context, locale);
                },
              ),
              ListTile(
                title: Text(translation(context).chinese_s),
                onTap: () async {
                  Locale locale = await setLocale(CHINESE_SIMPLIFIED);
                  if (!context.mounted) return;

                  MyApp.setLocale(context, locale);
                },
              ),

              ListTile(
                title: Text(translation(context).chinese_t),
                onTap: () async {
                  Locale locale = await setLocale(CHINESE_TRADITIONAL);
                  if (!context.mounted) return;

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
