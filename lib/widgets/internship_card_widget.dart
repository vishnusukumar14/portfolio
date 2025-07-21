// // import 'package:flutter/material.dart';
// // import 'package:url_launcher/url_launcher.dart';
// //
// // import '../core/models/experience.dart';
// //
// // class InternshipCard extends StatelessWidget {
// //   final Experience experience;
// //
// //   const InternshipCard({super.key, required this.experience});
// //
// //   void _launchWebsite(String urlString) async {
// //     final Uri url = Uri.parse(urlString);
// //
// //     if (await canLaunchUrl(url)) {
// //       await launchUrl(
// //         url,
// //         mode: LaunchMode.externalApplication, // Opens in browser
// //       );
// //     } else {
// //       throw 'Could not launch $url';
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.grey.shade50,
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: Colors.grey.shade200, width: 1.3),
// //       ),
// //       padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           /// Header row
// //           Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Icon(
// //                 Icons.work_outline_rounded,
// //                 color: Colors.grey[600],
// //                 size: 22,
// //               ),
// //               SizedBox(width: 8),
// //               Expanded(
// //                 child: Text(
// //                   experience.title,
// //                   style: TextStyle(
// //                     color: Colors.black,
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 18,
// //                     letterSpacing: -0.5,
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(width: 10),
// //               Container(
// //                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey.shade100,
// //                   border: Border.all(color: Colors.grey.shade200),
// //                   borderRadius: BorderRadius.circular(24),
// //                 ),
// //                 child: Text(
// //                   experience.location,
// //                   style: TextStyle(
// //                     color: Colors.grey[600],
// //                     fontSize: 11,
// //                     fontWeight: FontWeight.w600,
// //                     letterSpacing: 0.15,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 7),
// //           GestureDetector(
// //             onTap: () {
// //               _launchWebsite(experience.companyUrl);
// //             },
// //             child: Text(
// //               experience.company,
// //               style: TextStyle(
// //                 color: Color(0xFF720102),
// //                 decoration: TextDecoration.underline,
// //                 decorationColor: Color(0xFF720102),
// //                 decorationThickness: 0.6,
// //                 fontWeight: FontWeight.w500,
// //                 fontSize: 15.5,
// //               ),
// //             ),
// //           ),
// //
// //           SizedBox(height: 4),
// //           Text(
// //             experience.duration,
// //             style: TextStyle(
// //               color: Colors.blueGrey,
// //               fontSize: 13,
// //               fontWeight: FontWeight.w400,
// //             ),
// //           ),
// //
// //           SizedBox(height: 12),
// //
// //           /// Highlights
// //           Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: experience.highlights
// //                 .map(
// //                   (highlight) => Padding(
// //                     padding: const EdgeInsets.only(bottom: 5),
// //                     child: Row(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         Text(
// //                           '• ',
// //                           style: TextStyle(fontSize: 14, color: Colors.black),
// //                         ),
// //                         Expanded(
// //                           child: Text(
// //                             highlight,
// //                             style: TextStyle(
// //                               color: Colors.black,
// //                               fontSize: 13.5,
// //                               height: 1.53,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 )
// //                 .toList(),
// //           ),
// //
// //           SizedBox(height: 11),
// //
// //           /// Tech stack as chips
// //           Wrap(
// //             spacing: 9,
// //             runSpacing: 4,
// //             children: experience.techStack
// //                 .map(
// //                   (tech) => Chip(
// //                     label: Text(
// //                       tech,
// //                       style: TextStyle(
// //                         fontSize: 11.5,
// //                         color: Color(0xFF720102),
// //                         fontWeight: FontWeight.w500,
// //                       ),
// //                     ),
// //                     backgroundColor: Color(0xFF720102).withValues(alpha: 0.09),
// //                     side: BorderSide(
// //                       color: Color(0xFF720102).withValues(alpha: 0.17),
// //                     ),
// //                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
// //                   ),
// //                 )
// //                 .toList(),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../core/models/experience.dart';
//
// class InternshipCard extends StatelessWidget {
//   final Experience experience;
//
//   const InternshipCard({super.key, required this.experience});
//
//   void _launchWebsite(String urlString) async {
//     final Uri url = Uri.parse(urlString);
//     if (await canLaunchUrl(url)) {
//       await launchUrl(url, mode: LaunchMode.externalApplication);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: theme.cardColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.04),
//             blurRadius: 15,
//             offset: Offset(0, 6),
//           ),
//         ],
//         border: Border.all(
//           color: theme.dividerColor.withValues(alpha: 0.17),
//           width: 1.1,
//         ),
//       ),
//       padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Top Row: Logo, Title, Location
//           Row(
//             children: [
//               // Company logo or default avatar
//               if (experience.companyLogoUrl != null &&
//                   experience.companyLogoUrl!.isNotEmpty)
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(8),
//                   child: Image.network(
//                     experience.companyLogoUrl!,
//                     width: 88,
//                     height: 88,
//                     fit: BoxFit.fitWidth,
//                     errorBuilder: (c, e, s) => CircleAvatar(
//                       backgroundColor: theme.primaryColorLight,
//                       radius: 19,
//                       child: Icon(
//                         Icons.business,
//                         color: theme.primaryColorDark,
//                       ),
//                     ),
//                   ),
//                 )
//               else
//                 CircleAvatar(
//                   radius: 19,
//                   backgroundColor: theme.primaryColorLight.withValues(
//                     alpha: 0.97,
//                   ),
//                   child: Icon(
//                     Icons.business,
//                     color: theme.primaryColorDark,
//                     size: 22,
//                   ),
//                 ),
//               SizedBox(width: 13),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       experience.title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: theme.textTheme.titleMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 17.2,
//                         letterSpacing: -0.2,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: 1),
//                     GestureDetector(
//                       onTap: () => _launchWebsite(experience.companyProfileUrl),
//                       child: Text(
//                         experience.company,
//                         style: theme.textTheme.bodyLarge?.copyWith(
//                           color: theme.colorScheme.primary,
//                           fontWeight: FontWeight.w600,
//                           decoration: TextDecoration.underline,
//                           fontSize: 15.2,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 9),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 11, vertical: 3),
//                 decoration: BoxDecoration(
//                   color: theme.primaryColorLight.withValues(alpha: 0.22),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.location_on,
//                       size: 13,
//                       color: theme.primaryColorDark.withValues(alpha: 0.75),
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       experience.location,
//                       style: TextStyle(
//                         color: theme.primaryColorDark.withValues(alpha: 0.75),
//                         fontSize: 11.5,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: 0.16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           SizedBox(height: 8),
//
//           /// Duration
//           Text(
//             experience.duration,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: Colors.grey[700],
//               fontSize: 13.2,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 10),
//
//           Divider(
//             height: 22,
//             color: theme.dividerColor.withValues(alpha: 0.23),
//           ),
//
//           /// Highlights
//           ...experience.highlights.asMap().entries.map((entry) {
//             final i = entry.key;
//             final highlight = entry.value;
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 7),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "•",
//                     style: TextStyle(
//                       color: theme.colorScheme.secondary,
//                       fontWeight: FontWeight.w900,
//                       fontSize: 19,
//                       height: 1,
//                     ),
//                   ),
//                   SizedBox(width: 9),
//                   Expanded(
//                     child: Text(
//                       highlight.trim(),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 13.3,
//                         fontWeight: i == 0 ? FontWeight.bold : FontWeight.w500,
//                         height: 1.55,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//
//           if (experience.highlights.isNotEmpty) SizedBox(height: 11),
//
//           /// Tech stack chips
//           Wrap(
//             spacing: 8,
//             runSpacing: 5,
//             children: experience.techStack
//                 .map(
//                   (tech) => Chip(
//                     label: Text(
//                       tech,
//                       style: TextStyle(
//                         fontSize: 11.7,
//                         color: theme.colorScheme.primary,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     avatar: Icon(
//                       Icons.code,
//                       size: 14,
//                       color: theme.colorScheme.primary,
//                     ),
//                     backgroundColor: theme.primaryColorLight.withValues(
//                       alpha: 0.16,
//                     ),
//                     side: BorderSide(
//                       color: theme.primaryColorDark.withValues(alpha: 0.20),
//                       width: 0.8,
//                     ),
//                     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/models/experience.dart';

