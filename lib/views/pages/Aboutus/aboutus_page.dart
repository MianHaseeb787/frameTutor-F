import 'package:flutter/material.dart';
import 'package:frametutor/consts/fonts.dart';

import '../../../controllers/about/about_controller.dart';
import '../../../models/about/about_model.dart';
// import 'about_controller.dart';
// import 'about_model.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Future<About> _aboutData = AboutController.fetchAbout();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'About',
          style: appBartitleStyleB,
        ),
      ),
      body: FutureBuilder<About>(
        future: _aboutData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final aboutData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${aboutData.para1}',
                    textAlign: TextAlign.justify,
                    style: para16,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${aboutData.para2}',
                    textAlign: TextAlign.justify,
                    style: para16,
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
