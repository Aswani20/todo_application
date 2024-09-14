import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../firebase_utils.dart';
import '../model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = "en";
  ThemeMode appTheme = ThemeMode.light;
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  AppConfigProvider() {
    loadPreferences();
  }

  void changeLanguage(newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    savePreferences();
    notifyListeners();
  }

  void changeTheme(newMode) async {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    savePreferences();
    notifyListeners();
  }

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasksList = tasksList.where((task) {
      if (task.date?.day == selectDate.day &&
          task.date?.month == selectDate.month &&
          task.date?.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();

    tasksList.sort((Task task1, Task task2) {
      return task1.date!.compareTo(task2.date!);
    });
    notifyListeners();
  }

  void changeSelectedDate(newSelectedDate, String uId) {
    selectDate = newSelectedDate;
    getAllTasksFromFireStore(uId);
    notifyListeners();
  }

  void savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appLanguage', appLanguage);
    prefs.setString('appTheme', appTheme == ThemeMode.dark ? 'dark' : 'light');
  }

  void loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('appLanguage') ?? "en";
    appTheme = (prefs.getString('appTheme')) == 'dark'
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
