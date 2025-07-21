import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSectionWidget extends StatefulWidget {
  final void Function(String name, String email, String message)? onSend;

  const ContactSectionWidget({super.key, this.onSend});

  @override
  State<ContactSectionWidget> createState() => _ContactSectionWidgetState();
}

class _ContactSectionWidgetState extends State<ContactSectionWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  bool _isSending = false;
  bool _autoValidate = false;

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    // Basic email regex
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
    return null;
  }

  void _submitForm() async {
    setState(() => _autoValidate = true);
    if (!_formKey.currentState!.validate()) {
      // If invalid, do not proceed
      return;
    }
    setState(() => _isSending = true);

    final name = _nameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final message = _messageCtrl.text.trim();

    // Simulate network or sending process
    await Future.delayed(Duration(milliseconds: 800));

    setState(() => _isSending = false);

    // Callback or dummy response
    if (widget.onSend != null) {
      widget.onSend!(name, email, message);
    } else {
      // Default: show SnackBar with theme-aware colors
      final theme = Theme.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thank you, $name! Your message has been sent.'),
          backgroundColor: theme.colorScheme.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
      _formKey.currentState!.reset();
      _nameCtrl.clear();
      _emailCtrl.clear();
      _messageCtrl.clear();
      setState(() => _autoValidate = false);
    }
  }

  // Dispose controllers safely
  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
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
        // Define breakpoint for mobile (700 is a good default for Flutter web/desktop/app)
        final bool isMobile = constraints.maxWidth < 700;

        // All values are adaptive!
        final headingSize = isMobile ? 22.0 : 36.0;
        final descriptionSize = isMobile ? 12.5 : 16.0;
        final emailFontSize = isMobile ? 12.5 : 16.0;
        final boxPaddingV = isMobile ? 26.0 : 80.0;
        final boxPaddingH = isMobile ? 8.0 : 24.0;
        final formPadding = isMobile ? 10.0 : 32.0;
        final contentSpacing = isMobile ? 15.0 : 36.0;
        final labelFontSize = isMobile ? 12.0 : 14.5;
        final inputVerticalPad = isMobile ? 9.0 : 18.0;
        final buttonPaddingV = isMobile ? 13.0 : 18.0;
        final buttonFontSize = isMobile ? 13.5 : 16.0;

        return Container(
          color: colorScheme.surface,
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: boxPaddingV,
            horizontal: boxPaddingH,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: isMobile ? 400 : 750),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Section Title ---
                  Text(
                    "Get in Touch",
                    style:
                        textTheme.headlineMedium?.copyWith(
                          fontSize: headingSize,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          letterSpacing: -1.2,
                        ) ??
                        TextStyle(
                          fontSize: headingSize,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          letterSpacing: -1.2,
                        ),
                  ),
                  SizedBox(height: isMobile ? 10 : 18),
                  RichText(
                    text: TextSpan(
                      style:
                          textTheme.bodyMedium?.copyWith(
                            fontSize: descriptionSize,
                            color: colorScheme.onSurface.withOpacity(0.7),
                            height: 1.55,
                          ) ??
                          TextStyle(
                            fontSize: descriptionSize,
                            color: colorScheme.onSurface.withOpacity(0.7),
                            height: 1.55,
                          ),
                      children: [
                        TextSpan(
                          text:
                              "I'd love to hear from you — whether it's a project, a question, or just to say hi! Fill out the form below or reach me directly at ",
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: GestureDetector(
                            onTap: () {
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: 'REMOVED_EMAIL',
                              );
                              launchUrl(emailLaunchUri);
                            },
                            child: Text(
                              "REMOVED_EMAIL",
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontSize: emailFontSize,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                                decorationColor: colorScheme.primary,
                                decorationThickness: 0.8,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: contentSpacing),

                  // --- CONTACT FORM ---
                  Material(
                    elevation: isDark ? 2 : 0,
                    borderRadius: BorderRadius.circular(14),
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
                            // Name Field
                            TextFormField(
                              controller: _nameCtrl,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: labelFontSize + 1,
                                color: colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: textTheme.labelMedium?.copyWith(
                                  fontSize: labelFontSize,
                                  color: colorScheme.onSurface.withOpacity(0.7),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.error,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.error,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: colorScheme.surface,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: inputVerticalPad,
                                  horizontal: 12,
                                ),
                              ),
                              validator: _validateName,
                              onChanged: (v) => setState(() {}),
                            ),
                            SizedBox(height: isMobile ? 14 : 22),
                            // Email Field
                            TextFormField(
                              controller: _emailCtrl,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: labelFontSize + 1,
                                color: colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: textTheme.labelMedium?.copyWith(
                                  fontSize: labelFontSize,
                                  color: colorScheme.onSurface.withOpacity(0.7),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.error,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.error,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: colorScheme.surface,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: inputVerticalPad,
                                  horizontal: 12,
                                ),
                              ),
                              validator: _validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (v) => setState(() {}),
                            ),
                            SizedBox(height: isMobile ? 14 : 22),
                            // Message Field
                            TextFormField(
                              controller: _messageCtrl,
                              maxLines: 4,
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: labelFontSize + 1,
                                color: colorScheme.onSurface,
                              ),
                              decoration: InputDecoration(
                                labelText: "Your Message",
                                labelStyle: textTheme.labelMedium?.copyWith(
                                  fontSize: labelFontSize,
                                  color: colorScheme.onSurface.withOpacity(0.7),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.primary,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.error,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: colorScheme.error,
                                    width: 2,
                                  ),
                                ),
                                filled: true,
                                fillColor: colorScheme.surface,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: inputVerticalPad,
                                  horizontal: 12,
                                ),
                              ),
                              validator: _validateMessage,
                              onChanged: (v) => setState(() {}),
                            ),
                            SizedBox(height: isMobile ? 20 : 32),
                            ElevatedButton.icon(
                              onPressed: _isFormValid && !_isSending
                                  ? _submitForm
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                foregroundColor: colorScheme.onPrimary,
                                disabledBackgroundColor: colorScheme.onSurface
                                    .withOpacity(0.12),
                                disabledForegroundColor: colorScheme.onSurface
                                    .withOpacity(0.38),
                                padding: EdgeInsets.symmetric(
                                  vertical: buttonPaddingV,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: isDark ? 1 : 2,
                                shadowColor: colorScheme.shadow.withOpacity(
                                  0.3,
                                ),
                              ),
                              icon: _isSending
                                  ? SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: colorScheme.onPrimary,
                                        strokeWidth: 2.1,
                                      ),
                                    )
                                  : Icon(
                                      Icons.send_rounded,
                                      color: colorScheme.onPrimary,
                                    ),
                              label: Text(
                                _isSending ? 'Sending...' : 'Send Message',
                                style:
                                    textTheme.labelLarge?.copyWith(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: buttonFontSize,
                                    ) ??
                                    TextStyle(
                                      color: colorScheme.onPrimary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: buttonFontSize,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 34),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
