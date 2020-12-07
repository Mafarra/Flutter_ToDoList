import 'package:flutter/material.dart';
import 'package:flutter_app_gsg_2/task_mokUp.dart';
import 'model/tasks_model.dart';
class TabBarBottomNavigationBar extends StatefulWidget {
  @override
  _TabBarBottomNavigationBar createState() => _TabBarBottomNavigationBar();
}
main() {
  runApp(TabBarBottomNavigationBar());
}
class _TabBarBottomNavigationBar extends State<TabBarBottomNavigationBar> with SingleTickerProviderStateMixin {
  TabController tabController;
  List completedList=[];
  List unCompletedList=[];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    completedList = tasks.where((element) => element.isComplete==true)
        .map((e) => ToDOWidget(e))
        .toList();
    unCompletedList = tasks.where((element) =>!element.isComplete)
        .map((e) => ToDOWidget(e))
        .toList();
  }
  int bnbIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('To Do List'),
          bottom: TabBar(
            controller: tabController,
            tabs: [
              Tab(child: Text('All Tasks')),
              Tab(child: Text('Complete Tasks')),
              Tab(child: Text('Incomplete Tasks')),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            Column(
              children: tasks.map((e) => ToDOWidget(e)).toList(),
            ),
            Column(
              children: completedList,
            ),
            Column(
              children: unCompletedList,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: tabController.index,
          onTap: (value) {
            tabController.animateTo(value);
            //bnbIndex = value;
            setState(() {
              for(var i in tasks){
               completedList = tasks.where((element) => element.isComplete==true)
                    .map((e) => ToDOWidget(e))
                    .toList();
               unCompletedList = tasks.where((element) =>!element.isComplete)
                    .map((e) => ToDOWidget(e))
                    .toList();
              }
            });
          },
          items: [
            BottomNavigationBarItem(label: 'All Tasks', icon: Icon(Icons.menu)),
            BottomNavigationBarItem(
                label: 'Complete Tasks', icon: Icon(Icons.done)),
            BottomNavigationBarItem(
                label: 'Incomplete Tasks', icon: Icon(Icons.close)),
          ],
        ),
      ),
    );
  }
}
class ToDOWidget extends StatefulWidget {
  Task task;
  Function fun;
  ToDOWidget(this.task, {this.fun});
  @override
  _ToDOWidget createState() => _ToDOWidget();
}
class _ToDOWidget extends State<ToDOWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.task.taskName),
            Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  //widget.fun(value);
                  widget.task.isComplete = value;
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}

/*
 TabBarView(
          controller: tabController,
          children: [
            Center(
              child: Text('All Tasks'),
            ),
            Center(
              child: Text('Complete Tasks'),
            ),
            Center(
              child: Text('Incomplete Tasks'),
            ),
          ],
        ),
*/
