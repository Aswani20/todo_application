import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login/login_screen.dart';
import 'package:todo/home/setting/setting_tab.dart';
import 'package:todo/home/task_list/add_task_bottom_sheet.dart';
import 'package:todo/home/task_list/task_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/provider/app_config_provider.dart';
import '../provider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider1>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                icon: const Icon(Icons.logout)),
          )
        ],
        title: Text(
          selectedIndex == 0
              ? "${AppLocalizations.of(context)!.task_list} ${authProvider.currentUser!.name}"
              : AppLocalizations.of(context)!.setting,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: MyTheme.primaryLightColor.withOpacity(0.3),
              spreadRadius: 7,
              blurRadius: 7,
              offset: const Offset(3, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.list,
                      size: 20,
                    ),
                    label: AppLocalizations.of(context)!.task_list),
                BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.settings,
                      size: 20,
                    ),
                    label: AppLocalizations.of(context)!.setting),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: provider.appTheme == ThemeMode.light
                  ? MyTheme.blackColor.withOpacity(0.4)
                  : MyTheme.whiteColor.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            showAddTaskBottomSheet();
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  List<Widget> tabs = [const TaskListTab(), const SettingTab()];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => const AddTaskBottomSheet(),
    );
  }
}
