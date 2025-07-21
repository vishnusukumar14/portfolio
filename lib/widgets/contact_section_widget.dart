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
      // Default: show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Thank you, $name! Your message has been sent.'),
          backgroundColor: Colors.green[700],
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
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Section Title ---
              Text(
                "Get in Touch",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: -1.2,
                ),
              ),
              SizedBox(height: 18),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
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
                          // This will launch the default email client
                          final Uri emailLaunchUri = Uri(
                            scheme: 'mailto',
                            path: 'REMOVED_EMAIL',
                          );
                          launchUrl(emailLaunchUri);
                        },
                        child: Text(
                          "REMOVED_EMAIL",
                          style: TextStyle(
                            color: Color(0xFFA70F0F),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.4,
                            decorationColor: Color(0xFFA70F0F),
                            decorationThickness: 0.8,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 36),

              // --- CONTACT FORM ---
              Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
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
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFFA70F0F),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: _validateName,
                          onChanged: (v) => setState(() {}),
                        ),
                        SizedBox(height: 22),
                        // Email Field
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFFA70F0F),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (v) => setState(() {}),
                        ),
                        SizedBox(height: 22),
                        // Message Field
                        TextFormField(
                          controller: _messageCtrl,
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: "Your Message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Color(0xFFA70F0F),
                                width: 2,
                              ),
                            ),
                          ),
                          validator: _validateMessage,
                          onChanged: (v) => setState(() {}),
                        ),
                        SizedBox(height: 32),
                        ElevatedButton.icon(
                          onPressed: _isFormValid && !_isSending
                              ? _submitForm
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                            foregroundColor: Colors.white,
                          ),
                          icon: _isSending
                              ? SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.4,
                                  ),
                                )
                              : Icon(Icons.send_rounded, color: Colors.white),
                          label: Text(
                            _isSending ? 'Sending...' : 'Send Message',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 34),
            ],
          ),
        ),
      ),
    );
  }
}
