import 'package:equatable/equatable.dart';
import 'package:folio/domain/entities/app_language.dart';

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
    this.periodEn,
    this.descriptionEn,
    this.current = false,
  });

  final String role;
  final String company;
  final String period;
  final String description;
  final String? periodEn;
  final String? descriptionEn;
  final bool current;

  String periodIn(AppLanguage language) =>
      language.isEnglish ? periodEn ?? period : period;

  String descriptionIn(AppLanguage language) =>
      language.isEnglish ? descriptionEn ?? description : description;

  @override
  List<Object?> get props => [
    role,
    company,
    period,
    description,
    periodEn,
    descriptionEn,
    current,
  ];
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
    this.periodEn,
  });

  final String role;
  final String organization;
  final String period;
  final String? periodEn;

  String periodIn(AppLanguage language) =>
      language.isEnglish ? periodEn ?? period : period;

  @override
  List<Object?> get props => [role, organization, period, periodEn];
}

class Principle extends Equatable {
  const Principle({
    required this.title,
    required this.description,
    this.titleEn,
    this.descriptionEn,
  });

  final String title;
  final String description;
  final String? titleEn;
  final String? descriptionEn;

  String titleIn(AppLanguage language) =>
      language.isEnglish ? titleEn ?? title : title;

  String descriptionIn(AppLanguage language) =>
      language.isEnglish ? descriptionEn ?? description : description;

  @override
  List<Object?> get props => [title, description, titleEn, descriptionEn];
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
    this.taglineEn,
    this.bioEn,
    this.availabilityEn,
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
  final String? taglineEn;
  final String? bioEn;
  final String? availabilityEn;
  final int yearsExperience;
  final int projectCount;
  final int collaborationCount;
  final List<SocialLink> socials;
  final List<SkillGroup> skillGroups;
  final List<ExperienceItem> experience;
  final List<EducationItem> education;
  final List<OrganizationItem> organizations;
  final List<Principle> principles;

  String taglineIn(AppLanguage language) =>
      language.isEnglish ? taglineEn ?? tagline : tagline;

  String bioIn(AppLanguage language) => language.isEnglish ? bioEn ?? bio : bio;

  String availabilityIn(AppLanguage language) =>
      language.isEnglish ? availabilityEn ?? availability : availability;

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
    taglineEn,
    bioEn,
    availabilityEn,
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
