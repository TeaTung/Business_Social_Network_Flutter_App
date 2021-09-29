class Education {
  String id;
  String uid;
  String title;
  DateTime issueYear;
  String organization;

  DateTime? expirationYear;
  String? credentialUrl;
  String? credentialProviderAvtUrl;
  String? description;
  String? organizationUid;

  Education({
    required this.organization,
    required this.id,
    required this.uid,
    required this.title,
    required this.issueYear,
    this.description,
    this.credentialProviderAvtUrl,
    this.expirationYear,
    this.credentialUrl,
    this.organizationUid,
  });
}
