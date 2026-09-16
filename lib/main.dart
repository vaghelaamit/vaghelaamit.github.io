import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const AmitPortfolioApp());
}

class AmitPortfolioApp extends StatelessWidget {
  const AmitPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amit Vaghela | Lead Mobile Architect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090D16),
        primaryColor: const Color(0xFF00D2FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00D2FF),
          secondary: Color(0xFF3A7BD5),
          surface: Color(0xFF111827),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF111928),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0x1FFFFFFF), width: 1),
          ),
        ),
      ),
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatelessWidget {
  const PortfolioHomePage({super.key});

  static Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Navigation Bar
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : screenWidth * 0.08,
                vertical: 18,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF0B1120),
                border: Border(bottom: BorderSide(color: Color(0x1FFFFFFF))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00D2FF).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF00D2FF), width: 1),
                        ),
                        child: const Text(
                          'AV',
                          style: TextStyle(
                            color: Color(0xFF00D2FF),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Amit Vaghela',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildSocialIconButton(
                        icon: Icons.code,
                        tooltip: 'Stack Overflow',
                        onTap: () => _openUrl(PortfolioData.stackoverflow),
                      ),
                      const SizedBox(width: 8),
                      _buildSocialIconButton(
                        icon: Icons.link,
                        tooltip: 'LinkedIn',
                        onTap: () => _openUrl(PortfolioData.linkedin),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D2FF),
                          foregroundColor: const Color(0xFF090D16),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.mail_outline, size: 18),
                        label: const Text(
                          'Hire Me',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _openUrl('mailto:${PortfolioData.contactEmail}'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Main Content Area
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : screenWidth * 0.08,
                vertical: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Header Banner
                  _buildHeroSection(isMobile),
                  const SizedBox(height: 28),

                  // Metrics Ribbon
                  _buildMetricsRibbon(isMobile),
                  const SizedBox(height: 40),

                  // Responsive Split: Main Column (Projects + Experience) vs Side Column (Skills + Certs)
                  isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ..._buildProjectsSection(isMobile),
                      const SizedBox(height: 36),
                      ..._buildExperienceSection(),
                      const SizedBox(height: 36),
                      ..._buildSideContent(),
                    ],
                  )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._buildProjectsSection(isMobile),
                            const SizedBox(height: 44),
                            ..._buildExperienceSection(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 36),
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildSideContent(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              margin: const EdgeInsets.top(40),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0x14FFFFFF))),
                color: Color(0xFF0B1120),
              ),
              child: Center(
                child: Text(
                  '© ${DateTime.now().year} Amit Vaghela • Built with Flutter Web',
                  style: const TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSocialIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      splashRadius: 20,
      icon: Icon(icon, color: Colors.white70, size: 20),
      style: IconButton.styleFrom(
        backgroundColor: const Color(0xFF1F2937),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0x1FFFFFFF)),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 22 : 36),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF131D31), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: const Color(0x2E00D2FF), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.15),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF10B981), width: 0.8),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 4, backgroundColor: Color(0xFF10B981)),
                SizedBox(width: 8),
                Text(
                  'Open to 100% Remote & Global Contracts',
                  style: TextStyle(color: Color(0xFF10B981), fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Lead Mobile Architect & Staff Engineer',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Flutter • Native Android (Kotlin/Java) • Native iOS (Swift)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF00D2FF),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            PortfolioData.summary,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 10,
            children: [
              _buildContactChip(Icons.location_on_outlined, PortfolioData.contactLocation),
              _buildContactChip(Icons.phone_outlined, PortfolioData.contactPhone),
              _buildContactChip(Icons.email_outlined, PortfolioData.contactEmail,
                  onTap: () => _openUrl('mailto:${PortfolioData.contactEmail}')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactChip(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF00D2FF)),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: onTap != null ? const Color(0xFF00D2FF) : Colors.white70,
                decoration: onTap != null ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsRibbon(bool isMobile) {
    final metrics = [
      {'val': '13+', 'label': 'Years Experience'},
      {'val': '10+', 'label': 'Production Apps'},
      {'val': '99.9%', 'label': 'Crash-Free Stability'},
      {'val': '4', 'label': 'Platforms (Flutter/iOS/Android/Web)'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF111928),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x1FFFFFFF)),
      ),
      child: isMobile
          ? Wrap(
        spacing: 24,
        runSpacing: 16,
        alignment: WrapAlignment.spaceAround,
        children: metrics.map(_buildMetricItem).toList(),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: metrics.map(_buildMetricItem).toList(),
      ),
    );
  }

  Widget _buildMetricItem(Map<String, String> m) {
    return Column(
      children: [
        Text(
          m['val']!,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Color(0xFF00D2FF),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          m['label']!,
          style: const TextStyle(fontSize: 12, color: Colors.white60, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  List<Widget> _buildProjectsSection(bool isMobile) {
    return [
      _buildSectionHeader('Featured Engineering Projects', Icons.layers_outlined),
      const SizedBox(height: 16),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: isMobile ? 450 : 360,
          childAspectRatio: 1.25,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: PortfolioData.projects.length,
        itemBuilder: (context, index) {
          final p = PortfolioData.projects[index];
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF111928),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0x1AFFFFFF)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00D2FF).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        p.category,
                        style: const TextStyle(
                          color: Color(0xFF00D2FF),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (p.link.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.open_in_new, size: 16, color: Colors.white70),
                        onPressed: () => _openUrl(p.link),
                        tooltip: 'View Live / Play Store',
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  p.name,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: Text(
                    p.description,
                    style: const TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF94A3B8)),
                    overflow: TextOverflow.fade,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: p.tags.map((tag) => Text('#$tag', style: const TextStyle(fontSize: 11, color: Colors.white38))).toList(),
                ),
              ],
            ),
          );
        },
      ),
    ];
  }

  List<Widget> _buildExperienceSection() {
    return [
      _buildSectionHeader('Professional Experience', Icons.work_outline),
      const SizedBox(height: 16),
      ...PortfolioData.workExperiences.map((exp) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: const Color(0xFF111928),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0x1FFFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exp.position,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          exp.company,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF00D2FF), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      exp.period,
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Divider(height: 1, color: Color(0x14FFFFFF)),
              ),
              ...exp.responsibilities.map((resp) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6, right: 10),
                      child: CircleAvatar(radius: 2.5, backgroundColor: Color(0xFF00D2FF)),
                    ),
                    Expanded(
                      child: Text(
                        resp,
                        style: const TextStyle(fontSize: 13.5, height: 1.45, color: Color(0xFFCBD5E1)),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        );
      }),
    ];
  }

  List<Widget> _buildSideContent() {
    return [
      _buildSectionHeader('Technical Competencies', Icons.memory),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF111928),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0x1FFFFFFF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: PortfolioData.competencyCategories.entries.map((category) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.key,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF00D2FF)),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: category.value.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0x1FFFFFFF)),
                        ),
                        child: Text(skill, style: const TextStyle(fontSize: 12, color: Colors.white)),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      const SizedBox(height: 28),
      _buildSectionHeader('Education & Credentials', Icons.school_outlined),
      const SizedBox(height: 16),
      ...PortfolioData.educationList.map((edu) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF111928),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0x14FFFFFF)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(edu.degree, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 3),
              Text(edu.institution, style: const TextStyle(fontSize: 12.5, color: Colors.white70)),
              const SizedBox(height: 2),
              Text(edu.period, style: const TextStyle(fontSize: 11.5, color: Color(0xFF00D2FF))),
            ],
          ),
        );
      }),
    ];
  }

  static Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF00D2FF)),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.2),
        ),
      ],
    );
  }
}