class InternshipCard extends StatelessWidget {
  final Experience experience;

  const InternshipCard({super.key, required this.experience});

  void _launchWebsite(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 500;

        // Responsive sizes
        final double logoSize = isMobile ? 48 : 88;
        final double avatarRadius = isMobile ? 16 : 19;
        final double titleFontSize = isMobile ? 15 : 17.2;
        final double companyFontSize = isMobile ? 13.5 : 15.2;
        final double locationFontSize = isMobile ? 10 : 11.5;
        final double chipFontSize = isMobile ? 10.5 : 11.7;
        final double chipIconSize = isMobile ? 11 : 14;
        final double highlightFontSize = isMobile ? 12 : 13.3;
        final double highlightBulletSize = isMobile ? 15 : 19;
        final double durationFontSize = isMobile ? 11.5 : 13.2;
        final double highlightSpacing = isMobile ? 5 : 7;
        final double wrapSpacing = isMobile ? 5 : 8;
        final double wrapRunSpacing = isMobile ? 3 : 5;
        final double paddingV = isMobile ? 12 : 18;
        final double paddingH = isMobile ? 10 : 20;
        final double dividerHeight = isMobile ? 14 : 22;
        final double dividerThick = isMobile ? 0.5 : 1;
        final double headerSpacing = isMobile ? 7 : 13;

        return Container(
          margin: EdgeInsets.symmetric(vertical: isMobile ? 6 : 8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(isMobile ? 12 : 18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: isMobile ? 6 : 15,
                offset: Offset(0, isMobile ? 2 : 6),
              ),
            ],
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.17),
              width: isMobile ? 0.7 : 1.1,
            ),
          ),
          padding: EdgeInsets.fromLTRB(paddingH, paddingV, paddingH, paddingV),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Row: Logo, Title, Location
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo/avatar
                  if (experience.companyLogoUrl != null &&
                      experience.companyLogoUrl!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(isMobile ? 5 : 8),
                      child: Image.network(
                        experience.companyLogoUrl!,
                        width: logoSize,
                        height: logoSize,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (c, e, s) => CircleAvatar(
                          backgroundColor: theme.primaryColorLight,
                          radius: avatarRadius,
                          child: Icon(
                            Icons.business,
                            color: theme.primaryColorDark,
                            size: isMobile ? 17 : 22,
                          ),
                        ),
                      ),
                    )
                  else
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: theme.primaryColorLight.withValues(
                        alpha: 0.97,
                      ),
                      child: Icon(
                        Icons.business,
                        color: theme.primaryColorDark,
                        size: isMobile ? 17 : 22,
                      ),
                    ),
                  SizedBox(width: headerSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experience.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFontSize,
                            letterSpacing: -0.2,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: isMobile ? 0.5 : 1),
                        GestureDetector(
                          onTap: () =>
                              _launchWebsite(experience.companyProfileUrl),
                          child: Text(
                            experience.company,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                              fontSize: companyFontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: isMobile ? 5 : 9),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 7 : 11,
                      vertical: isMobile ? 2 : 3,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColorLight.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(isMobile ? 8 : 15),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: isMobile ? 10 : 13,
                          color: theme.primaryColorDark.withValues(alpha: 0.75),
                        ),
                        SizedBox(width: isMobile ? 2.5 : 4),
                        Text(
                          experience.location,
                          style: TextStyle(
                            color: theme.primaryColorDark.withValues(
                              alpha: 0.75,
                            ),
                            fontSize: locationFontSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: isMobile ? 6 : 8),

              /// Duration
              Text(
                experience.duration,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  fontSize: durationFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: isMobile ? 7 : 10),

              Divider(
                height: dividerHeight,
                thickness: dividerThick,
                color: theme.dividerColor.withValues(alpha: 0.23),
              ),

              /// Highlights
              ...experience.highlights.asMap().entries.map((entry) {
                final i = entry.key;
                final highlight = entry.value;
                return Padding(
                  padding: EdgeInsets.only(bottom: highlightSpacing),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "•",
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w900,
                          fontSize: highlightBulletSize,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: isMobile ? 5 : 9),
                      Expanded(
                        child: Text(
                          highlight.trim(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: highlightFontSize,
                            fontWeight: i == 0
                                ? FontWeight.bold
                                : FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),

              if (experience.highlights.isNotEmpty)
                SizedBox(height: isMobile ? 8 : 11),

              /// Tech stack chips
              Wrap(
                spacing: wrapSpacing,
                runSpacing: wrapRunSpacing,
                children: experience.techStack
                    .map(
                      (tech) => Chip(
                        label: Text(
                          tech,
                          style: TextStyle(
                            fontSize: chipFontSize,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        avatar: Icon(
                          Icons.code,
                          size: chipIconSize,
                          color: theme.colorScheme.primary,
                        ),
                        backgroundColor: theme.primaryColorLight.withValues(
                          alpha: 0.16,
                        ),
                        side: BorderSide(
                          color: theme.primaryColorDark.withValues(alpha: 0.20),
                          width: isMobile ? 0.5 : 0.8,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 6 : 8,
                          vertical: 0,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
