import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/home/task_list/edit_task_screen.dart';
import 'package:todo/model/task.dart';
import 'package:todo/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/app_config_provider.dart';
import '../../provider/auth_provider.dart';

class TaskWidgetItem extends StatefulWidget {
  Task task;

  TaskWidgetItem({super.key, required this.task});

  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: provider.appLanguage == "en"
                ? Alignment.centerLeft
                : Alignment.centerRight,
            end: provider.appLanguage == "en"
                ? Alignment.centerRight
                : Alignment.centerLeft,
            colors: [MyTheme.redColor, MyTheme.greenColor]),
        // color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(8),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: provider.appLanguage == "en"
                  ? const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15))
                  : const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
              onPressed: (context) {
                Navigator.pushNamed(context, EditTaskScreen.routeName,
                    arguments: widget.task);
              },
              backgroundColor: MyTheme.greenColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: provider.appLanguage == "en"
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))
                  : const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
              onPressed: (context) {
                var authProvider =
                    Provider.of<AuthProvider1>(context, listen: false);
                FirebaseUtils.removeTaskFromFireStore(
                        widget.task, authProvider.currentUser?.id ?? "")
                    .then((value) {
                  Fluttertoast.showToast(
                      msg: provider.appLanguage == "en"
                          ? "Task Remove Successfully"
                          : "تَمَّ مسح الْمُهِمَّة بِنَجَاح",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: MyTheme.greenColor,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: provider.appTheme == ThemeMode.light
                        ? MyTheme.blackColor.withOpacity(0.1)
                        : MyTheme.whiteColor.withOpacity(.1))
              ],
              borderRadius: BorderRadius.circular(15),
              color: provider.appTheme == ThemeMode.light
                  ? MyTheme.whiteColor
                  : MyTheme.blackDark),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * 0.01,
                height: MediaQuery.of(context).size.height * 0.1,
                color: widget.task.isDone!
                    ? MyTheme.greenColor
                    : MyTheme.primaryLightColor,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.task.title ?? ' ',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: widget.task.isDone!
                                ? MyTheme.greenColor
                                : MyTheme.primaryLightColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.description ?? " ",
                          style: Theme.of(context).textTheme.titleSmall),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  var authProvider =
                      Provider.of<AuthProvider1>(context, listen: false);
                  FirebaseUtils.editIsDone(
                      widget.task, authProvider.currentUser?.id ?? "");
                },
                child: widget.task.isDone!
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.is_done,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: MyTheme.greenColor),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: MyTheme.primaryLightColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          Icons.check,
                          color: MyTheme.whiteColor,
                          size: 35,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