// Structured Data Container (Incorporating All Resumes & Projects)
class PortfolioData {
  static const contactEmail = 'vaghela.aamit@gmail.com';
  static const contactPhone = '+91 9510039456';
  static const contactLocation = 'Ahmedabad, India';
  static const linkedin = 'https://linkedin.com/in/amit-vaghela-01011991';
  static const stackoverflow = 'https://stackoverflow.com/users/2826147/amit-vaghela';

  static const summary =
      'Hands-on Lead Mobile Architect with 13+ years of experience building high-scale cross-platform and native mobile systems across FinTech, E-Commerce POS, and Media streaming. Expert in governing clean multi-platform architecture (Flutter, Native Android/Kotlin/Java, and iOS), bridging hybrid runtime engines (Unity/Flutter), and maintaining 99.9% crash-free stability across enterprise production apps.';

  static final Map<String, List<String>> competencyCategories = {
    'Cross-Platform & Frameworks': ['Flutter', 'Dart', 'Android SDK', 'Kotlin', 'Core Java', 'iOS (Swift)', 'Unity Integration'],
    'Architecture & Patterns': ['Clean Architecture', 'BLoC', 'Provider', 'Riverpod', 'MVVM', 'Native Platform Channels', 'Micro-Frontends'],
    'Backend, APIs & Databases': ['RESTful APIs', 'Firebase Suite', 'SQLite', 'Room DB', 'Cloud Firestore', 'Cloud Messaging', 'JSON/XML'],
    'Performance & DevOps': ['CI/CD (Fastlane)', 'GitHub Actions', 'Memory Leak Profiling', 'JNI / NDK', 'Google Play Console', 'App Store Connect'],
  };

