import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String name;
  String email;
  Timestamp createdOn;
  bool isPending;
  bool isCompleted;

  Users({
    required this.name,
    required this.email,
    required this.createdOn,
    required this.isPending,
    required this.isCompleted,
  });

  Users.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          email: json['email']! as String,
          createdOn: json['createdOn']! as Timestamp,
          isPending: json['isPending']! as bool,
          isCompleted: json['isCompleted']! as bool,
        );

  Users copyWith({
    String? name,
    String? email,
    Timestamp? updatedOn,
    bool? isPending,
    bool? isCompleted,
  }) {
    return Users(
      name: name ?? this.name,
      email: email ?? this.email,
      createdOn: createdOn ?? this.createdOn,
      isPending: isPending ?? this.isPending,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'email': email,
      'createdOn': createdOn,
      'isPending': isPending,
      'isCompleted': isCompleted,
    };
  }
}
