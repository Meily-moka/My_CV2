// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_print, use_build_context_synchronously, camel_case_types
import 'package:flutter/material.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  // Boba Tea Palette: #F2D3A0 (Tan), #F6E1BB (Cream), #533315 (Brown), #FFCCCC (Light Pink), #F7ACAC (Pink)
  final Color brown = Color(0xFF533315);
  final Color pink = Color(0xFFF7ACAC);
  final Color cream = Color.fromARGB(255, 238, 237, 236);
  final Color tan = Color(0xFFF2D3A0);

  final List<Map<String, String>> certificates = [
    {"name": "Spring Education Graduation", "path": "assets/graduate.jpg"},
    {"name": "STEM Volunteer", "path": "assets/volunteer.jpg"},
    {"name": "Network Internship", "path": "assets/intern.jpg"},
  ];

  void _openCertificate(String name, String path) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: brown), overflow: TextOverflow.ellipsis)),
                    IconButton(icon: Icon(Icons.close, color: brown), onPressed: () => Navigator.pop(context)),
                  ],
                ),
              ),
              Divider(height: 1, color: tan),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      path, fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image_not_supported, size: 80, color: tan), SizedBox(height: 10), Text("Image not found", style: TextStyle(color: brown))])),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("MY CERTIFICATES", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: brown, letterSpacing: 1.2)),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: brown.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 4))]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Table(
                  columnWidths: const {0: FlexColumnWidth(3), 1: FlexColumnWidth(1)},
                  children: [
                    TableRow(decoration: BoxDecoration(color: tan), children: [_buildHeaderCell("Achievement Name"), _buildHeaderCell("Action", alignCenter: true)]),
                    ...certificates.map((cert) => TableRow(children: [_buildDataCell(cert['name']!), _buildActionCell(cert['name']!, cert['path']!)])).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {bool alignCenter = false}) {
    return Padding(padding: const EdgeInsets.all(16.0), child: Text(text, textAlign: alignCenter ? TextAlign.center : TextAlign.start, style: TextStyle(color: brown, fontWeight: FontWeight.bold, fontSize: 18)));
  }

  Widget _buildDataCell(String text) {
    return Container(padding: const EdgeInsets.all(20.0), decoration: BoxDecoration(border: Border(bottom: BorderSide(color: tan.withOpacity(0.3)))), child: Text(text, style: TextStyle(fontSize: 16, color: brown)));
  }

  Widget _buildActionCell(String name, String path) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: tan.withOpacity(0.3)), left: BorderSide(color: tan.withOpacity(0.3)))),
      child: InkWell(
        onTap: () => _openCertificate(name, path),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image, color: pink, size: 24), SizedBox(width: 8), Text("Open", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, decoration: TextDecoration.underline, fontSize: 16))]),
      ),
    );
  }
}
