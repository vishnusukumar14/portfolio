import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/core/contents.dart';
import 'package:portfolio_app/core/util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/responsive_utility.dart';

class EnhancedContactSectionWidget extends StatefulWidget {
  final void Function(String name, String email, String message)? onSend;
  final String? whatsappNumber;
  final String? emailAddress;

  const EnhancedContactSectionWidget({
    super.key,
    this.onSend,
    this.whatsappNumber = Contents.myPhoneNumber,
    this.emailAddress = Contents.myEmailId,
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

  // Real-time validation states
  bool _nameValid = false;
  bool _emailValid = false;
  bool _messageValid = false;
  bool _nameTouched = false;
  bool _emailTouched = false;
  bool _messageTouched = false;

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

    // Add listeners for real-time validation
    _nameCtrl.addListener(_validateNameRealTime);
    _emailCtrl.addListener(_validateEmailRealTime);
    _messageCtrl.addListener(_validateMessageRealTime);
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

  // Real-time validation methods
  void _validateNameRealTime() {
    setState(() {
      _nameTouched = true;
      _nameValid = _validateName(_nameCtrl.text) == null;
    });
  }

  void _validateEmailRealTime() {
    setState(() {
      _emailTouched = true;
      _emailValid = _validateEmail(_emailCtrl.text) == null;
    });
  }

  void _validateMessageRealTime() {
    setState(() {
      _messageTouched = true;
      _messageValid = _validateMessage(_messageCtrl.text) == null;
    });
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
        if (mounted) {
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
        }

        // Clear form and reset validation states
        _formKey.currentState!.reset();
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();
        setState(() {
          _autoValidate = false;
          _nameTouched = false;
          _emailTouched = false;
          _messageTouched = false;
          _nameValid = false;
          _emailValid = false;
          _messageValid = false;
        });
      }
    } catch (e) {
      setState(() => _isSending = false);
      if (mounted) {
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

  bool get _isFormValid => _nameValid && _emailValid && _messageValid;

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
        final boxPaddingV = isMobile ? 32.0 : 80.0;
        final boxPaddingH = isMobile ? 16.0 : 32.0;
        final formPadding = isMobile ? 16.0 : 40.0;
        final contentSpacing = isMobile ? 20.0 : 40.0;
        final labelFontSize = isMobile ? 13.0 : 15.0;
        final inputVerticalPad = isMobile ? 12.0 : 20.0;
        final buttonPaddingV = isMobile ? 16.0 : 20.0;
        final buttonFontSize = isMobile ? 14.0 : 16.0;

        return Column(
          children: [
            // Contact Section
            FadeTransition(
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
                      constraints: BoxConstraints(
                        maxWidth: isMobile ? 450 : 800,
                        // maxHeight: MediaQuery.of(context).size.height,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Section
                          WidgetBuilders.sectionHeader(
                            context: context,
                            isMobile: isMobile,
                            icon: Icons.contact_page_sharp,
                            title: "Get In Touch",
                          ),

                          SizedBox(height: isMobile ? 12 : 20),

                          RichText(
                            text: TextSpan(
                              style: textTheme.bodyLarge?.copyWith(
                                fontSize: descriptionSize,
                                color: colorScheme.onSurface.withValues(
                                  alpha: 0.7,
                                ),
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
                                  color: const Color(0xFF038C37),
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
                                  color: colorScheme.outline.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    color: colorScheme.onSurface.withValues(
                                      alpha: 0.6,
                                    ),
                                    fontWeight: FontWeight.w500,
                                    fontSize: isMobile ? 12 : 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: colorScheme.outline.withValues(
                                    alpha: 0.5,
                                  ),
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
                            shadowColor: colorScheme.shadow.withValues(
                              alpha: 0.1,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(formPadding),
                              child: Form(
                                key: _formKey,
                                autovalidateMode: _autoValidate
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                      isValid: _nameValid,
                                      isTouched: _nameTouched,
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
                                      isValid: _emailValid,
                                      isTouched: _emailTouched,
                                    ),
                                    SizedBox(height: isMobile ? 16 : 24),

                                    // Message Field
                                    _buildTextField(
                                      controller: _messageCtrl,
                                      label: "Your Message",
                                      validator: _validateMessage,
                                      prefixIcon: Icons.message_outlined,
                                      maxLines: 2,
                                      textInputAction: TextInputAction.done,
                                      isMobile: isMobile,
                                      labelFontSize: labelFontSize,
                                      inputVerticalPad: inputVerticalPad,
                                      isValid: _messageValid,
                                      isTouched: _messageTouched,
                                    ),
                                    SizedBox(height: isMobile ? 24 : 32),

                                    // Submit Button with validation indicator
                                    AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      child: ElevatedButton.icon(
                                        onPressed: _isFormValid && !_isSending
                                            ? _submitForm
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _isFormValid
                                              ? colorScheme.primary
                                              : colorScheme.onSurface
                                                    .withValues(alpha: 0.12),
                                          foregroundColor: _isFormValid
                                              ? colorScheme.onPrimary
                                              : colorScheme.onSurface
                                                    .withValues(alpha: 0.38),
                                          padding: EdgeInsets.symmetric(
                                            vertical: buttonPaddingV,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          elevation: _isFormValid
                                              ? (isDark ? 2 : 4)
                                              : 0,
                                          shadowColor: colorScheme.shadow
                                              .withValues(alpha: 0.3),
                                        ),
                                        icon: _isSending
                                            ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      color:
                                                          colorScheme.onPrimary,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Footer Section
            _buildFooter(isMobile, colorScheme, textTheme),
          ],
        );
      },
    );
  }

  Widget _buildFooter(
    bool isMobile,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Column(
      children: [
        // Main Footer Content
        Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 24 : 32,
                  horizontal: isMobile ? 20 : 32,
                ),
                // decoration: BoxDecoration(
                //   color: colorScheme.surfaceContainerHighest.withValues(
                //     alpha: 0.2,
                //   ),
                //   borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
                //   border: Border.all(
                //     color: colorScheme.outline.withValues(alpha: 0.1),
                //     width: 1,
                //   ),
                // ),
                child: Column(
                  children: [
                    // Name
                    // Text(
                    //   'VISHNU S',
                    //   style: textTheme.headlineSmall?.copyWith(
                    //     color: colorScheme.onSurface,
                    //     fontWeight: FontWeight.w700,
                    //     fontSize: isMobile ? 28 : 36,
                    //     letterSpacing: 2.0,
                    //   ),
                    // ),

                    // SizedBox(height: isMobile ? 16 : 20),
                    // Contact Info Row 1: Email & Phone
                    if (isMobile) ...[
                      // Mobile: Stack vertically
                      _buildContactInfo(
                        icon: Icons.email_outlined,
                        text: Contents.myEmailId,
                        colorScheme: colorScheme,
                        isMobile: isMobile,
                      ),
                      SizedBox(height: 8),
                      _buildContactInfo(
                        icon: Icons.phone_outlined,
                        text: Contents.myPhoneNumber,
                        colorScheme: colorScheme,
                        isMobile: isMobile,
                      ),
                      SizedBox(height: 12),
                      _buildContactInfo(
                        icon: Icons.work_outline,
                        text: 'linkedin.com/in/vishnus14',
                        colorScheme: colorScheme,
                        isMobile: isMobile,
                        url: Contents.myLinkedInUrl,
                        assetPath: Contents.linkedInLogoAssetPath,
                      ),
                      SizedBox(height: 8),
                      _buildContactInfo(
                        icon: Icons.code,
                        text: 'github.com/vishnusukumar14',
                        colorScheme: colorScheme,
                        isMobile: isMobile,
                        assetPath: Contents.githubMarkAssetPath,
                        url: Contents.myGithubUrl,
                      ),
                    ] else ...[
                      // Desktop: Two rows
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildContactInfo(
                            icon: Icons.email_outlined,
                            text: Contents.myEmailId,
                            colorScheme: colorScheme,
                            isMobile: isMobile,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            width: 1,
                            height: 20,
                            color: colorScheme.outline.withValues(alpha: 0.3),
                          ),
                          _buildContactInfo(
                            icon: Icons.phone_outlined,
                            text: Contents.myPhoneNumber,
                            colorScheme: colorScheme,
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildContactInfo(
                            icon: Icons.work_outline,
                            text: 'linkedin.com/in/vishnus14',
                            colorScheme: colorScheme,
                            isMobile: isMobile,
                            url: Contents.myLinkedInUrl,
                            assetPath: Contents.linkedInLogoMarkAssetPath,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            width: 1,
                            height: 20,
                            color: colorScheme.outline.withValues(alpha: 0.3),
                          ),
                          _buildContactInfo(
                            icon: Icons.code,
                            text: 'github.com/vishnusukumar14',
                            colorScheme: colorScheme,
                            isMobile: isMobile,
                            url: Contents.myGithubUrl,
                            assetPath: Contents.githubMarkAssetPath,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String text,
    required ColorScheme colorScheme,
    required bool isMobile,
    String? assetPath,
    String? url,
  }) {
    return InkWell(
      onTap: url != null
          ? () async {
              Utils.launch(url);
            }
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: isMobile ? 16 : 18,
            height: isMobile ? 16 : 18,
            child: assetPath != null
                ? Image.asset(
                    assetPath,
                    width: isMobile ? 16 : 18,
                    height: isMobile ? 16 : 18,
                    fit: BoxFit.contain,
                    color: colorScheme.primary,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        icon,
                        size: isMobile ? 16 : 18,
                        color: colorScheme.primary,
                      );
                    },
                  )
                : Icon(
                    icon,
                    size: isMobile ? 16 : 18,
                    color: colorScheme.primary,
                  ),
          ),
          SizedBox(width: 8),
          SelectableText(
            text,
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.8),
              fontSize: isMobile ? 14 : 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
    required bool isMobile,
  }) {
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
            border: Border.all(color: color.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(12),
            color: color.withValues(alpha: 0.08),
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
    required bool isValid,
    required bool isTouched,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Determine suffix icon based on validation state
    Widget? suffixIcon;
    if (isTouched) {
      if (isValid) {
        suffixIcon = Icon(Icons.check_circle, color: Colors.green, size: 20);
      } else if (controller.text.isNotEmpty) {
        suffixIcon = Icon(Icons.error, color: colorScheme.error, size: 20);
      }
    }

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
          color: colorScheme.onSurface.withValues(alpha: 0.6),
        ),
        suffixIcon: suffixIcon,
        labelStyle: textTheme.labelMedium?.copyWith(
          fontSize: labelFontSize,
          color: colorScheme.onSurface.withValues(alpha: 0.7),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isTouched && isValid
                ? Colors.green.withValues(alpha: 0.7)
                : colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isTouched && isValid ? Colors.green : colorScheme.primary,
            width: 2,
          ),
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
