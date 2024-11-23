import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String name;
  String email;
  String createdOn;
  bool isPending;
  bool isCompleted;
  String location;
  String phone;
  String severity;
  String taskAcceptedOn;
  String taskCompletedOn;
  String symptomsDescription;

  Users({
    required this.name,
    required this.email,
    required this.createdOn,
    required this.isPending,
    required this.isCompleted,
    required this.location,
    required this.phone,
    required this.severity,
    required this.taskAcceptedOn,
    required this.taskCompletedOn,
    required this.symptomsDescription,
  });

  Users.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          email: json['email']! as String,
          createdOn: json['createdOn']! as String,
          isPending: json['isPending']! as bool,
          isCompleted: json['isCompleted']! as bool,
          location: json['location']! as String,
          phone: json['phone']! as String,
          severity: json['severity']! as String,
          taskAcceptedOn: json['taskAcceptedOn']! as String,
          taskCompletedOn: json['taskCompletedOn']! as String,
          symptomsDescription: json['symptomsDescription']! as String,
        );

  Users copyWith({
    String? name,
    String? email,
    String? updatedOn,
    bool? isPending,
    bool? isCompleted,
    String? location,
    String? phone,
    String? severity,
    String? taskAcceptedOn,
    String? taskCompletedOn,
    String? symptomsDescription,
  }) {
    return Users(
      name: name ?? this.name,
      email: email ?? this.email,
      createdOn: createdOn ?? this.createdOn,
      isPending: isPending ?? this.isPending,
      isCompleted: isCompleted ?? this.isCompleted,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      severity: severity ?? this.severity,
      taskAcceptedOn: taskAcceptedOn ?? this.taskAcceptedOn,
      taskCompletedOn: taskCompletedOn ?? this.taskCompletedOn,
      symptomsDescription: symptomsDescription ?? this.symptomsDescription,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'createdOn': createdOn,
      'isPending': isPending,
      'isCompleted': isCompleted,
      'location': location,
      'phone': phone,
      'severity': severity,
      'taskAcceptedOn': taskAcceptedOn,
      'taskCompletedOn': taskCompletedOn,
      'symptomsDescription': symptomsDescription,
    };
  }
}
