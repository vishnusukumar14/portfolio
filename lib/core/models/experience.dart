class Experience {
  final String title;
  final String company;
  final String companyProfileUrl;
  final String duration;
  final String location;
  final String? companyLogoUrl;
  final List<String> highlights;
  final List<String> techStack;

  Experience({
    required this.title,
    required this.company,
    required this.duration,
    required this.companyProfileUrl,
    required this.location,
    required this.highlights,
    required this.techStack,
    this.companyLogoUrl,
  });
}
