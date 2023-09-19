import 'package:equatable/equatable.dart';

class Doctors extends Equatable {
  final String? id;
  final String? name;
  final String? fee;
  final String? location;
  final String? bio;
  final String? phote;
  final String? number;

  final String? email;
  final String? password;
  const Doctors({
    this.fee = '',
    this.location = '',
    this.bio = '',
    this.id = '',
    this.number = '',
    this.name = '',
    this.phote =
        'https://img.freepik.com/free-vector/hand-drawn-collage-design_23-2149543516.jpg?w=1380&t=st=1686559872~exp=1686560472~hmac=99dc9fa8db0d61d7cb832f35e76bfe3caf0590bbf2d292cf89fef64a283b0a35,',
    this.email = '',
    this.password = '',
  });

  factory Doctors.fromJson(Map<String, dynamic> json) {
    return Doctors(
      id: json['id'],
      name: json['name'],
      fee: json['fee'],
      phote: json['phote'],
      bio: json['bio'],
      location: json['location'],
      number: json['number'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'fee': fee,
      'bio': bio,
      'phote': phote,
      'location': location,
      'password': password,
      'email': email,
    };
  }

  @override
  List<Object> get props => [
        id ?? "",
        name ?? '',
        fee ?? '',
        number ?? '',
        phote ?? '',
        bio ?? '',
        email ?? '',
        password ?? '',
        location ?? '',
      ];
}
