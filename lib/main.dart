import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amit Vaghela Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(primary: Colors.blueAccent),
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Roboto',
        cardColor: Colors.grey[900],
      ),
      home: PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  final Uri _linkedin = Uri.parse('https://www.linkedin.com/in/amit-vaghela-01011991');
  final Uri _stackoverflow = Uri.parse('https://stackoverflow.com/users/2826147/amit-vaghela');
  final Uri _email = Uri.parse('mailto:vaghela.aamit@gmail.com');

  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _sectionCard(String title, List<Widget> children) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _infoText(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(content, style: TextStyle(fontSize: 14, height: 1.4)),
    );
  }

  Widget _projectLink(String name, String url) {
    return GestureDetector(
      onTap: () => _launchUrl(Uri.parse(url)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Text(
          name,
          style: TextStyle(
              color: Colors.blueAccent, decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amit Vaghela'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text('Lead Software Engineer',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            _sectionCard('About Me', [
              _infoText(
                  '11+ years of experience in mobile app development (Android, iOS, Flutter). Skilled in building scalable, testable, and high-performance applications.'),
            ]),

            _sectionCard('Work Experience', [
              _infoText(
                  'Freelance Mobile App Developer (2019–Present)\n• Full lifecycle development\n• Team collaboration\n• Architecture & testing'),
              _infoText(
                  'EasyPay Pvt Ltd (2017–2019)\n• Architecture and design\n• Debugging and lifecycle management'),
              _infoText(
                  'Value Chain Solutions (2015–2017)\n• Project planning\n• SOPs and lifecycle handling'),
              _infoText(
                  'smartSense Solutions (2014–2015)\n• Client requirements\n• Development and documentation'),
              _infoText(
                  'Agite Technologies (2013–2014)\n• Bug fixing\n• Feature implementation and testing'),
            ]),

            _sectionCard('Skills', [
              _infoText(
                  'Flutter, Android, Kotlin, iOS, Core Java, Git, Firebase, Web Services, Agile Methodology'),
            ]),

            _sectionCard('Projects', [
              _projectLink('MaxPlay',
                  'https://play.google.com/store/apps/details?id=com.maxplay.design'),
              _projectLink('Paisa Nikal',
                  'https://play.google.com/store/apps/details?id=aepsapp.paisanikal.com.aepsandroid&hl=en_US'),
              _infoText('Other Projects: Fast App, E-commerce App, MyStore TV, Remote App, Wow App'),
            ]),

            _sectionCard('Education', [
              _infoText('B.Tech - Gujarat Technological University (2008–2012)'),
            ]),

            _sectionCard('Languages', [
              _infoText('English (Professional), Hindi (Native)'),
            ]),

            _sectionCard('Contact', [
              _infoText('Email: vaghela.aamit@gmail.com'),
              _infoText('Phone: 9510039456'),
              Wrap(
                spacing: 10,
                children: [
                  OutlinedButton(
                      onPressed: () => _launchUrl(_linkedin),
                      child: Text('LinkedIn')),
                  OutlinedButton(
                      onPressed: () => _launchUrl(_stackoverflow),
                      child: Text('StackOverflow')),
                  OutlinedButton(
                      onPressed: () => _launchUrl(_email),
                      child: Text('Email Me')),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}
