import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';
import '../widgets/task_item.dart';
import 'add_task_screen.dart';

class HomeScreens extends StatefulWidget {
  final String userName;
  final File? pickedImage; // ✅ تمرير الصورة

  const HomeScreens({
    super.key,
    required this.userName,
    this.pickedImage,
  });

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();

  List<DateTime> getWeekDays() {
    final today = DateTime.now();
    return List.generate(7, (index) {
      return DateTime(today.year, today.month, today.day + index);
    });
  }

  List<TaskModel> getFilteredTasks() {
    return tasks.where((task) {
      return task.date.year == selectedDate.year &&
          task.date.month == selectedDate.month &&
          task.date.day == selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final todayDate = DateFormat('MMMM d, yyyy').format(selectedDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -------- Header --------
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${widget.userName}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Have a nice day.",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    backgroundImage: widget.pickedImage != null
                        ? FileImage(widget.pickedImage!) // ✅ عرض الصورة
                        : null,
                    child: widget.pickedImage == null
                        ? const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.deepPurple,
                          )
                        : null,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // -------- Date & Add Button --------
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todayDate,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Selected Day",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      final task = await Navigator.push<TaskModel>(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddTaskScreen(selectedDate: selectedDate),
                        ),
                      );

                      if (task != null) {
                        setState(() => tasks.add(task));
                      }
                    },
                    child: const Text(
                      "+ Add Task",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // -------- Days Bar --------
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getWeekDays().length,
                  itemBuilder: (context, index) {
                    final day = getWeekDays()[index];
                    final isSelected =
                        day.year == selectedDate.year &&
                        day.month == selectedDate.month &&
                        day.day == selectedDate.day;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = day;
                        });
                      },
                      child: Container(
                        width: 70,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.deepPurple
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEE').format(day),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              day.day.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // -------- Tasks --------
              Expanded(
                child: getFilteredTasks().isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        itemCount: getFilteredTasks().length,
                        itemBuilder: (context, index) {
                          final task = getFilteredTasks()[index];
                          return Dismissible(
                            key: ValueKey(task.title + index.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              color: Colors.red,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) {
                              setState(() => tasks.remove(task));
                            },
                            child: TaskItem(
                              title: task.title,
                              subtitle: task.description,
                              time: task.time,
                              color: task.color,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/empty_tasks.png",
            width: 200,
          ),
          const SizedBox(height: 24),
          const Text(
            "",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
