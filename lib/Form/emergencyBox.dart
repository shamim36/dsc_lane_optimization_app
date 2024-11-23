import 'package:dsc_lane_optimization_app/models/users.dart';
import 'package:dsc_lane_optimization_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmergencyBox extends StatefulWidget {
  const EmergencyBox({Key? key}) : super(key: key);

  @override
  _EmergencyBoxState createState() => _EmergencyBoxState();
}

class _EmergencyBoxState extends State<EmergencyBox> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _severityTEController = TextEditingController();
  final TextEditingController _phoneNumberTEController =
      TextEditingController();
  final TextEditingController _locationTEController = TextEditingController();
  final TextEditingController _createdOnTEController = TextEditingController();

  final TextEditingController _ageTEController = TextEditingController();
  final TextEditingController _genderTEController = TextEditingController();
  final TextEditingController _symptomsDescriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static String selectedOption = 'Choose Severity';

  @override
  void initState() {
    super.initState();
  }

  void _updateContent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Emergency Box',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 45),
                  // Camera Placeholder
                  cameraMethod(context),
                  const SizedBox(height: 20),

                  // Dropdown for severity
                  DropdownButton<String>(
                    isExpanded: true,
                    value: selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOption = newValue!;
                        _severityTEController.text = selectedOption;
                      });
                    },
                    items: <String>[
                      'Choose Severity',
                      'SEV 1 : Critical',
                      'SEV 2 : Significant',
                      'SEV 3 : Moderate',
                      'SEV 4 : Minor',
                      'SEV 5 : Deficiency',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  selectedOption == 'Choose Severity'
                      ? const Text('Severity: SEV 5 : Deficiency')
                      : Text('Selected Severity: $selectedOption'),
                  const SizedBox(height: 16),

                  // Patient Name and Age
                  Row(
                    children: [
                      Expanded(
                        child: textFormField('Patient Name', _nameTEController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: textFormField('Age', _ageTEController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Gender
                  Row(
                    children: [
                      Expanded(
                        child: textFormField('Gender', _genderTEController),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: textFormField(
                            'Phone Number', _phoneNumberTEController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Contact Information

                  const SizedBox(height: 16),

                  // Address
                  const Text('Address:'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child:
                              textFormField('Address', _locationTEController)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: textFormField('Email', _emailTEController)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Emergency Details
                  const Text('Emergency Details:'),
                  const SizedBox(height: 8),
                  textFormField(
                    'Symptoms',
                    _symptomsDescriptionTEController,
                  ),
                  const SizedBox(height: 16),
                  textFormField(
                    'Accident Occurrence Time',
                    _createdOnTEController,
                  ),
                  const SizedBox(height: 16),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          Users user = Users(
                            name: _nameTEController.text,
                            email: _emailTEController.text,
                            createdOn: getCurrentFormattedTime(),
                            isCompleted: false,
                            isPending: true,
                            location: _locationTEController.text,
                            phone: _phoneNumberTEController.text,
                            severity: _severityTEController.text,
                            symptomsDescription:
                                _symptomsDescriptionTEController.text,
                            taskAcceptedOn: "",
                            taskCompletedOn: "",
                          );

                          DatabaseService _detabaseService = DatabaseService();
                          _detabaseService.addUsers(user);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form Submitted Successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack cameraMethod(BuildContext context) {
    return Stack(
      children: [
        RawMaterialButton(
          elevation: 10,
          fillColor: Colors.amberAccent,
          child: Icon(Icons.add_a_photo),
          padding: EdgeInsets.all(15.0),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  title: Center(
                    child: Text(
                      'Choose Option',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        InkWell(
                          onTap: () {},
                          splashColor: Colors.green,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.camera,
                                ),
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          splashColor: Colors.green,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.image,
                                ),
                              ),
                              Text(
                                'Gallery',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          splashColor: Colors.red,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.remove_circle,
                                ),
                              ),
                              Text(
                                'Remove',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  TextFormField textFormField(String name, controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: textFieldDecoration(name),
      validator: (String? value) {
        if (value?.trim().isEmpty ?? true) {
          return 'Enter Your $name';
        } else {
          return null;
        }
      },
    );
  }

  InputDecoration textFieldDecoration(String hintAndlabel) {
    return InputDecoration(
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(),
      hintText: hintAndlabel,
      hintStyle: const TextStyle(color: Color.fromARGB(255, 27, 29, 27)),
      labelText: hintAndlabel,
      labelStyle: const TextStyle(
        color: Colors.black,
      ),
    );
  }

  String getCurrentFormattedTime() {
    final now =
        DateTime.now().toUtc().add(const Duration(hours: 6)); // Adjust to UTC+6
    final dateFormat = DateFormat('MMMM d, y');
    final timeFormat = DateFormat('h:mm:ss a');
    final formattedDate = dateFormat.format(now);
    final formattedTime = timeFormat.format(now);

    return '$formattedDate at $formattedTime UTC+6';
  }
}
