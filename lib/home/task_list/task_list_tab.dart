import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home/task_list/task_widget_item.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/provider/auth_provider.dart';
import '../../provider/app_config_provider.dart';

class TaskListTab extends StatefulWidget {
  const TaskListTab({super.key});

  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthProvider1>(context);
    provider.getAllTasksFromFireStore(authProvider.currentUser?.id ?? "");
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.13,
              color: MyTheme.primaryLightColor,
            ),
            EasyDateTimeLine(
              locale: provider.appLanguage,
              initialDate: provider.selectDate,
              onDateChange: (selectedDate) {
                provider.changeSelectedDate(
                    selectedDate, authProvider.currentUser?.id ?? "");
              },
              activeColor: MyTheme.primaryLightColor,
              headerProps: EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                selectedDateStyle: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(
                        color: provider.appTheme == ThemeMode.light
                            ? MyTheme.whiteColor
                            : MyTheme.blackTextColor),
                monthStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: provider.appTheme == ThemeMode.light
                        ? MyTheme.whiteColor
                        : MyTheme.blackTextColor),
                dateFormatter: const DateFormatter.dayOnly(),
              ),
              dayProps: EasyDayProps(
                todayHighlightColor: MyTheme.selectedDayColor,
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                        border: Border.all(color: MyTheme.whiteColor, width: 2),
                        borderRadius: BorderRadius.circular(15),
                        color: MyTheme.primaryLightColor)),
                inactiveDayStyle: DayStyle(
                  monthStrStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.blackDark
                          : MyTheme.whiteColor),
                  dayStrStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.blackDark
                          : MyTheme.whiteColor),
                  dayNumStyle: TextStyle(
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.blackDark
                          : MyTheme.whiteColor),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: provider.appTheme == ThemeMode.light
                              ? MyTheme.blackColor
                              : MyTheme.whiteColor,
                          blurRadius: 0.1,
                        )
                      ],
                      borderRadius: BorderRadius.circular(15),
                      color: provider.appTheme == ThemeMode.light
                          ? MyTheme.whiteColor
                          : MyTheme.blackDark),
                ),
              ),
              timeLineProps: const EasyTimeLineProps(
                hPadding: 16.0, // padding from left and right
                separatorPadding: 16.0, // padding between days
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => TaskWidgetItem(
              task: provider.tasksList[index],
            ),
            itemCount: provider.tasksList.length,
          ),
        )
      ],
    );
  }
}
