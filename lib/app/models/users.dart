class UserD {
  bool? approved;
  String? name;
  final String? email;
  final String? id;

  UserD({
    this.approved,
    this.name,
    this.email,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'approved': approved,
      'name': name,
      'email': email,
      'uid': id,
    };
  }

  static UserD fromJson(Map<String, dynamic> json) => UserD(
        id: json['uid'],
        approved: json['approved'],
        email: json['email'],
      );
}
