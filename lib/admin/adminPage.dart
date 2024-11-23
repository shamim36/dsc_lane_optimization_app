import 'package:dsc_lane_optimization_app/admin/detailsPage.dart';
import 'package:dsc_lane_optimization_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/users.dart';

class Adminpage extends StatefulWidget {
  const Adminpage({super.key});

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUI(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      centerTitle: true,
      title: const Text(
        'Admin',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Column(
        children: [
          _messagesListView(),
        ],
      ),
    );
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
        stream: _databaseService.getUsers(),
        builder: (context, snapshot) {
          List users = snapshot.data?.docs ?? [];
          if (users.isEmpty) {
            return const Center(
              child: Text('There is No Pending Request!'),
            );
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              Users user = users[index].data();
              String userId = users[index].id;
              // print(userId);
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsPage(user: user, userId: userId),
                      ),
                    );
                  },
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    title: Text(user.name),
                    subtitle: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Symptoms: ' + user.symptomsDescription),
                            Text('Emergency Signal Time : ' + user.createdOn),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Pending/Accepted button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: user.isPending
                                ? Colors.red
                                : Colors.green, // Button color
                          ),
                          onPressed: () {
                            // Toggle isPending and update the user
                            Users updatedUser = user.copyWith(
                              isPending: !user.isPending,
                              isCompleted: false, // Ensure logical consistency
                            );
                            _databaseService.updateUser(userId, updatedUser);
                          },
                          child: Text(
                            user.isPending ? 'Pending...' : 'Accepted',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8), // Add spacing between buttons

                        // Completed/Ongoing button (only shown when isPending is false)
                        if (!user.isPending)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: user.isCompleted
                                  ? Colors.green
                                  : Colors.red, // Button color
                            ),
                            onPressed: () {
                              // Toggle isCompleted and update the user
                              Users updatedUser = user.copyWith(
                                isCompleted: !user.isCompleted,
                              );
                              _databaseService.updateUser(userId, updatedUser);
                            },
                            child: Text(
                              user.isCompleted ? 'Completed' : 'Ongoing...',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
