import 'package:flutter/material.dart';

class EmptyTasks extends StatelessWidget {
  const EmptyTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_tasks',
              width: 180,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 24),

            const Text(
              "You do not have any tasks yet!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Add new tasks to make your day productive.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
