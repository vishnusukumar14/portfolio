// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ContactSectionWidget extends StatefulWidget {
//   final void Function(String name, String email, String message)? onSend;
//
//   const ContactSectionWidget({super.key, this.onSend});
//
//   @override
//   State<ContactSectionWidget> createState() => _ContactSectionWidgetState();
// }
//
// class _ContactSectionWidgetState extends State<ContactSectionWidget> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _messageCtrl = TextEditingController();
//
//   bool _isSending = false;
//   bool _autoValidate = false;
//
//   String? _validateName(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Name is required';
//     }
//     return null;
//   }
//
//   String? _validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Email is required';
//     }
//     // Basic email regex
//     final regex = RegExp(
//       r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]+)+$",
//     );
//     if (!regex.hasMatch(value.trim())) {
//       return 'Enter a valid email address';
//     }
//     return null;
//   }
//
//   String? _validateMessage(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Please enter a message';
//     }
//     return null;
//   }
//
//   void _submitForm() async {
//     setState(() => _autoValidate = true);
//     if (!_formKey.currentState!.validate()) {
//       // If invalid, do not proceed
//       return;
//     }
//     setState(() => _isSending = true);
//
//     final name = _nameCtrl.text.trim();
//     final email = _emailCtrl.text.trim();
//     final message = _messageCtrl.text.trim();
//
//     // Simulate network or sending process
//     await Future.delayed(Duration(milliseconds: 800));
//
//     setState(() => _isSending = false);
//
//     // Callback or dummy response
//     if (widget.onSend != null) {
//       widget.onSend!(name, email, message);
//     } else {
//       // Default: show SnackBar with theme-aware colors
//       final theme = Theme.of(context);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Thank you, $name! Your message has been sent.'),
//           backgroundColor: theme.colorScheme.primary,
//           behavior: SnackBarBehavior.floating,
//         ),
//       );
//       _formKey.currentState!.reset();
//       _nameCtrl.clear();
//       _emailCtrl.clear();
//       _messageCtrl.clear();
//       setState(() => _autoValidate = false);
//     }
//   }
//
//   // Dispose controllers safely
//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _messageCtrl.dispose();
//     super.dispose();
//   }
//
//   bool get _isFormValid =>
//       _validateName(_nameCtrl.text) == null &&
//       _validateEmail(_emailCtrl.text) == null &&
//       _validateMessage(_messageCtrl.text) == null;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;
//     final textTheme = theme.textTheme;
//     final isDark = theme.brightness == Brightness.dark;
//
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Define breakpoint for mobile (700 is a good default for Flutter web/desktop/app)
//         final bool isMobile = constraints.maxWidth < 700;
//
//         // All values are adaptive!
//         final headingSize = isMobile ? 22.0 : 36.0;
//         final descriptionSize = isMobile ? 12.5 : 16.0;
//         final emailFontSize = isMobile ? 12.5 : 16.0;
//         final boxPaddingV = isMobile ? 26.0 : 80.0;
//         final boxPaddingH = isMobile ? 8.0 : 24.0;
//         final formPadding = isMobile ? 10.0 : 32.0;
//         final contentSpacing = isMobile ? 15.0 : 36.0;
//         final labelFontSize = isMobile ? 12.0 : 14.5;
//         final inputVerticalPad = isMobile ? 9.0 : 18.0;
//         final buttonPaddingV = isMobile ? 13.0 : 18.0;
//         final buttonFontSize = isMobile ? 13.5 : 16.0;
//
//         return Container(
//           // color: colorScheme.surface,
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(
//             vertical: boxPaddingV,
//             horizontal: boxPaddingH,
//           ),
//           child: Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: isMobile ? 400 : 750),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // --- Section Title ---
//                   Text(
//                     "Get in Touch",
//                     style:
//                         textTheme.headlineMedium?.copyWith(
//                           fontSize: headingSize,
//                           fontWeight: FontWeight.bold,
//                           color: colorScheme.onSurface,
//                           letterSpacing: -1.2,
//                         ) ??
//                         TextStyle(
//                           fontSize: headingSize,
//                           fontWeight: FontWeight.bold,
//                           color: colorScheme.onSurface,
//                           letterSpacing: -1.2,
//                         ),
//                   ),
//                   SizedBox(height: isMobile ? 10 : 18),
//                   RichText(
//                     text: TextSpan(
//                       style:
//                           textTheme.bodyMedium?.copyWith(
//                             fontSize: descriptionSize,
//                             color: colorScheme.onSurface.withOpacity(0.7),
//                             height: 1.55,
//                           ) ??
//                           TextStyle(
//                             fontSize: descriptionSize,
//                             color: colorScheme.onSurface.withOpacity(0.7),
//                             height: 1.55,
//                           ),
//                       children: [
//                         TextSpan(
//                           text:
//                               "I'd love to hear from you — whether it's a project, a question, or just to say hi! Fill out the form below or reach me directly at ",
//                         ),
//                         WidgetSpan(
//                           alignment: PlaceholderAlignment.middle,
//                           child: GestureDetector(
//                             onTap: () {
//                               final Uri emailLaunchUri = Uri(
//                                 scheme: 'mailto',
//                                 path: 'REMOVED_EMAIL',
//                               );
//                               launchUrl(emailLaunchUri);
//                             },
//                             child: Text(
//                               "REMOVED_EMAIL",
//                               style: TextStyle(
//                                 color: colorScheme.primary,
//                                 fontSize: emailFontSize,
//                                 fontWeight: FontWeight.w500,
//                                 letterSpacing: 0.4,
//                                 decorationColor: colorScheme.primary,
//                                 decorationThickness: 0.8,
//                                 decoration: TextDecoration.underline,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: contentSpacing),
//
//                   // --- CONTACT FORM ---
//                   Material(
//                     elevation: isDark ? 2 : 0,
//                     borderRadius: BorderRadius.circular(14),
//                     color: isDark
//                         ? colorScheme.surfaceContainer
//                         : colorScheme.surfaceContainerLowest,
//                     shadowColor: colorScheme.shadow.withOpacity(0.1),
//                     child: Padding(
//                       padding: EdgeInsets.all(formPadding),
//                       child: Form(
//                         key: _formKey,
//                         autovalidateMode: _autoValidate
//                             ? AutovalidateMode.always
//                             : AutovalidateMode.disabled,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             // Name Field
//                             TextFormField(
//                               controller: _nameCtrl,
//                               style: textTheme.bodyMedium?.copyWith(
//                                 fontSize: labelFontSize + 1,
//                                 color: colorScheme.onSurface,
//                               ),
//                               decoration: InputDecoration(
//                                 labelText: "Name",
//                                 labelStyle: textTheme.labelMedium?.copyWith(
//                                   fontSize: labelFontSize,
//                                   color: colorScheme.onSurface.withOpacity(0.7),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.outline,
//                                   ),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.outline,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.primary,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.error,
//                                   ),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.error,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 filled: true,
//                                 fillColor: colorScheme.surface,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: inputVerticalPad,
//                                   horizontal: 12,
//                                 ),
//                               ),
//                               validator: _validateName,
//                               onChanged: (v) => setState(() {}),
//                             ),
//                             SizedBox(height: isMobile ? 14 : 22),
//                             // Email Field
//                             TextFormField(
//                               controller: _emailCtrl,
//                               style: textTheme.bodyMedium?.copyWith(
//                                 fontSize: labelFontSize + 1,
//                                 color: colorScheme.onSurface,
//                               ),
//                               decoration: InputDecoration(
//                                 labelText: "Email",
//                                 labelStyle: textTheme.labelMedium?.copyWith(
//                                   fontSize: labelFontSize,
//                                   color: colorScheme.onSurface.withOpacity(0.7),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.outline,
//                                   ),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.outline,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.primary,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.error,
//                                   ),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.error,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 filled: true,
//                                 fillColor: colorScheme.surface,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: inputVerticalPad,
//                                   horizontal: 12,
//                                 ),
//                               ),
//                               validator: _validateEmail,
//                               keyboardType: TextInputType.emailAddress,
//                               onChanged: (v) => setState(() {}),
//                             ),
//                             SizedBox(height: isMobile ? 14 : 22),
//                             // Message Field
//                             TextFormField(
//                               controller: _messageCtrl,
//                               maxLines: 4,
//                               style: textTheme.bodyMedium?.copyWith(
//                                 fontSize: labelFontSize + 1,
//                                 color: colorScheme.onSurface,
//                               ),
//                               decoration: InputDecoration(
//                                 labelText: "Your Message",
//                                 labelStyle: textTheme.labelMedium?.copyWith(
//                                   fontSize: labelFontSize,
//                                   color: colorScheme.onSurface.withOpacity(0.7),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.outline,
//                                   ),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.outline,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.primary,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.error,
//                                   ),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                   borderSide: BorderSide(
//                                     color: colorScheme.error,
//                                     width: 2,
//                                   ),
//                                 ),
//                                 filled: true,
//                                 fillColor: colorScheme.surface,
//                                 contentPadding: EdgeInsets.symmetric(
//                                   vertical: inputVerticalPad,
//                                   horizontal: 12,
//                                 ),
//                               ),
//                               validator: _validateMessage,
//                               onChanged: (v) => setState(() {}),
//                             ),
//                             SizedBox(height: isMobile ? 20 : 32),
//                             ElevatedButton.icon(
//                               onPressed: _isFormValid && !_isSending
//                                   ? _submitForm
//                                   : null,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: colorScheme.primary,
//                                 foregroundColor: colorScheme.onPrimary,
//                                 disabledBackgroundColor: colorScheme.onSurface
//                                     .withOpacity(0.12),
//                                 disabledForegroundColor: colorScheme.onSurface
//                                     .withOpacity(0.38),
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: buttonPaddingV,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 elevation: isDark ? 1 : 2,
//                                 shadowColor: colorScheme.shadow.withOpacity(
//                                   0.3,
//                                 ),
//                               ),
//                               icon: _isSending
//                                   ? SizedBox(
//                                       width: 16,
//                                       height: 16,
//                                       child: CircularProgressIndicator(
//                                         color: colorScheme.onPrimary,
//                                         strokeWidth: 2.1,
//                                       ),
//                                     )
//                                   : Icon(
//                                       Icons.send_rounded,
//                                       color: colorScheme.onPrimary,
//                                     ),
//                               label: Text(
//                                 _isSending ? 'Sending...' : 'Send Message',
//                                 style:
//                                     textTheme.labelLarge?.copyWith(
//                                       color: colorScheme.onPrimary,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: buttonFontSize,
//                                     ) ??
//                                     TextStyle(
//                                       color: colorScheme.onPrimary,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: buttonFontSize,
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: isMobile ? 16 : 34),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EnhancedContactSectionWidget extends StatefulWidget {
  final void Function(String name, String email, String message)? onSend;
  final String?
  whatsappNumber; // WhatsApp number with country code (e.g., "+919876543210")
  final String? emailAddress; // Email address for mailto

  const EnhancedContactSectionWidget({
    super.key,
    this.onSend,
    this.whatsappNumber =
        "+919876543210", // Default number - replace with yours
    this.emailAddress = "REMOVED_EMAIL", // Default email
  });

  @override
  State<EnhancedContactSectionWidget> createState() =>
      _EnhancedContactSectionWidgetState();
}

