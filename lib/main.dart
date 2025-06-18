import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:website_porfolio/WorkExperience.dart';

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
  final Uri _linkedin =
      Uri.parse('https://www.linkedin.com/in/amit-vaghela-01011991');
  final Uri _stackoverflow =
      Uri.parse('https://stackoverflow.com/users/2826147/amit-vaghela');
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
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent)),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
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
            _sectionCard('About Me', [
              _infoText(
                  '11+ years of experience in mobile app development (Android, iOS, Flutter). Skilled in building scalable, testable, and high-performance applications.'),
            ]),
            _sectionCard('Work Experience', [
              AnimationLimiter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    workExperiences.length,
                    (int index) {
                      final exp = workExperiences[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              color: Colors.grey[850],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(exp.title,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent)),
                                    SizedBox(height: 4),
                                    Text(exp.duration,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[400],
                                            fontStyle: FontStyle.italic)),
                                    SizedBox(height: 8),
                                    ...exp.points.map((p) => Row(
                                          children: [
                                            Icon(Icons.arrow_right,
                                                color: Colors.blueAccent,
                                                size: 18),
                                            Expanded(
                                                child: Text(p,
                                                    style: TextStyle(
                                                        fontSize: 14))),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
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
              _infoText('Fast App'),
              _infoText('Kiosk Android App'),
              _infoText('MyStore TV'),
              _infoText('Remote App'),
              _infoText('Wow App'),
            ]),
            _sectionCard('Education', [
              _infoText(
                  'B.Tech - Gujarat Technological University (2008–2012)'),
            ]),
            _sectionCard('Languages', [
              ...languages.map((lang) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(lang.name,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < lang.rating
                                    ? Icons.star
                                    : Icons.star_border_outlined,
                                color: Colors.amber,
                                size: 18,
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  )),
            ])
          ],
        ),
      ),
    );
  }

  final languages = [
    Language(name: 'English', rating: 4),
    Language(name: 'Hindi', rating: 4),
    Language(name: 'Gujarati', rating: 5),
  ];

  final workExperiences = [
    WorkExperience(
      title: 'Freelance Mobile App Developer',
      duration: '2019–Present',
      points: [
        'Full lifecycle development',
        'Team collaboration',
        'Architecture & testing'
      ],
    ),
    WorkExperience(
      title: 'EasyPay Pvt Ltd',
      duration: '2017–2019',
      points: [
        'Architecture and design',
        'Debugging and lifecycle management',
      ],
    ),
    WorkExperience(
      title: 'Value Chain Solutions',
      duration: '2015–2017',
      points: [
        'Project planning',
        'SOPs and lifecycle handling',
      ],
    ),
    WorkExperience(
      title: 'smartSense Solutions',
      duration: '2014–2015',
      points: [
        'Client requirements',
        'Development and documentation',
      ],
    ),
    WorkExperience(
      title: 'Agite Technologies',
      duration: '2013–2014',
      points: [
        'Bug fixing',
        'Feature implementation and testing',
      ],
    ),
  ];
}

class Language {
  final String name;
  final int rating; // out of 5

  Language({required this.name, required this.rating});
}
