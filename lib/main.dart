import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyResumeApp());
}

class MyResumeApp extends StatelessWidget {
  const MyResumeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amit Vaghela Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xff00b4db),
        scaffoldBackgroundColor: const Color(0xff0f2027),
        fontFamily: 'Roboto',
        // Change CardTheme to CardThemeData here:
        cardTheme: CardTheme(
          color: Color(0xff203a43).withOpacity(0.7), // No 'const' before Color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
        ),
      ),
      home: const ResumePage(),
    );
  }
}

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  // Launch URL helper
  Future<void> launchUrlCustom(String urlStr) async {
    final Uri url = Uri.parse(urlStr);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff00b4db),
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: const Color(0xff00b4db),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget contactInfo(IconData icon, String label, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        // Defines the splash ripple boundary
        child: Padding(
          padding: const EdgeInsets.all(4.0), // Padding stays clean
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: const Color(0xff00b4db), size: 20),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: onTap != null
                        ? const Color(0xff00b4db)
                        : Colors.white70,
                    fontWeight:
                        onTap != null ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0, right: 8.0),
            child: CircleAvatar(
              radius: 3,
              backgroundColor: Color(0xff00b4db),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14, height: 1.4, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget workExperienceCard(WorkExperience exp) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    exp.position,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Text(
                  exp.period,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff00b4db),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            if (exp.company.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                exp.company,
                style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[400]),
              ),
            ],
            const Divider(height: 24, color: Colors.white10),
            ...exp.responsibilities.map(bulletPoint),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 850;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0f2027), Color(0xff203a43), Color(0xff2c5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16.0 : screenWidth * 0.08,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Profile Banner
                _buildHeader(isMobile),
                const SizedBox(height: 24),

                // Responsive Content Builder
                isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildMainContent() + _buildSideContent(),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _buildMainContent())),
                          const SizedBox(width: 32),
                          Expanded(
                              flex: 2,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _buildSideContent())),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Header Banner Component
  Widget _buildHeader(bool isMobile) {
    return Card(
      color: const Color(0xff1f4068).withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: isMobile ? 0 : 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Amit Vaghela',
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Senior Software Engineer (Mobile Systems)',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[300]),
                  ),
                ],
              ),
            ),
            if (isMobile)
              const Divider(height: 32, color: Colors.white10)
            else
              const SizedBox(width: 24),
            Expanded(
              flex: isMobile ? 0 : 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  contactInfo(Icons.email, PortfolioData.contactEmail,
                      onTap: () => launchUrlCustom(
                          'mailto:${PortfolioData.contactEmail}')),
                  contactInfo(Icons.phone, PortfolioData.contactPhone),
                  contactInfo(Icons.location_on, PortfolioData.contactLocation),
                  contactInfo(Icons.link, 'LinkedIn Profile',
                      onTap: () => launchUrlCustom(PortfolioData.linkedin)),
                  contactInfo(Icons.code, 'StackOverflow Profile',
                      onTap: () =>
                          launchUrlCustom(PortfolioData.stackoverflow)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Column 1 Components (Experience & Projects)
  List<Widget> _buildMainContent() {
    return [
      sectionTitle('Work Experience'),
      ...PortfolioData.workExperiences.map(workExperienceCard),
      const SizedBox(height: 16),
      sectionTitle('Recent Projects'),
      const SizedBox(height: 8),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350,
          childAspectRatio: 2.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: PortfolioData.projects.length,
        itemBuilder: (context, index) {
          final proj = PortfolioData.projects[index];
          return Card(
            margin: EdgeInsets.zero,
            color: const Color(0xff162447).withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      proj.name,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                  if (proj.link.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.open_in_new,
                          color: Color(0xff00b4db), size: 18),
                      onPressed: () => launchUrlCustom(proj.link),
                      tooltip: 'View Project',
                    )
                ],
              ),
            ),
          );
        },
      ),
    ];
  }

  // Column 2 Components (Skills, Certifications, Education)
  List<Widget> _buildSideContent() {
    return [
      sectionTitle('Core Competencies'),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PortfolioData.skills
              .map((skill) => Chip(
                    label: Text(skill),
                    backgroundColor: const Color(0xff00b4db).withOpacity(0.15),
                    side:
                        const BorderSide(color: Color(0xff00b4db), width: 0.5),
                    labelStyle:
                        const TextStyle(color: Colors.white, fontSize: 13),
                  ))
              .toList(),
        ),
      ),
      const SizedBox(height: 16),
      sectionTitle('Certifications'),
      ...PortfolioData.certifications.map((cert) => Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: Colors.white.withOpacity(0.03),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cert.title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(cert.period,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xff00b4db))),
                ],
              ),
            ),
          )),
      const SizedBox(height: 16),
      sectionTitle('Education'),
      ...PortfolioData.educationList.map((edu) => Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: Colors.white.withOpacity(0.03),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(edu.degree,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(edu.institution,
                      style: TextStyle(fontSize: 13, color: Colors.grey[300])),
                  Text(edu.period,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.white38)),
                ],
              ),
            ),
          )),
    ];
  }
}

