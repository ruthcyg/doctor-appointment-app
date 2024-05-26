import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class DoctorModel {
  String title;
  String fullName;
  String yearOfExperience;
  String primarySpecialization;
  String secondarySpecializations;
  List<String> conditionsTreated;
  String pmdcRegistrationNumber;
  String userId;
  Timestamp createdAt;
  Timestamp updatedAt;
  String phoneNumber;
  String email;
  String photoURL;
  String markdown;
  bool? isVerified;
  bool? isRejected;
  String? rejectionReason;
  final List<String> specialization;
  final List<String> locations;

  DoctorModel({
    required this.title,
    required this.fullName,
    required this.yearOfExperience,
    required this.primarySpecialization,
    required this.secondarySpecializations,
    required this.conditionsTreated,
    required this.pmdcRegistrationNumber,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.email,
    required this.photoURL,
    required this.markdown,
    required this.locations,
    required this.specialization,
    this.isVerified,
    this.isRejected,
    this.rejectionReason,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      title: json['title'],
      fullName: json['fullName'],
      yearOfExperience: json['yearOfExperience'],
      primarySpecialization: json['primarySpecialization'],
      secondarySpecializations: json['secondarySpecializations'],
      conditionsTreated: List<String>.from(json['conditionsTreated']),
      locations: List<String>.from(json['locations']),
      specialization: List<String>.from(json['specialization']),
      pmdcRegistrationNumber: json['pmdcRegistrationNumber'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      photoURL: json['photoURL'],
      markdown: json['markdown'],
      isVerified: json['isVerified'],
      isRejected: json['isRejected'],
      rejectionReason: json['rejectionReason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'fullName': fullName,
      'yearOfExperience': yearOfExperience,
      'primarySpecialization': primarySpecialization,
      'secondarySpecializations': secondarySpecializations,
      'conditionsTreated': conditionsTreated,
      'pmdcRegistrationNumber': pmdcRegistrationNumber,
      'userId': userId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'phone_number': phoneNumber,
      'email': email,
      'photoURL': photoURL,
      'markdown': markdown,
      'isVerified': isVerified,
      'isRejected': isRejected,
      'rejectionReason': rejectionReason,
    };
  }
}

@JsonSerializable()
class HealthProviderModel {
  late String name;
  late String id;
  late String doctorId;
  late String about;
  late String city;
  late String avatar;
  late String startTime;
  late String endTime;
  late int waitTime;
  late String googleLocLink;
  late List<String> monday;
  late List<String> tuesday;
  late List<String> wednesday;
  late List<String> thursday;
  late List<String> friday;
  late List<String> saturday;
  late List<String> sunday;
  late Timestamp createdAt;
  late Timestamp updatedAt;
  late String location;

  List<String> getTimeSlots(String day) {
    switch (day) {
      case 'Mon':
        return monday;
      case 'Tue':
        return tuesday;
      case 'Wed':
        return wednesday;
      case 'Thu':
        return thursday;
      case 'Fri':
        return friday;
      case 'Sat':
        return saturday;
      case 'Sun':
        return sunday;
      default:
        return [];
    }
  }

  HealthProviderModel({
    required this.id,
    required this.doctorId,
    required this.about,
    required this.city,
    required this.startTime,
    required this.endTime,
    required this.waitTime,
    required this.googleLocLink,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.location,
    required this.avatar,
  });

  factory HealthProviderModel.fromFirestore(Map<String, dynamic> data) {
    return HealthProviderModel(
      name: data['name'],
      location: data['location'],
      id: data['uid'],
      doctorId: data['doctor_id'],
      about: data['about'],
      city: data['city'],
      startTime: data['start_time'],
      endTime: data['end_time'],
      waitTime: data['wait_time'],
      avatar: data['avatar'],
      googleLocLink: data['googleLocLink'],
      monday: (data['monday'] as List<dynamic>).cast<String>(),
      tuesday: (data['tuesday'] as List<dynamic>).cast<String>(),
      wednesday: (data['wednesday'] as List<dynamic>).cast<String>(),
      thursday: (data['tuesday'] as List<dynamic>).cast<String>(),
      friday: (data['friday'] as List<dynamic>).cast<String>(),
      saturday: (data['saturday'] as List<dynamic>).cast<String>(),
      sunday: (data['sunday'] as List<dynamic>).cast<String>(),
      createdAt: data['created_at'] as Timestamp,
      updatedAt: data['updated_at'] as Timestamp,
    );
  }

  // Helper method to parse time string into hours and minutes
  static Map<String, int> parseTime(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return {'hours': hours, 'minutes': minutes};
  }
}

@JsonSerializable()
class AppointmentModel {
  String patientId;
  String patientName;
  String doctorId;
  String doctorDisplayName;
  String doctorAvatar;
  String healthProviderId;
  String healthProviderLocation;
  String healthProviderName;
  String healthProviderAvatar;
  String slot;
  String weekDay;
  Timestamp createdAt;
  String status;
  Timestamp appointmentDate;

  AppointmentModel({
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorDisplayName,
    required this.doctorAvatar,
    required this.healthProviderId,
    required this.healthProviderLocation,
    required this.healthProviderName,
    required this.healthProviderAvatar,
    required this.slot,
    required this.weekDay,
    required this.createdAt,
    required this.status,
    required this.appointmentDate,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      patientId: json['patient_id'],
      patientName: json['patient_name'],
      doctorId: json['doctor_id'],
      doctorDisplayName: json['doctor_display_name'],
      doctorAvatar: json['doctor_avatar'],
      healthProviderId: json['health_provider_id'],
      healthProviderLocation: json['health_provider_location'],
      healthProviderName: json['health_provider_name'],
      healthProviderAvatar: json['health_provider_avatar'],
      slot: json['slot'],
      weekDay: json['week_day'],
      createdAt: json['createdAt'] ?? Timestamp.now(),
      status: json['status'],
      appointmentDate: json['appointment_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'patient_name': patientName,
      'doctor_id': doctorId,
      'doctor_display_name': doctorDisplayName,
      'doctor_avatar': doctorAvatar,
      'health_provider_id': healthProviderId,
      'health_provider_location': healthProviderLocation,
      'health_provider_name': healthProviderName,
      'health_provider_avatar': healthProviderAvatar,
      'slot': slot,
      'week_day': weekDay,
      'created_at': createdAt,
      'status': status,
      'appointment_date': appointmentDate,
    };
  }
}
