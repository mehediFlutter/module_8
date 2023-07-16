import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController daysController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  List<TaskManager> TaskManagers = [
    TaskManager("title", "description", "5 Daus", false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MyAlartDialog(context);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: TaskManagers.length,
        itemBuilder: (context, index) {
          String showTitle = TaskManagers[index].title;
          String showDescription = TaskManagers[index].description;
          String showDeadline = TaskManagers[index].deadline;
          return InkWell(
            onLongPress: () {
              showModalBottomSheet(
                useSafeArea: true,
                isDismissible: false,
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Task Details",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Title: " + showTitle),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Description: " + showDescription),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Days Required: " + showDeadline),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              TaskManagers.removeAt(index);
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(
                TaskManagers[index].title,
              ),
              subtitle: Text(TaskManagers[index].description),
            ),
          );
        },
      ),
    );
  }

  MyAlartDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title", border: OutlineInputBorder()),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: descriptionController,
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(borderSide: BorderSide())),
                ),
                SizedBox(height: 5),
                TextField(
                  controller: daysController,
                  decoration: InputDecoration(
                    hintText: "Days Required",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (titleController.text.trim().isNotEmpty &&
                        descriptionController.text.trim().isNotEmpty &&
                        daysController.text.trim().isNotEmpty) {
                      TaskManagers.add(TaskManager(
                          titleController.text,
                          descriptionController.text,
                          deadlineController.text,
                          false));
                      setState(() {});

                      Navigator.pop(context);
                      titleController.clear();
                      descriptionController.clear();
                      daysController.clear();
                      descriptionController.text.trim();
                    }
                  },
                  child: Text("Save")),
            ],
          );
        });
  }
}

class TaskManager {
  String title, description, deadline;
  bool isDone;
  TaskManager(this.title, this.description, this.deadline, this.isDone);
}