// Separate Container for static structured resume portfolio data
class PortfolioData {
  static const contactEmail = 'vaghela.aamit@gmail.com';
  static const contactPhone = '9510039456';
  static const contactLocation = 'Ahmedabad, India';
  static const linkedin = 'https://linkedin.com/in/amit-vaghela-01011991';
  static const stackoverflow =
      'https://stackoverflow.com/users/2826147/amit-vaghela';

  static final List<WorkExperience> workExperiences = [
    WorkExperience(
      company: 'Freelance Designations',
      position: 'Freelance Mobile App Developer',
      period: '07/2019 - Present',
      responsibilities: [
        'Developing features from scratch to deployment on app ecosystems.',
        'Working across teams to conceptualize and build enterprise-grade assets.',
        'Writing clean, testable, scalable, and efficient code backed by thorough code reviews.',
        'Defining rigorous test strategies and agile release structures.',
        'Leading architecture definitions, workflow charting, and production maps.',
      ],
    ),
    WorkExperience(
      company: 'EasyPay Pvt Ltd',
      position: 'Sr Software Engineer',
      period: '10/2017 - 07/2019',
      responsibilities: [
        'Developed production architectural systems with clean logic layers.',
        'Identified, prioritized, and isolated cycle bottlenecks across SDLC operations.',
        'Provided continuous optimization, maintenance, and bug patch-sets.',
      ],
    ),
    WorkExperience(
      company: 'Value Chain Solutions India Pvt Ltd',
      position: 'Software Engineer',
      period: '05/2015 - 10/2017',
      responsibilities: [
        'Wrote modern, deterministic code architectures backed by rigorous testing guidelines.',
        'Executed end-to-end scope design patterns and operational frameworks.',
      ],
    ),
    WorkExperience(
      company: 'smartSense consulting solutions Pvt Ltd',
      position: 'Software Engineer',
      period: '01/2014 - 05/2015',
      responsibilities: [
        'Translated complex business specifications into crisp system mechanics.',
        'Authored procedural software lifecycle documentation and deployment guides.',
      ],
    ),
    WorkExperience(
      company: 'Agite Technologies',
      position: 'Jr Software Engineer',
      period: '01/2013 - 01/2014',
      responsibilities: [
        'Analyzed core run-time anomalies and developed permanent mitigation engines.',
      ],
    ),
  ];

  static final List<String> skills = [
    'Flutter',
    'Android',
    'Kotlin',
    'iOS',
    'Core Java',
    'Git',
    'Agile Methodologies',
    'Firebase Ecosystem',
    'RESTful Web Services',
  ];

  static final List<Project> projects = [
    Project(
        name: 'Remote App - Android/iOS',
        link:
            'https://play.google.com/store/apps/details?id=com.brodos.brodosnetapp&hl=en_IN'),
    Project(
        name: 'eCommerce App - Mobile/Web',
        link:
            'https://play.google.com/store/apps/details?id=com.brodos.microkiosk.de.german&hl=en_IN'),
    Project(
        name: 'TV Digital Signage App',
        link:
            'https://play.google.com/store/apps/details?id=com.brodos.digital.signage&hl=en_IN'),
    Project(
        name: 'MaxPlay Multimedia Ecosystem',
        link:
            'https://play.google.com/store/apps/details?id=com.maxplay.design'),
    Project(
        name: 'Paisa Nikal FinTech engine',
        link:
            'https://play.google.com/store/apps/details?id=aepsapp.paisanikal.com.aepsandroid&hl=en_US'),
    Project(name: 'Wow Customer Portfolio App', link: ''),
    Project(
        name: 'Ecubix Platform Suite',
        link:
            'https://play.google.com/store/apps/details?id=com.vcs.ecubixecp&hl=en_IN'),
  ];

  static final List<Certification> certifications = [
    Certification(
        title: 'CMC Certified EDGE Specialization Framework',
        period: '08/2012 - 12/2012')
  ];

  static final List<Education> educationList = [
    Education(
        degree: 'Bachelor of Technology (B.Tech)',
        institution: 'Gujarat Technological University, India',
        period: '2008 - 2012'),
    Education(
        degree: 'Higher Secondary School Certificate (HSC)',
        institution: 'Gujarat Higher Secondary Board',
        period: '2007 - 2008'),
    Education(
        degree: 'Secondary School Certificate (SSC)',
        institution: 'Gujarat Secondary Board',
        period: '2005 - 2006'),
  ];
}

// Data Models
class WorkExperience {
  final String company;
  final String position;
  final String period;
  final List<String> responsibilities;

  WorkExperience(
      {required this.company,
      required this.position,
      required this.period,
      required this.responsibilities});
}

class Project {
  final String name;
  final String link;

  Project({required this.name, required this.link});
}

class Certification {
  final String title;
  final String period;

  Certification({required this.title, required this.period});
}

class Education {
  final String degree;
  final String institution;
  final String period;

  Education(
      {required this.degree, required this.institution, required this.period});
}
