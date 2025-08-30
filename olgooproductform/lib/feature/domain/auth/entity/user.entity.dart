import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final DateTime? registerDate;
  final DateTime? updatedAt;
  final String? status;
  final List<dynamic>? role;
  final String? refToken;
  final String? accToken;
  //final CompanyEntity? company;

  const UserEntity({
    this.id,
    this.name,
    this.phone,
    this.status,
    this.registerDate,
    this.updatedAt,
    this.role,
    this.refToken,
    this.accToken,
   // this.company,
  });

  @override
  List<Object?> get props => [id, name, phone, role, status, refToken];

  factory UserEntity.fromJson(dynamic json) {
    return UserEntity(
      id: json['id'],
      name: json['name'],
      phone: json['phoneNumber'],
      status: json['status'],
      registerDate: DateTime.parse(json['registerDate']),
      updatedAt: DateTime.parse(
        json['updatedAt'],
      ),
      role: json['role'],
      refToken: json['tokens']["refresh_token"],
      accToken: json['tokens']["access_token"],
      //company: CompanyEntity.fromJson(json['company']),
    );
  }
  factory UserEntity.fromJsonWithOutTokens(dynamic json) {
    return UserEntity(
        id: json['id'],
        name: json['name'],
        phone: json['phoneNumber'],
        status: json['status'],
        registerDate: DateTime.parse(json['registerDate']),
        updatedAt: DateTime.parse(
          json['updatedAt'],
        ),
        role: json['role']);
       // company: CompanyEntity.fromJson(json["company"]));
  }
}
