import 'package:flutter/material.dart';

class EducationCardWidget extends StatelessWidget {
  final String degree;
  final String institution;
  final String duration;
  final String? location; // <-- NEW
  final String? university; // <-- NEW
  final String? score;

  const EducationCardWidget({
    super.key,
    required this.degree,
    required this.institution,
    required this.duration,
    this.location, // <-- NEW
    this.university, // <-- NEW
    this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 500, minWidth: 400),
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFF4D0202).withValues(alpha: 0.13),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4D0202).withValues(alpha: 0.06),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            degree,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6),
          Text(
            institution,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Colors.grey[800],
            ),
          ),
          if (university != null) ...[
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.school, size: 16, color: Color(0xFF4D0202)),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    university!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (location != null) ...[
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Color(0xFF4D0202)),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    location!,
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 8),
          Text(
            duration,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Color(0xFF4D0202),
            ),
          ),
          if (score != null) ...[
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.emoji_events, size: 15, color: Colors.green[700]),
                SizedBox(width: 6),
                Text(
                  'Score: ',
                  style: TextStyle(fontSize: 12, color: Colors.green[800]),
                ),
                Text(
                  score!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
