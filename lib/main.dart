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
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.white70,
            height: 1.6,
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center),
          SizedBox(height: 12),
          ...content,
        ],
      ),
    );
  }

  Widget linkCard(String name, String url) => Card(
        color: Colors.grey[850],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          title: Text(name, style: TextStyle(color: Colors.blueAccent)),
          trailing: Icon(Icons.open_in_new, color: Colors.blueAccent),
          onTap: () => _launch(Uri.parse(url)),
        ),
      );

  Widget _contactInfo(IconData icon, String text) {
    return Chip(
      backgroundColor: Colors.grey.shade900,
      avatar: Icon(icon, size: 18, color: Colors.blueAccent),
      label: Text(text, style: TextStyle(color: Colors.white)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    );
  }

  Widget _linkButton(
      {required IconData icon, required String label, required String url}) {
    return InkWell(
      onTap: () => _launch(Uri.parse(url)),
      child: Chip(
        backgroundColor: Colors.grey.shade800,
        avatar: Icon(icon, size: 18, color: Colors.lightBlueAccent),
        label: Text(label, style: TextStyle(color: Colors.white)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Amit Vaghela'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Lead Software Engineer',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        _contactInfo(Icons.email, 'vaghela.aamit@gmail.com'),
                        _contactInfo(Icons.phone, '+91 95100 39456'),
                        _linkButton(
                            icon: Icons.link,
                            label: 'LinkedIn',
                            url: _linkedin.toString()),
                        _linkButton(
                            icon: Icons.code,
                            label: 'StackOverflow',
                            url: _stackoverflow.toString()),
                      ],
                    ),
                    InkWell(
                      onTap: () => _launch(
                          Uri.parse('https://example.com/amit_resume.pdf')),
                      child: Chip(
                        backgroundColor: Colors.grey.shade800,
                        avatar: Icon(Icons.download,
                            size: 18, color: Colors.lightBlueAccent),
                        label: Text('Download Resume',
                            style: TextStyle(color: Colors.white)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
                section(context, 'About Me', [
                  Text(
                    '12+ years of experience in mobile app development (Flutter, Android, iOS). Skilled in building scalable, testable, and high-performance applications.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ]),
                AnimatedSection(
                  child: section(context, 'Work Experience', [
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
                ),
                AnimatedSection(
                  child: section(context, 'Skills', [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _skillChip('Flutter'),
                        _skillChip('Android'),
                        _skillChip('iOS'),
                        _skillChip('Kotlin'),
                        _skillChip('Java'),
                        _skillChip('Git'),
                        _skillChip('Firebase'),
                        _skillChip('REST APIs'),
                        _skillChip('Agile'),
                      ],
                    ),
                  ]),
                ),
                section(context, 'Projects', [
                  linkCard('MaxPlay', 'https://play.google.com/...'),
                  linkCard('Paisa Nikal', 'https://play.google.com/...'),
                  Text('Fast App',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text('TV App', style: Theme.of(context).textTheme.bodyMedium),
                  Text('Wow App',
                      style: Theme.of(context).textTheme.bodyMedium),
                ]),
                section(context, 'Education', [
                  Text('B.Tech – Gujarat Technological University (2008–2012)',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center),
                  Text('Higher Secondary School Certificate (2007-2008)',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center),
                  Text('Secondary School Certificate (2005–2006)',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center),
                ]),
                section(context, 'Languages', [
                  _languageRating('English', 4),
                  _languageRating('Hindi', 4),
                  _languageRating('Gujarati', 5),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _skillChip(String label) {
  return Chip(
    label: Text(label, style: TextStyle(color: Colors.white)),
    backgroundColor: Colors.blueGrey.shade800,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  );
}

Widget _experienceItem(BuildContext context,
    {required String title,
    required String company,
    required String duration,
    required List<String> bullets}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              Text(company,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey)),
              Text(duration,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: bullets
                .map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("• ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Expanded(
                              child: Text(b,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium)),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  );
}

class AnimatedSection extends StatefulWidget {
  final Widget child;

  const AnimatedSection({required this.child});

  @override
  _AnimatedSectionState createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}

Widget _languageRating(String language, int rating) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          language,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 12),
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 20,
            );
          }),
        ),
      ],
    ),
  );
}
