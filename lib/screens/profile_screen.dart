import 'package:flutter/material.dart';
import 'package:skill_match/model/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  final Profile profile;

  const ProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: TextStyle(
            color: Color(0xFFE57734),
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFFE57734),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${profile.name}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Contact Number: ${profile.contactNumber}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Academic Year: ${profile.academicYear}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Branch: ${profile.branch}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Skills: ${profile.skills}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Github Link: ${profile.githubLink}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'LinkedIn ID: ${profile.linkedinId}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}