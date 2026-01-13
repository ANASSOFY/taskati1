import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  final DateTime selectedDate;

  const AddTaskScreen({
    super.key,
    required this.selectedDate,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}


class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 8);
  TimeOfDay endTime = const TimeOfDay(hour: 9, minute: 8);

  Color selectedColor = Colors.deepPurple;

  // -------- Pick Date --------
  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  // -------- Pick Time --------
  Future<void> pickTime(bool isStart) async {
    final time = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
    );

    if (time != null) {
      setState(() {
        if (isStart) {
          startTime = time;
        } else {
          endTime = time;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        centerTitle: true,
      ),

      // 🔥 الجزء المهم (الـ Scroll)
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // -------- Title --------
              const Text("Title"),
              const SizedBox(height: 6),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // -------- Description --------
              const Text("Description"),
              const SizedBox(height: 6),
              TextField(
                controller: descController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // -------- Date --------
              const Text("Date"),
              const SizedBox(height: 6),
              InkWell(
                onTap: pickDate,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // -------- Time --------
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Start Time"),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () => pickTime(true),
                          child: timeBox(startTime),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("End Time"),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () => pickTime(false),
                          child: timeBox(endTime),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // -------- Colors --------
              const Text("Color"),
              const SizedBox(height: 10),
              Row(
                children: [
                  colorCircle(Colors.deepPurple),
                  colorCircle(Colors.orange),
                  colorCircle(const Color.fromARGB(255, 0, 0, 0)),
                  colorCircle(Colors.redAccent),
                ],
              ),

              const SizedBox(height: 30),

              // -------- Create Button --------
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    final task = TaskModel(
                      title: titleController.text,
                      description: descController.text,
                      time:
                          "${startTime.format(context)} - ${endTime.format(context)}",
                      color: selectedColor,
                      date: selectedDate,
                    );

                    Navigator.pop(context, task);
                  },
                  child: const Text(
                    "Create Task",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------- Helpers --------
  Widget timeBox(TimeOfDay time) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time.format(context)),
          const Icon(Icons.access_time),
        ],
      ),
    );
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() => selectedColor = color);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selectedColor == color
              ? Border.all(color: Colors.black, width: 2)
              : null,
        ),
      ),
    );
  }
}
