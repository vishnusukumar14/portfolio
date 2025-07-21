import 'package:flutter/material.dart';

class HeroSectionWidget extends StatelessWidget {
  final VoidCallback onGetInTouchPressed;
  final VoidCallback onBrowseProjectPressed;

  const HeroSectionWidget({
    super.key,
    required this.onGetInTouchPressed,
    required this.onBrowseProjectPressed,
  });

  @override
  Widget build(BuildContext context) {
    // For desktop/tablet: wider screen
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      // padding: EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT: Text Content
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hey, I'm Vishnu 👋",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    // "Frontend Developer" with split styling
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Software",
                            style: TextStyle(
                              fontFamily: 'Bitcount Prop Single',
                              color: Colors.black,
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -2,
                            ),
                          ),
                          TextSpan(
                            text: "\nDev",
                            style: TextStyle(
                              fontFamily: 'Bitcount Prop Single',
                              color: Color(0xFFA70F0F),
                              // purple accent
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -2,
                            ),
                          ),
                          TextSpan(
                            text: "eloper",
                            style: TextStyle(
                              fontFamily: 'Bitcount Prop Single',
                              color: Colors.black,
                              fontSize: 64,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "I love building apps that are fast, clean, and a joy to use—whether in Flutter or native Android—with a strong focus on smooth user experience and scalable architecture",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        height: 1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 32),
                    // Buttons Row
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: onGetInTouchPressed,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 28,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Get In Touch',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        OutlinedButton(
                          onPressed: onBrowseProjectPressed,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black12, width: 2),
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Browse Projects',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // RIGHT: Profile Photo with Circular Border
              Expanded(
                flex: 1,
                child: Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFF720102),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF6C5CE7).withValues(alpha: 0.18),
                        width: .5,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/profile_image.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
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
}
