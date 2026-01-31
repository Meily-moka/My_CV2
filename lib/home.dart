// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_print, use_build_context_synchronously, camel_case_types
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _nameController;
  late Animation<double> _nameFadeAnimation;
  late Animation<Offset> _nameSlideAnimation;

  late AnimationController _professionController;
  late Animation<double> _professionFadeAnimation;
  late Animation<Offset> _professionSlideAnimation;

  @override
  void initState() {
    super.initState();
    _nameController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _nameFadeAnimation = CurvedAnimation(parent: _nameController, curve: Curves.easeIn);
    _nameSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(CurvedAnimation(parent: _nameController, curve: Curves.easeOut));

    _professionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _professionFadeAnimation = CurvedAnimation(parent: _professionController, curve: Curves.easeIn);
    _professionSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(CurvedAnimation(parent: _professionController, curve: Curves.easeOut));

    _nameController.forward();
    Future.delayed(const Duration(milliseconds: 500), () { if (mounted) _professionController.forward(); });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _professionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Boba Tea Palette: #F2D3A0 (Tan), #F6E1BB (Cream), #533315 (Brown), #FFCCCC (Light Pink), #F7ACAC (Pink)
    return Scaffold(
      backgroundColor: Color(0xFFF6E1BB), // Creamy Tan background
      body: Stack(
        children: [
          // White Curved Background on the left
          Positioned(
            left: 0, top: 0, bottom: 0,
            width: MediaQuery.of(context).size.width * 0.45,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(300, 600),
                  bottomRight: Radius.elliptical(300, 600),
                ),
              ),
            ),
          ),
          
          Row(
            children: [
              // Left Side: Large Profile Picture
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.only(left: 50),
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/me.jpg',
                    height: MediaQuery.of(context).size.height * 0.8,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.account_circle, size: 400, color: Color(0xFFF2D3A0)),
                  ),
                ),
              ),
              
              // Right Side: Introduction Text
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("This is", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Color(0xFF533315))),
                      SizedBox(height: 10),
                      FadeTransition(
                        opacity: _nameFadeAnimation,
                        child: SlideTransition(
                          position: _nameSlideAnimation,
                          child: Text(
                            "Meily",
                            style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: Color(0xFF533315)),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      FadeTransition(
                        opacity: _professionFadeAnimation,
                        child: SlideTransition(
                          position: _professionSlideAnimation,
                          child: Text(
                            "Telecommunication and Network Student.",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, color: Color.fromARGB(255, 224, 35, 104)), // Pink for profession
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
