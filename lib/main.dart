import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amit Vaghela',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          headlineMedium: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          headlineLarge: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
          bodyMedium:
              TextStyle(fontSize: 14, color: Colors.white70, height: 1.5),
        ),
      ),
      home: PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  final Uri _linkedin =
      Uri.parse('https://linkedin.com/in/amit-vaghela-01011991');
  final Uri _stackoverflow =
      Uri.parse('https://stackoverflow.com/users/2826147/amit-vaghela');
  final Uri _email = Uri.parse('mailto:vaghela.aamit@gmail.com');

  void _launch(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Widget section(BuildContext context, String title, List<Widget> content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          SizedBox(height: 10),
          ...content,
        ],
      ),
    );
  }

  Widget linkCard(String name, String url) => Card(
        color: Colors.grey[850],
        margin: EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          title: Text(name, style: TextStyle(color: Colors.blueAccent)),
          trailing: Icon(Icons.open_in_new, color: Colors.blueAccent),
          onTap: () => _launch(Uri.parse(url)),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Amit Vaghela'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 12),
                  Text('Lead Software Engineer',
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
            ),
            section(context, 'About Me', [
              Text(
                  '11+ years of experience in mobile app development (Android, iOS, Flutter). Skilled in building scalable, testable, and high-performance applications.',
                  style: Theme.of(context).textTheme.bodyMedium),
            ]),
            section(context, 'Work Experience', [
              _experienceItem(
                context,
                title: 'Freelance Mobile App Developer',
                company: 'Self-employed',
                duration: '2019 – Present',
                bullets: [
                  'Full lifecycle app development',
                  'Team collaboration and code reviews',
                  'Architecting scalable and testable solutions',
                ],
              ),
              _experienceItem(
                context,
                title: 'Senior Android Developer',
                company: 'EasyPay Pvt Ltd',
                duration: '2017 – 2019',
                bullets: [
                  'Designed scalable mobile architecture',
                  'Managed release cycles and debugging',
                ],
              ),
              _experienceItem(
                context,
                title: 'Android Developer',
                company: 'Value Chain Solutions',
                duration: '2015 – 2017',
                bullets: [
                  'Handled project planning and implementation',
                  'Defined SOPs and lifecycle strategies',
                ],
              ),
              _experienceItem(
                context,
                title: 'Junior Developer',
                company: 'smartSense Solutions',
                duration: '2014 – 2015',
                bullets: [
                  'Worked with clients on app requirements',
                  'Development, testing, and documentation',
                ],
              ),
              _experienceItem(
                context,
                title: 'Android Developer Intern',
                company: 'Agite Technologies',
                duration: '2013 – 2014',
                bullets: [
                  'Fixed bugs and added features',
                  'Tested and deployed Android apps',
                ],
              ),
            ]),
            section(context, 'Skills', [
              Text('Flutter, Android, Kotlin, iOS, Java, Git, Firebase, Agile',
                  style: Theme.of(context).textTheme.bodyMedium),
            ]),
            section(context, 'Projects', [
              linkCard('MaxPlay',
                  'https://play.google.com/store/apps/details?id=com.maxplay.design'),
              linkCard('Paisa Nikal',
                  'https://play.google.com/store/apps/details?id=aepsapp.paisanikal.com.aepsandroid'),
              Text('Other Projects: Fast App, MyStore TV, Wow App',
                  style: Theme.of(context).textTheme.bodyMedium),
            ]),
            section(context, 'Education', [
              Text('B.Tech – Gujarat Technological University (2008–2012)',
                  style: Theme.of(context).textTheme.bodyMedium),
            ]),
            section(context, 'Languages', [
              Text('English (Professional), Hindi (Native)',
                  style: Theme.of(context).textTheme.bodyMedium),
            ]),
            section(context, 'Contact', [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.link, color: Colors.blueAccent),
                      onPressed: () => _launch(_linkedin)),
                  IconButton(
                      icon: Icon(Icons.code, color: Colors.blueAccent),
                      onPressed: () => _launch(_stackoverflow)),
                  IconButton(
                      icon: Icon(Icons.email, color: Colors.blueAccent),
                      onPressed: () => _launch(_email)),
                ],
              ),
              Center(
                child: Text('Phone: +91‑95100‑39456',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _experienceItem(BuildContext context,
      {required String title,
      required String company,
      required String duration,
      required List<String> bullets}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$title — $company',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text(duration,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey)),
          SizedBox(height: 6),
          ...bullets.map((b) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Expanded(
                      child: Text(b,
                          style: Theme.of(context).textTheme.bodyMedium)),
                ],
              )),
        ],
      ),
    );
  }
}