  static final List<ProjectItem> projects = [
    ProjectItem(
      name: 'Fast App',
      category: 'Hybrid / Utility',
      description: 'Pioneered low-latency cross-platform integration bridging Flutter UI with the Unity 3D engine via bidirectional native platform channels on iOS & Android.',
      link: '',
      tags: ['Flutter', 'Unity 3D', 'Platform Channels', 'iOS/Android'],
    ),
    ProjectItem(
      name: 'Paisa Nikal',
      category: 'FinTech / Banking',
      description: 'High-security micro-banking app featuring AEPS, Aadhaar Pay, biometric hardware SDKs, and mPOS integration with end-to-end payload encryption.',
      link: 'https://play.google.com/store/apps/details?id=aepsapp.paisanikal.com.aepsandroid&hl=en_US',
      tags: ['FinTech', 'Biometrics', 'Micro-ATM', 'Security'],
    ),
    ProjectItem(
      name: 'Kiosk E-Commerce App',
      category: 'Retail POS',
      description: 'Enterprise-grade retail POS and commercial kiosk app supporting offline-first transactions and seamless hardware peripheral sync.',
      link: 'https://play.google.com/store/apps/details?id=com.brodos.microkiosk.de.german&hl=en_IN',
      tags: ['Flutter', 'Offline-First', 'POS Hardware', 'Retail'],
    ),
    ProjectItem(
      name: 'Campaigner App',
      category: 'Marketing Tech',
      description: 'Cross-platform digital ad campaign manager integrating Meta and LinkedIn social APIs for real-time campaign performance tracking.',
      link: '',
      tags: ['Flutter', 'Social APIs', 'Analytics', 'State Mgmt'],
    ),
    ProjectItem(
      name: 'Remote App',
      category: 'IoT / Telemetry',
      description: 'Real-time telemetry, remote device control, and connected-app analytics across iOS and Android ecosystems.',
      link: 'https://play.google.com/store/apps/details?id=com.brodos.brodosnetapp&hl=en_IN',
      tags: ['IoT', 'Telemetry', 'Android/iOS', 'Analytics'],
    ),
    ProjectItem(
      name: 'Stock Booking & Warehouse',
      category: 'Supply Chain',
      description: 'Flutter-powered enterprise inventory app designed to book stocks, validate allocations, and automate warehouse management.',
      link: '',
      tags: ['Flutter', 'Warehouse Mgmt', 'Validation', 'Offline Sync'],
    ),
    ProjectItem(
      name: 'Digisign TV App',
      category: 'Digital Signage',
      description: '24/7 hardware-accelerated media playlist engine designed for uninterrupted commercial kiosk and digital display rendering.',
      link: 'https://play.google.com/store/apps/details?id=com.brodos.digital.signage&hl=en_IN',
      tags: ['Media Engine', 'Digital Signage', 'Kiosk OS', 'Streaming'],
    ),
    ProjectItem(
      name: 'Max Play App',
      category: 'Multimedia',
      description: 'High-performance audio/video streaming client application built with optimized media caching and smooth UI rendering.',
      link: 'https://play.google.com/store/apps/details?id=com.maxplay.design',
      tags: ['Media Streaming', 'Video Caching', 'UI Optimization'],
    ),
    ProjectItem(
      name: 'epinSeller Portal',
      category: 'FinTech / Web',
      description: 'Cross-platform digital voucher and e-pin distribution portal deployed synchronously on Flutter Web and Android.',
      link: '',
      tags: ['Flutter Web', 'Android', 'Vouchers', 'Transactions'],
    ),
    ProjectItem(
      name: 'Ecubix Platform Suite',
      category: 'B2B Logistics',
      description: 'Enterprise supply-chain management app with background Android services and offline-to-online SQLite synchronization.',
      link: 'https://play.google.com/store/apps/details?id=com.vcs.ecubixecp&hl=en_IN',
      tags: ['Logistics', 'Background Services', 'SQLite', 'Tracking'],
    ),
  ];

