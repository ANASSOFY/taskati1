import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskati/screens/day.dart';
import 'package:taskati/widgets/task_item.dart';

class HomeScreens extends StatelessWidget {
  final String userName;
  final File? pickedImage;

  const HomeScreens({
    super.key,
    required this.userName,
    this.pickedImage,
  });

  @override
  Widget build(BuildContext context) {
    final String todayDate =
        DateFormat('MMMM d, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, $userName ",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                    backgroundImage:
                        pickedImage != null ? FileImage(pickedImage!) : null,
                    child: pickedImage == null
                        ? const Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.deepPurple,
                          )
                        : null,
                  ),
                ],
              ),

              const SizedBox(height: 25),

    
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
                      const SizedBox(height: 4),
                      const Text(
                        "Today",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "+ Add Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

            
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final date =
                        DateTime.now().add(Duration(days: index));

                    return DayItem(
                      date: date,
                      active: index == 0,
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: const [
                    TaskItem(
                      title: "Flutter Task - 1",
                      time: "02:25 AM - 02:40 AM",
                      subtitle: "I will do This Task",
                      color: Colors.deepPurple,
                    ),
                    TaskItem(
                      title: "Flutter Task - 2",
                      time: "4:27 PM - 6:42 PM",
                      subtitle: "I will do This Task",
                      color: Colors.redAccent,
                    ),
                    TaskItem(
                      title: "Flutter Task - 3",
                      time: "7:27 PM - 9:43 PM",
                      subtitle: "I will do This Task",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    TaskItem(
                      title: "Flutter Task - 4",
                      time: "7:27 PM - 9:43 PM",
                      subtitle: "I will do This Task",
                      color: Colors.orangeAccent,
                    ),
                    TaskItem(
                      title: "Flutter Task - 5",
                      time: "7:27 PM - 9:43 PM",
                      subtitle: "I will do This Task",
                      color: Color.fromARGB(255, 255, 0, 0),
                    ),
                    TaskItem(
                      title: "Flutter Task - 6",
                      time: "7:27 PM - 9:43 PM",
                      subtitle: "I will do This Task",
                      color: Color.fromARGB(255, 0, 54, 192),
                    ),
                    TaskItem(
                      title: "Flutter Task - 7",
                      time: "7:27 PM - 9:43 PM",
                      subtitle: "I will do This Task",
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    TaskItem(
                      title: "Flutter Task - 8",
                      time: "7:27 PM - 9:43 PM",
                      subtitle: "I will do This Task",
                      color: Color.fromARGB(255, 171, 7, 221),
                    ),
                    TaskItem(
                      title: "Flutter Task - 9",
                      time: "7:27 PM - 9:43 PM",
                      subtitle: "I will do This Task",
                      color: Color.fromARGB(255, 255, 145, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
