class PdsList {
  final String name;
  final String email;

  PdsList(this.name, this.email);

  PdsList.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