  static final List<WorkExperienceItem> workExperiences = [
    WorkExperienceItem(
      company: 'Brodos India Pvt Ltd',
      position: 'Lead Engineer',
      period: '07/2019 – Present',
      responsibilities: [
        'Direct the end-to-end architecture, development, and release lifecycle for enterprise retail and omnichannel mobile products.',
        'Architected Fast App, engineering low-latency native platform channels to bridge the Unity 3D engine with Flutter on iOS & Android.',
        'Spearheaded Kiosk App, enabling offline-first transaction processing and POS hardware peripheral sync.',
        'Designed Campaigner App (Meta/LinkedIn ad manager) and Remote App (real-time telemetry and device control).',
        'Established automated CI/CD pipelines (Fastlane) and code reviews, cutting deployment turnaround by 35% and maintaining 99.9% crash-free stability.',
        'Mentor a squad of mobile developers, translating complex product roadmaps into scalable technical specifications.',
      ],
    ),
    WorkExperienceItem(
      company: 'EasyPay Pvt Ltd',
      position: 'Senior Software Engineer',
      period: '10/2017 – 07/2019',
      responsibilities: [
        'Spearheaded core mobile engineering for Paisa Nikal, a high-volume micro-ATM/AEPS FinTech banking application.',
        'Integrated biometric authentication SDKs, thermal printer APIs, and payment gateways with payload encryption.',
        'Engineered epinSeller, deployed on both Flutter Web and Android.',
        'Optimized SQLite caching and network calls, decreasing mobile data consumption by 25% for low-bandwidth users.',
      ],
    ),
    WorkExperienceItem(
      company: 'Value Chain Solutions India Pvt Ltd',
      position: 'Software Engineer',
      period: '05/2015 – 10/2017',
      responsibilities: [
        'Engineered enterprise supply-chain management and B2B logistics Android applications with real-time field tracking.',
        'Designed reliable offline-to-online data synchronization protocols using local SQLite storage and background services.',
        'Refactored legacy Java codebases into modular, testable components, cutting production defects by 40%.',
      ],
    ),
    WorkExperienceItem(
      company: 'smartSense Consulting Solutions Pvt Ltd',
      position: 'Software Engineer',
      period: '01/2014 – 05/2015',
      responsibilities: [
        'Developed custom video streaming and digital signage solutions, including Digisign TV and Max Play.',
        'Built hardware-accelerated media playback pipelines handling uninterrupted 24/7 video rendering and automated caching.',
      ],
    ),
    WorkExperienceItem(
      company: 'Agite Technologies',
      position: 'Junior Software Engineer',
      period: '01/2013 – 01/2014',
      responsibilities: [
        'Developed core features and fixed client-side defects for native Android utilities in Core Java.',
        'Collaborated on UI adaptation across varied screen densities and executed rigorous API contract testing.',
      ],
    ),
  ];

  static final List<EducationItem> educationList = [
    EducationItem(
      degree: 'Bachelor of Technology (B.Tech)',
      institution: 'Gujarat Technological University (GTU)',
      period: '06/2008 – 08/2012',
    ),
    EducationItem(
      degree: 'CMC Certified EDGE Specialization Framework',
      institution: 'CMC Limited',
      period: '08/2012 – 12/2012',
    ),
  ];
}

// Clean Models
class ProjectItem {
  final String name;
  final String category;
  final String description;
  final String link;
  final List<String> tags;

  ProjectItem({
    required this.name,
    required this.category,
    required this.description,
    required this.link,
    required this.tags,
  });
}

class WorkExperienceItem {
  final String company;
  final String position;
  final String period;
  final List<String> responsibilities;

  WorkExperienceItem({
    required this.company,
    required this.position,
    required this.period,
    required this.responsibilities,
  });
}

class EducationItem {
  final String degree;
  final String institution;
  final String period;

  EducationItem({
    required this.degree,
    required this.institution,
    required this.period,
  });
}