class Experience {
  final String title;
  final String company;
  final String? companyProfileUrl;
  final String duration;
  final String? location;
  final List<String> highlights;
  final List<String> techStack;
  final Map<String, String>? techStackUrls; // New field for custom tech URLs

  const Experience({
    required this.title,
    required this.company,
    this.companyProfileUrl,
    required this.duration,
    this.location,
    required this.highlights,
    required this.techStack,
    this.techStackUrls, // Optional map of tech name to URL
  });

  // Copy constructor for easy updates
  Experience copyWith({
    String? title,
    String? company,
    String? companyProfileUrl,
    String? duration,
    String? location,
    List<String>? highlights,
    List<String>? techStack,
    Map<String, String>? techStackUrls,
  }) {
    return Experience(
      title: title ?? this.title,
      company: company ?? this.company,
      companyProfileUrl: companyProfileUrl ?? this.companyProfileUrl,
      duration: duration ?? this.duration,
      location: location ?? this.location,
      highlights: highlights ?? this.highlights,
      techStack: techStack ?? this.techStack,
      techStackUrls: techStackUrls ?? this.techStackUrls,
    );
  }

  // Helper method to get URL for a tech stack item
  String? getTechUrl(String tech) {
    return techStackUrls?[tech];
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'company': company,
      'companyProfileUrl': companyProfileUrl,
      'duration': duration,
      'location': location,
      'highlights': highlights,
      'techStack': techStack,
      'techStackUrls': techStackUrls,
    };
  }

  // Create from JSON
  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      title: json['title'] as String,
      company: json['company'] as String,
      companyProfileUrl: json['companyProfileUrl'] as String?,
      duration: json['duration'] as String,
      location: json['location'] as String?,
      highlights: List<String>.from(json['highlights'] as List),
      techStack: List<String>.from(json['techStack'] as List),
      techStackUrls: json['techStackUrls'] != null
          ? Map<String, String>.from(json['techStackUrls'] as Map)
          : null,
    );
  }
}
