import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import '../../auth/login/login_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../dialog_utils/dialog_utils.dart';
import '../../firebase_utils.dart';
import '../../model/task.dart';
import '../../provider/app_config_provider.dart';
import '../../provider/auth_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = "EditTaskScreen";

  const EditTaskScreen({super.key});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  DateTime selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late AppConfigProvider provider;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Task? task;

  @override
  Widget build(BuildContext context) {
    if (task == null) {
      task = ModalRoute.of(context)!.settings.arguments as Task;
      titleController.text = task!.title ?? "";
      descController.text = task!.description ?? "";
      selectedDate = task!.date ?? DateTime.now();
    }
    provider = Provider.of<AppConfigProvider>(context);
    var screenSize = MediaQuery.of(context).size;
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
          AppLocalizations.of(context)!.todo_list,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenSize.height * 0.13,
                  decoration: BoxDecoration(
                    color: MyTheme.primaryLightColor,
                  ),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: screenSize.height * 0.07),
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize.height * 0.03,
                        horizontal: screenSize.height * 0.01),
                    width: screenSize.width * 0.87,
                    height: screenSize.height * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: provider.appTheme == ThemeMode.dark
                            ? MyTheme.blackDark
                            : MyTheme.whiteColor),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.edit_task,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(
                          height: screenSize.height * 0.02,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.titleSmall,
                                  controller: titleController,
                                  // onChanged: (text) {
                                  //   title = text;
                                  // },
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .enter_your_task;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: provider.appTheme ==
                                                    ThemeMode.light
                                                ? MyTheme.blackColor
                                                : MyTheme.whiteColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: provider.appTheme ==
                                                    ThemeMode.light
                                                ? MyTheme.blackColor
                                                : MyTheme.whiteColor),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: MyTheme.redColor)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: MyTheme.redColor)),
                                      hintText: AppLocalizations.of(context)!
                                          .enter_your_task,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.titleSmall,
                                  controller: descController,
                                  // onChanged: (text) {
                                  //   description = text;
                                  // },
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .enter_your_Task_description;
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: provider.appTheme ==
                                                    ThemeMode.light
                                                ? MyTheme.blackColor
                                                : MyTheme.whiteColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: provider.appTheme ==
                                                    ThemeMode.light
                                                ? MyTheme.blackColor
                                                : MyTheme.whiteColor),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: MyTheme.redColor)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: MyTheme.redColor)),
                                      hintText: AppLocalizations.of(context)!
                                          .enter_your_Task_description,
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18)),
                                  maxLines: 4,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  AppLocalizations.of(context)!.select_date,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.02),
                                child: InkWell(
                                  onTap: () {
                                    showCalender();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color:
                                          provider.appTheme == ThemeMode.light
                                              ? MyTheme.backgroundLight
                                              : Colors.white24,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      DateFormat.yMd().format(selectedDate),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.015),
                                child: ElevatedButton(
                                  onPressed: () {
                                    editTask();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          MyTheme.primaryLightColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text(
                                    AppLocalizations.of(context)!.save_changes,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }

  void editTask() {
    if (_formKey.currentState?.validate() == true) {
      task!.title = titleController.text;
      task!.description = descController.text;
      task!.date = selectedDate;
      var authProvider = Provider.of<AuthProvider1>(context, listen: false);
      DialogUtils.showLoading(context, AppLocalizations.of(context)!.waiting);
      FirebaseUtils.editTask(task!, authProvider.currentUser?.id ?? "")
          .then((value) {
        DialogUtils.hideLoading(context);
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.task_edit_successfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: MyTheme.greenColor,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } else {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.no_data_to_add,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: MyTheme.redColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
