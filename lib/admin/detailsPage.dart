import 'package:flutter/material.dart';
import '../models/users.dart';

class DetailsPage extends StatelessWidget {
  final Users user;
  final String userId;

  const DetailsPage({Key? key, required this.user, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${user.name}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${user.email}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Phone: ${user.phone}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${user.location}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Severity: ${user.severity}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Created On: ${user.createdOn}}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Task Accepted On: ${user.taskAcceptedOn != null ? '${user.taskAcceptedOn}' : "Not Accepted Yet"}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Task Completed On: ${user.taskCompletedOn != null ? "${user.taskCompletedOn}" : "Not Completed Yet"}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Pending: ${user.isPending ? "Yes" : "No"}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Completed: ${user.isCompleted ? "Yes" : "No"}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    child: const Text('Back'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
