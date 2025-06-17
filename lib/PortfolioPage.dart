import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioPage extends StatelessWidget {
  final Uri _linkedin =
      Uri.parse('https://linkedin.com/in/amit-vaghela-01011991');
  final Uri _stackoverflow =
      Uri.parse('https://stackoverflow.com/users/2826147/amit-vaghela');
  final Uri _email = Uri.parse('mailto:vaghela.aamit@gmail.com');

  void _launch(Uri url) async {
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Widget section(String title, List<Widget> content, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        SizedBox(height: 8),
        ...content,
        SizedBox(height: 16),
      ],
    );
  }

  Widget linkCard(String name, String url) => Card(
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
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
          SizedBox(height: 12),
          Center(
            child: Text(
              'Lead Software Engineer',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(height: 24),
          section(
              'About Me',
              [
                Text('• 11+ years in mobile (Flutter, Android, iOS).'),
                Text('• Architected scalable, testable & performant apps.'),
              ],
              context),
          section(
              'Work Experience',
              [
                Text(
                    '• Freelance (2019–Present): App lifecycle, team leadership.'),
                Text('• EasyPay (2017–2019): Architecture, debugging.'),
                Text('• VCS (2015–2017): Project planning, SOP.'),
                Text('• smartSense (2014–2015): Client requirements, docs.'),
                Text('• Agite (2013–2014): Bugfixes & features.'),
              ],
              context),
          section(
              'Skills',
              [
                Text(
                    'Flutter • Android • Kotlin • iOS • Java • Git • Firebase • Agile'),
              ],
              context),
          section(
              'Projects',
              [
                linkCard('MaxPlay',
                    'https://play.google.com/store/apps/details?id=com.maxplay.design'),
                linkCard('Paisa Nikal',
                    'https://play.google.com/store/apps/details?id=aepsapp.paisanikal.com.aepsandroid'),
                Text('• Other: Fast App, MyStore TV, Wow App'),
              ],
              context),
          section(
              'Education',
              [
                Text('B.Tech – Gujarat Technological University (2008–2012)'),
              ],
              context),
          section(
              'Languages',
              [
                Text('English (Professional), Hindi (Native)'),
              ],
              context),
          section(
              'Contact',
              [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconButton(
                    icon: Icon(Icons.linked_camera),
                    onPressed: () => _launch(_linkedin),
                  ),
                  IconButton(
                    icon: Icon(Icons.code),
                    onPressed: () => _launch(_stackoverflow),
                  ),
                  IconButton(
                    icon: Icon(Icons.email),
                    onPressed: () => _launch(_email),
                  ),
                ]),
                Center(child: Text('Phone: +91‑95100‑39456')),
              ],
              context),
        ],
      ),
    );
  }
}
