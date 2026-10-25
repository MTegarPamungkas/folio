import 'package:equatable/equatable.dart';

enum SocialPlatform {
  github('GitHub'),
  linkedin('LinkedIn'),
  dribbble('Dribbble');

  const SocialPlatform(this.label);

  final String label;

  static SocialPlatform? fromName(String? name) {
    for (final platform in values) {
      if (platform.name == name) return platform;
    }
    return null;
  }
}

class SocialLink extends Equatable {
  const SocialLink({
    required this.platform,
    required this.handle,
    required this.url,
  });

  final SocialPlatform platform;
  final String handle;
  final String url;

  String get label => platform.label;

  @override
  List<Object?> get props => [platform, handle, url];
}

enum SkillGroupKind {
  fullStack('Full Stack'),
  mobile('Mobile'),
  architecture('Arsitektur'),
  design('Desain'),
  backend('Backend'),
  product('Produk & Operasi');

  const SkillGroupKind(this.title);

  final String title;

  static SkillGroupKind? fromName(String? name) {
    for (final kind in values) {
      if (kind.name == name) return kind;
    }
    return null;
  }
}

class SkillGroup extends Equatable {
  const SkillGroup({required this.kind, required this.skills});

  final SkillGroupKind kind;
  final List<String> skills;

  String get title => kind.title;

  @override
  List<Object?> get props => [kind, skills];
}

class ExperienceItem extends Equatable {
  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    this.current = false,
  });

  final String role;
  final String company;
  final String period;
  final String description;
  final bool current;

  @override
  List<Object?> get props => [role, company, period, description, current];
}

class EducationItem extends Equatable {
  const EducationItem({
    required this.degree,
    required this.institution,
    required this.period,
    required this.location,
  });

  final String degree;
  final String institution;
  final String period;
  final String location;

  @override
  List<Object?> get props => [degree, institution, period, location];
}

class OrganizationItem extends Equatable {
  const OrganizationItem({
    required this.role,
    required this.organization,
    required this.period,
  });

  final String role;
  final String organization;
  final String period;

  @override
  List<Object?> get props => [role, organization, period];
}

class Principle extends Equatable {
  const Principle({required this.title, required this.description});

  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];
}

class Developer extends Equatable {
  const Developer({
    required this.name,
    required this.shortName,
    required this.initials,
    required this.role,
    required this.tagline,
    required this.bio,
    required this.location,
    required this.timezone,
    required this.email,
    required this.phone,
    required this.availability,
    required this.yearsExperience,
    required this.projectCount,
    required this.collaborationCount,
    required this.socials,
    required this.skillGroups,
    required this.experience,
    required this.education,
    required this.organizations,
    required this.principles,
  });

  final String name;
  final String shortName;
  final String initials;
  final String role;
  final String tagline;
  final String bio;
  final String location;
  final String timezone;
  final String email;
  final String phone;
  final String availability;
  final int yearsExperience;
  final int projectCount;
  final int collaborationCount;
  final List<SocialLink> socials;
  final List<SkillGroup> skillGroups;
  final List<ExperienceItem> experience;
  final List<EducationItem> education;
  final List<OrganizationItem> organizations;
  final List<Principle> principles;

  @override
  List<Object?> get props => [
    name,
    shortName,
    initials,
    role,
    tagline,
    bio,
    location,
    timezone,
    email,
    phone,
    availability,
    yearsExperience,
    projectCount,
    collaborationCount,
    socials,
    skillGroups,
    experience,
    education,
    organizations,
    principles,
  ];
}
