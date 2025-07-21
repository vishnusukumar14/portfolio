import 'package:flutter/material.dart';

/// A widget that mimics the GitHub contributions grid UI.
class ContributionGrid extends StatelessWidget {
  final int totalContributions;
  final List<List<int>> gridData; // [week][day]
  final List<Color> levelColors;

  const ContributionGrid({
    super.key,
    required this.totalContributions,
    required this.gridData,
    this.levelColors = const [
      Color(0xFFEDEDED), // Level 0: No contributions
      Color(0xFF9BE9A8), // Level 1
      Color(0xFF40C463), // Level 2
      Color(0xFF30A14E), // Level 3
      Color(0xFF216E39), // Level 4: Max contributions
    ],
  });

  Color _colorForCount(int count) {
    if (count == 0) return levelColors[0];
    if (count == 1) return levelColors[1];
    if (count < 4) return levelColors[2];
    if (count < 7) return levelColors[3];
    return levelColors[4];
  }

  @override
  Widget build(BuildContext context) {
    final int weeks = gridData.length;
    final int days = gridData[0].length;

    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              "$totalContributions contributions in the last year",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 22),

            // Grid rows
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                weeks,
                (x) => Column(
                  children: List.generate(
                    days,
                    (y) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 2.5,
                      ),
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: _colorForCount(gridData[x][y]),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Legend
            Row(
              children: [
                Text(
                  "Less",
                  style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                ),
                SizedBox(width: 10),
                ...levelColors.map(
                  (c) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.5),
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                        color: c,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "More",
                  style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
