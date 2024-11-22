import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyBox extends StatefulWidget {
  const EmergencyBox({Key? key}) : super(key: key);

  @override
  _EmergencyBoxState createState() => _EmergencyBoxState();
}

class _EmergencyBoxState extends State<EmergencyBox> {
  final TextEditingController semesterTEController = TextEditingController();
  final TextEditingController idTEController = TextEditingController();
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController batchTEController = TextEditingController();
  final TextEditingController sectionTEController = TextEditingController();
  final TextEditingController courseCodeTEController = TextEditingController();
  final TextEditingController courseNameTEController = TextEditingController();
  final TextEditingController teacherNameTEController = TextEditingController();
  final TextEditingController teacherDepartmentTEController =
      TextEditingController();
  final TextEditingController teacherDesignationTEController =
      TextEditingController();
  final TextEditingController dateTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static String selectedOption = 'Choose Severity';
  // static String? marksImg;

  bool isGeneratingPDF = false;

  @override
  void initState() {
    super.initState();
    // _loadSavedData();
  }

  void _updateContent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Box',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(160, 24, 160, 24),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 45,
                    ),
                    DropdownButton<String>(
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue!;
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
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    selectedOption == 'Choose Severity'
                        ? const Text(
                            'SEV 5 : Deficiency')
                        : Text('Choose Severity $selectedOption'),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Patient Name',
                      semesterTEController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Age',
                      idTEController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text('Choose Patient Gender :'),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Gender',
                      nameTEController,
                    ),
                     const SizedBox(
                      height: 16,
                    ),
                    Text('Contact Information :'),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Phone Number',
                      batchTEController,
                    ),
                     const SizedBox(
                      height: 16,
                    ),
                    Text('Address :'),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Address',
                      sectionTEController,
                    ),
                     const SizedBox(
                      height: 16,
                    ),
                    Text('Emergency Details :'),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Symptoms',
                      courseCodeTEController,
                    ),
                     const SizedBox(
                      height: 16,
                    ),
                    Text('Enter Your Details :'),
                    const SizedBox(
                      height: 16,
                    ),

                    textFormField(
                      'Name',
                      courseNameTEController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Phone',
                      teacherNameTEController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Email Address',
                      teacherDesignationTEController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      'Accident Occurence Time',
                      teacherDepartmentTEController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    textFormField(
                      '-----',
                      dateTEController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(140, 76, 119, 121),
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isGeneratingPDF
                                ? const CircularProgressIndicator(
                                    color: Colors.green,
                                    backgroundColor: Colors.black,
                                  )
                                : const Icon(Icons.generating_tokens),
                            const Text(
                              'Generate Cover Page',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      selectedOption = prefs.getString('selectedOption') ?? 'Select Cover Page';
      semesterTEController.text = prefs.getString('semester') ?? '';
      idTEController.text = prefs.getString('studentID') ?? '';
      nameTEController.text = prefs.getString('studentName') ?? '';
      batchTEController.text = prefs.getString('batch') ?? '';
      sectionTEController.text = prefs.getString('section') ?? '';
      courseCodeTEController.text = prefs.getString('courseCode') ?? '';
      courseNameTEController.text = prefs.getString('courseName') ?? '';
      teacherNameTEController.text = prefs.getString('teacherName') ?? '';
      teacherDepartmentTEController.text =
          prefs.getString('teacherDepartment') ?? '';
      teacherDesignationTEController.text =
          prefs.getString('teacherDesignation') ?? '';
      dateTEController.text = prefs.getString('submissionDate') ?? '';
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('selectedOption', selectedOption);
    prefs.setString('semester', semesterTEController.text);
    prefs.setString('studentID', idTEController.text);
    prefs.setString('studentName', nameTEController.text);
    prefs.setString('batch', batchTEController.text);
    prefs.setString('section', sectionTEController.text);
    prefs.setString('courseCode', courseCodeTEController.text);
    prefs.setString('courseName', courseNameTEController.text);
    prefs.setString('teacherName', teacherNameTEController.text);
    prefs.setString('teacherDepartment', teacherDepartmentTEController.text);
    prefs.setString('teacherDesignation', teacherDesignationTEController.text);
    prefs.setString('submissionDate', dateTEController.text);
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

  AppBar appBar() {
    return AppBar(
      elevation: 10,
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      toolbarHeight: 100,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      automaticallyImplyLeading: false,
      centerTitle: true,
      flexibleSpace: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/cpg_logo.png'),
                  fit: BoxFit.fill)),
        ),
      ),
    );
  }
}
