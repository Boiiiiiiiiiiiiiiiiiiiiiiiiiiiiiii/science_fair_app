import 'package:flutter/material.dart';
import 'package:science_fair_app/data/notifiers.dart';
import 'package:science_fair_app/views/pages/advices_page.dart';
import 'package:science_fair_app/views/pages/debts_info_page.dart';
import 'package:science_fair_app/views/pages/glossary_page.dart';
import 'package:science_fair_app/views/pages/homepage.dart';
import 'package:science_fair_app/views/pages/settings_page.dart';
import 'package:science_fair_app/views/widgets/navbar_widget.dart';

List<Widget> pages = [Homepage(), DebtsInfoPage(), AdvicesPage(), GlossaryPage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/appbar_logo.png",
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          'Zhospar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2
          ),
          ),
        actions: [
          ValueListenableBuilder(valueListenable: isDarkThemeNotifier, builder: (context, isDark, child) {
            return IconButton(
              onPressed: () async{
                isDarkThemeNotifier.value = !isDarkThemeNotifier.value;
              }, 
              icon: isDarkThemeNotifier.value ? Icon(Icons.dark_mode) : Icon(Icons.sunny)
            );
          },
          ),
          /*IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SettingsPage(title: "Settings Page");
              }
              )
              );
            }, 
            icon: Icon(Icons.settings)
          )*/
        ],
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavBarWidget()
    );
  }
}