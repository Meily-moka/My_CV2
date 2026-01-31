// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_print, use_build_context_synchronously, camel_case_types
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Me Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const aboutmePage(title: 'About Me Page'),
    );
  }
}

class aboutmePage extends StatefulWidget {
  const aboutmePage({super.key, required this.title});
  final String title;

  @override
  State<aboutmePage> createState() => _AboutmePageState();
}

class _AboutmePageState extends State<aboutmePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _infoKey = GlobalKey();
  final GlobalKey _eduKey = GlobalKey();
  final GlobalKey _skillKey = GlobalKey();
  final GlobalKey _expKey = GlobalKey();
  final GlobalKey _refKey = GlobalKey();

  String _activeSection = "My Information";

  void _scrollToSection(GlobalKey key, String sectionName) {
    setState(() {
      _activeSection = sectionName;
    });
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("About Me", style: TextStyle(color: Colors.black87)),
        actions: [
          IconButton(
            icon: Icon(Icons.code, color: Colors.black87), // Placeholder for GitHub icon
            onPressed: () => _launchURL("https://github.com/engsopheak"),
            tooltip: "GitHub",
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Content Area
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- My Information Section ---
                    Container(key: _infoKey),
                    Text(
                      "My Information",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    SizedBox(height: 20),
                    
                    // Profile Image Slot
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade300),
                        image: DecorationImage(
                          image: AssetImage('assets/me.jpg'), // REPLACE WITH YOUR IMAGE PATH
                          fit: BoxFit.contain,
                          onError: (exception, stackTrace) {
                            // Fallback if image is not found
                          },
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.account_box,
                          size: 150,
                          color: Colors.grey.shade400.withAlpha((0.5 * 255).round()),
                        ),
                      ),
                    ),
                    
                    // Information Table
                    Table(
                      border: TableBorder.all(color: Color(0xFF533315)),
                      columnWidths: const {
                        0: FixedColumnWidth(120),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        _buildTableRow("Name", "  HUN MEILY"),
                        _buildTableRow("Address", "Teuk l'ork 2, Khan Toul Kork, Phnom Penh, Cambodia"),
                        _buildTableRow("DoB", "18/May/2005"),
                        _buildTableRow("Phone", "+855-61-824-400"),
                        _buildTableRow("Email", "e20221254@dtc1.itc.edu.kh"),
                        _buildTableRowWithLink("LinkedIn", "https://www.linkedin.com/in/hun-meily-711a73378/?trk=PROFILE_DROP_DOWN", "https://www.linkedin.com/in/hun-meily-711a73378/?trk=PROFILE_DROP_DOWN"),
                        _buildTableRowWithLink("Telegram", "https://t.me/Hun_Meily", "https://t.me/Hun_Meily"),
                        _buildTableRow("Language", "Khmer\nEnglish\nFrench"),
                      ],
                    ),
                    
                    SizedBox(height: 60),

                    // --- My Education Section ---
                    Container(key: _eduKey),
                    Text(
                      "My Education",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    SizedBox(height: 20),

                    // Education Table
                    Table(
                      border: TableBorder.all(color: Color(0xFF533315)),
                      columnWidths: const {
                        0: FixedColumnWidth(120),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        _buildTableRowWithLink("University:", "https://www.facebook.com/share/1LAHoA8xWb/?mibextid=wwXIfr", "https://maps.app.goo.gl/YourUniversityMapLink"),
                        _buildTableRow("Department:", "Department of Telecommunication and Network Engineering"),
                        _buildTableRow("Major:", "Network Engineering"),
                        _buildTableRow("Year:", "01/October/2024 to Present"),
                        
                        _buildEmptyRow(),

                        _buildTableRowWithLink("University:", "https://www.itc.edu.kh", "https://maps.app.goo.gl/YourUniversityMapLink"),
                        _buildTableRow("Department:", "Department of Foundation Year"),
                        _buildTableRow("Year:", "16/Feb/2023 to 08/Aug/2024"),

                        _buildEmptyRow(),

                        _buildTableRowWithLink("High School:", "https://www.facebook.com/share/17q48w1Aod/?mibextid=wwXIfr ", ""),
                        _buildTableRow("Year:", "01/Nov/2017 to 05/Dec/2022"),
                      ],
                    ),
                    
                    SizedBox(height: 60),

                    // --- My Skill Section ---
                    Container(key: _skillKey),
                    Text(
                      "My Skill",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    SizedBox(height: 20),

                    // Skill Table
                    Table(
                      border: TableBorder.all(color: Color(0xFF533315)),
                      columnWidths: const {
                        0: FixedColumnWidth(60),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        _buildSkillRow(Icons.laptop, "Windows"),
                        _buildSkillRow(Icons.laptop, "Python, C, C++, OOP, MATLAB, Flutter and Type Script)."),
                        _buildSkillRow(Icons.bar_chart, "Data Analysis, Mathematics"),
                        _buildSkillRow(Icons.signal_cellular_4_bar, "Word, Excel, PowePoint, Overleaf Latex"),
                      ],
                    ),

                    SizedBox(height: 60),

                    // --- My Experience Section ---
                    Container(key: _expKey),
                    Text(
                      "My Experience",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    SizedBox(height: 20),

                    // Experience Table
                    Table(
                      border: TableBorder.all(color: Color(0xFF533315)),
                      columnWidths: const {
                        0: FixedColumnWidth(120),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        _buildTableRow("Company:", "Institute of Technology of Cambodia (ITC)"),
                        _buildTableRow("Position:", "Student Researcher"),
                        _buildTableRow("Year:", "2023 - Present"),
                        _buildTableRow("Description:", "Working on various projects related to network engineering and telecommunications."),
                      ],
                    ),

                    SizedBox(height: 60),

                    // --- My Reference Section ---
                    Container(key: _refKey),
                    Text(
                      "My Reference",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey.shade300),
                    SizedBox(height: 20),

                    // Reference Table
                    Table(
                      border: TableBorder.all(color: Color(0xFF533315)),
                      columnWidths: const {
                        0: FixedColumnWidth(120),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        _buildTableRow("Name", "Dr. SRENG Sokchenda"),
                        _buildTableRow("Position", "Head of Department of Telecommunication and Network Engineering"),
                        _buildTableRow("Phone", "+855-124-079-10"),
                        _buildTableRow("Email", "sokchenda@itc.edu.kh"),
                      ],
                    ),

                    SizedBox(height: 100), // Bottom padding
                  ],
                ),
              ),
              
              SizedBox(width: 40),
              
              // Sidebar Navigation
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "On This Page",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Spacer(),
                        Icon(Icons.print_outlined, size: 18, color: Colors.grey),
                      ],
                    ),
                    SizedBox(height: 15),
                    _buildSidebarItem("My Information", isActive: _activeSection == "My Information", onTap: () => _scrollToSection(_infoKey, "My Information")),
                    _buildSidebarItem("My Education", isActive: _activeSection == "My Education", onTap: () => _scrollToSection(_eduKey, "My Education")),
                    _buildSidebarItem("My Skill", isActive: _activeSection == "My Skill", onTap: () => _scrollToSection(_skillKey, "My Skill")),
                    _buildSidebarItem("My Experience", isActive: _activeSection == "My Experience", onTap: () => _scrollToSection(_expKey, "My Experience")),
                    _buildSidebarItem("My Reference", isActive: _activeSection == "My Reference", onTap: () => _scrollToSection(_refKey, "My Reference")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            value,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRowWithLink(String label, String text, String url) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () => _launchURL(url),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(color: Color.fromARGB(255, 216, 93, 134), decoration: TextDecoration.none),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.open_in_new, size: 14, color: Color.fromARGB(255, 216, 93, 134)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildSkillRow(IconData icon, String skill) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Icon(icon, size: 24, color: Colors.black87),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            skill,
            style: TextStyle(color: Colors.black87, fontSize: 15),
          ),
        ),
      ],
    );
  }

  TableRow _buildEmptyRow() {
    return TableRow(
      children: [
        Container(height: 10, color: Colors.grey.shade50),
        Container(height: 10, color: Colors.grey.shade50),
      ],
    );
  }

  Widget _buildSidebarItem(String title, {bool isActive = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isActive ? Color(0xFFF7ACAC) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Color(0xFFF7ACAC) : Colors.grey.shade600,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
