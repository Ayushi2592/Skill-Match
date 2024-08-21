import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skill_match/model/profile_model.dart';
import 'package:skill_match/model/profile_notifier.dart';
import 'package:skill_match/screens/profile_screen.dart';

class MakeProfileScreen extends StatefulWidget {
  const MakeProfileScreen({Key? key}) : super(key: key);

  @override
  State<MakeProfileScreen> createState() => _MakeProfileScreenState();
}

class _MakeProfileScreenState extends State<MakeProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController academicYearController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController linkedinController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      Profile newProfile = Profile(
        name: nameController.text,
        contactNumber: contactNumberController.text,
        academicYear: academicYearController.text,
        branch: branchController.text,
        skills: skillsController.text,
        githubLink: githubController.text,
        linkedinId: linkedinController.text,
      );

      // You can print the newProfile here to debug
      print(newProfile);

      // Navigate to the profile screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(profile: newProfile),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Your app bar configuration
      ),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextField('Name', nameController, TextInputType.text),
              buildTextField(
                  'Contact Number', contactNumberController, TextInputType.phone),
              buildTextField('Academic Year', academicYearController, TextInputType.text),
              buildTextField('Branch', branchController, TextInputType.text),
              buildTextField('Skills', skillsController, TextInputType.text),
              buildTextField('Github Repo link', githubController, TextInputType.url),
              buildTextField('Linkedin Id', linkedinController, TextInputType.text),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProfile,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE57734),
                ),
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Notify profile added
                    Provider.of<ProfileNotifier>(context, listen: false)
                        .notifyProfileAdded();

                    // Clear text controllers
                    nameController.clear();
                    contactNumberController.clear();
                    academicYearController.clear();
                    branchController.clear();
                    skillsController.clear();
                    githubController.clear();
                    linkedinController.clear();

                    // Navigate back
                    Navigator.pop(context);
                  },
                  child: Text('Add Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE57734)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE57734)),
          ),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}