class _EnhancedContactSectionWidgetState
    extends State<EnhancedContactSectionWidget>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  bool _isSending = false;
  bool _autoValidate = false;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]+)+$",
    );
    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a message';
    }
    if (value.trim().length < 10) {
      return 'Message must be at least 10 characters';
    }
    return null;
  }

  Future<void> _saveToFirestore(
    String name,
    String email,
    String message,
  ) async {
    try {
      final contactData = {
        'name': name,
        'email': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'new',
        'source': 'contact_form',
      };

      await FirebaseFirestore.instance
          .collection('portfolio_contact_messages')
          .add(contactData);

      debugPrint('Message saved to Firestore successfully');
    } catch (e) {
      debugPrint('Error saving to Firestore: $e');
      rethrow;
    }
  }

  void _submitForm() async {
    setState(() => _autoValidate = true);
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSending = true);

    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final message = _messageCtrl.text.trim();

    try {
      // Save to Firestore
      await _saveToFirestore(name, email, message);

      // Simulate additional processing time
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() => _isSending = false);

      if (widget.onSend != null) {
        widget.onSend!(name, email, message);
      } else {
        final theme = Theme.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Thank you, $name! Your message has been sent successfully.',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );

        // Clear form
        _formKey.currentState!.reset();
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();
        setState(() => _autoValidate = false);
      }
    } catch (e) {
      setState(() => _isSending = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Failed to send message. Please try again.',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: widget.emailAddress,
      queryParameters: {
        'subject': 'Hello from your website visitor',
        'body':
            'Hi,\n\nI would like to get in touch with you.\n\nBest regards,',
      },
    );

    try {
      await launchUrl(emailLaunchUri);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open email app. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _launchWhatsApp() async {
    final message = Uri.encodeComponent(
      'Hi! I visited your website and would like to connect with you.',
    );
    final whatsappUrl =
        'https://wa.me/${widget.whatsappNumber?.replaceAll('+', '')}?text=$message';

    try {
      await launchUrl(
        Uri.parse(whatsappUrl),
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not open WhatsApp. Please make sure it\'s installed.',
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  bool get _isFormValid =>
      _validateName(_nameCtrl.text) == null &&
      _validateEmail(_emailCtrl.text) == null &&
      _validateMessage(_messageCtrl.text) == null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        // Responsive values
        final headingSize = isMobile ? 24.0 : 40.0;
        final descriptionSize = isMobile ? 13.0 : 17.0;
        final emailFontSize = isMobile ? 13.0 : 17.0;
        final boxPaddingV = isMobile ? 32.0 : 80.0;
        final boxPaddingH = isMobile ? 16.0 : 32.0;
        final formPadding = isMobile ? 16.0 : 40.0;
        final contentSpacing = isMobile ? 20.0 : 40.0;
        final labelFontSize = isMobile ? 13.0 : 15.0;
        final inputVerticalPad = isMobile ? 12.0 : 20.0;
        final buttonPaddingV = isMobile ? 16.0 : 20.0;
        final buttonFontSize = isMobile ? 14.0 : 16.0;

        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: boxPaddingV,
                horizontal: boxPaddingH,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: isMobile ? 450 : 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Text(
                        "Get in Touch",
                        style: textTheme.headlineLarge?.copyWith(
                          fontSize: headingSize,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          letterSpacing: -1.5,
                        ),
                      ),
                      SizedBox(height: isMobile ? 12 : 20),

                      RichText(
                        text: TextSpan(
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: descriptionSize,
                            color: colorScheme.onSurface.withOpacity(0.7),
                            height: 1.6,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  "I'd love to hear from you! Whether it's about a project, collaboration, or just to say hello. ",
                            ),
                            const TextSpan(
                              text:
                                  "You can fill out the form below or reach me directly via email or WhatsApp.",
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: contentSpacing),

                      // Quick Contact Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildContactButton(
                              icon: Icons.email_outlined,
                              label: 'Email Me',
                              onTap: _launchEmail,
                              color: colorScheme.primary,
                              isMobile: isMobile,
                            ),
                          ),
                          SizedBox(width: isMobile ? 12 : 16),
                          Expanded(
                            child: _buildContactButton(
                              icon: Icons.chat_bubble_outline,
                              label: 'WhatsApp',
                              onTap: _launchWhatsApp,
                              color: const Color(0xFF038C37), // WhatsApp green
                              isMobile: isMobile,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 24 : 32),

                      // Divider with "OR" text
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: colorScheme.outline.withOpacity(0.5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR',
                              style: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: isMobile ? 12 : 14,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: colorScheme.outline.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 24 : 32),

                      // Contact Form
                      Material(
                        elevation: isDark ? 4 : 2,
                        borderRadius: BorderRadius.circular(16),
                        color: isDark
                            ? colorScheme.surfaceContainer
                            : colorScheme.surfaceContainerLowest,
                        shadowColor: colorScheme.shadow.withOpacity(0.1),
                        child: Padding(
                          padding: EdgeInsets.all(formPadding),
                          child: Form(
                            key: _formKey,
                            autovalidateMode: _autoValidate
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'Send me a message',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.onSurface,
                                    fontSize: isMobile ? 16 : 18,
                                  ),
                                ),
                                SizedBox(height: isMobile ? 20 : 24),

                                // Name Field
                                _buildTextField(
                                  controller: _nameCtrl,
                                  label: "Full Name",
                                  validator: _validateName,
                                  prefixIcon: Icons.person_outline,
                                  textInputAction: TextInputAction.next,
                                  isMobile: isMobile,
                                  labelFontSize: labelFontSize,
                                  inputVerticalPad: inputVerticalPad,
                                ),
                                SizedBox(height: isMobile ? 16 : 24),

                                // Email Field
                                _buildTextField(
                                  controller: _emailCtrl,
                                  label: "Email Address",
                                  validator: _validateEmail,
                                  prefixIcon: Icons.email_outlined,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  isMobile: isMobile,
                                  labelFontSize: labelFontSize,
                                  inputVerticalPad: inputVerticalPad,
                                ),
                                SizedBox(height: isMobile ? 16 : 24),

                                // Message Field
                                _buildTextField(
                                  controller: _messageCtrl,
                                  label: "Your Message",
                                  validator: _validateMessage,
                                  prefixIcon: Icons.message_outlined,
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  isMobile: isMobile,
                                  labelFontSize: labelFontSize,
                                  inputVerticalPad: inputVerticalPad,
                                ),
                                SizedBox(height: isMobile ? 24 : 32),

                                // Submit Button
                                ElevatedButton.icon(
                                  onPressed: _isFormValid && !_isSending
                                      ? _submitForm
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: colorScheme.primary,
                                    foregroundColor: colorScheme.onPrimary,
                                    disabledBackgroundColor: colorScheme
                                        .onSurface
                                        .withOpacity(0.12),
                                    disabledForegroundColor: colorScheme
                                        .onSurface
                                        .withOpacity(0.38),
                                    padding: EdgeInsets.symmetric(
                                      vertical: buttonPaddingV,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: isDark ? 2 : 4,
                                    shadowColor: colorScheme.shadow.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                  icon: _isSending
                                      ? SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            color: colorScheme.onPrimary,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Icon(
                                          Icons.send_rounded,
                                          size: isMobile ? 18 : 20,
                                        ),
                                  label: Text(
                                    _isSending
                                        ? 'Sending Message...'
                                        : 'Send Message',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: buttonFontSize,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: isMobile ? 20 : 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
    required bool isMobile,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 14 : 16,
            horizontal: isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.08),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: isMobile ? 18 : 20),
              SizedBox(width: isMobile ? 6 : 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 13 : 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLines = 1,
    required bool isMobile,
    required double labelFontSize,
    required double inputVerticalPad,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextFormField(
      controller: controller,
      style: textTheme.bodyMedium?.copyWith(
        fontSize: labelFontSize + 1,
        color: colorScheme.onSurface,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefixIcon,
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
        labelStyle: textTheme.labelMedium?.copyWith(
          fontSize: labelFontSize,
          color: colorScheme.onSurface.withOpacity(0.7),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: EdgeInsets.symmetric(
          vertical: inputVerticalPad,
          horizontal: 16,
        ),
      ),
      validator: validator,
      onChanged: (v) => setState(() {}),
    );
  }
}
