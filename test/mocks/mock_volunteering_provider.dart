import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_charity_app/models/availability.dart';
import 'package:mobile_charity_app/providers/user_provider.dart';
import 'package:mobile_charity_app/models/volunteering.dart';
import 'package:mobile_charity_app/providers/volunteering_provider.dart';

class MockVolunteeringProvider extends ChangeNotifier
    implements VolunteeringProvider {
  @override
  bool isFetchingVolunteerings = false;
  @override
  bool isApplyingToVolunteering = false;

  @override
  Future<void> abandonCurrentVolunteering() {
    return Future.value();
  }

  @override
  Future<void> applyToVolunteering(String volunteeringId) {
    return Future.value();
  }

  @override
  Future<void> fetchVolunteerings() {
    return Future.value();
  }

  @override
  VolunteeringModel? getVolunteeringById(String id) {
    return _volunteerings.first;
  }

  @override
  List<VolunteeringModel> searchVolunteeringsByTitle(String query) {
    return _volunteerings;
  }

  @override
  VolunteeringProvider update(UserProvider userProvider) {
    return this;
  }

  @override
  List<VolunteeringModel>? get volunteerings => _volunteerings;

  final List<VolunteeringModel> _volunteerings = [
    VolunteeringModel(
        id: '1',
        title: 'Un Techo para mi País',
        description:
            'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
        imageURL: 'https://via.placeholder.com/150',
        category: "Acción Social",
        about:
            'Un Techo para mi País es una organización latinoamericana que busca superar la situación de pobreza que viven miles de personas en los asentamientos precarios, a través de la acción conjunta de sus habitantes y jóvenes voluntarios y voluntarias. Para esto, trabajamos en la construcción de viviendas de emergencia, la ejecución de programas de educación y trabajo, y la incidencia en políticas públicas.',
        address: "Cabildo 600",
        requirements: [
          "Ser mayor de 18 años",
          "Tener disponibilidad para participar de la actividad",
          "Tener ganas de ayudar",
        ],
        availability: [
          const Availability(dayOfWeek: 1, startHour: 12, endHour: 13)
        ],
        vacancies: 5,
        createdAt: DateTime.now(),
        volunteersIds: ["1"],
        location: const GeoPoint(1, 1)),
    VolunteeringModel(
        id: "2",
        title: "Cruz Roja Argentina",
        description:
            "A dos horas al sur de Vicente López en la ciudad de Buenos Aires.",
        imageURL: "https://via.placeholder.com/150",
        category: "Acción Social",
        about: "ASDASDASDA",
        address: "Cabildo 600",
        requirements: [
          "Ser mayor de 18 años",
          "Tener disponibilidad para participar de la actividad",
          "Tener ganas de ayudar",
        ],
        availability: [
          const Availability(dayOfWeek: 1, startHour: 12, endHour: 13)
        ],
        vacancies: 5,
        createdAt: DateTime.now(),
        volunteersIds: ["2"],
        location: const GeoPoint(1, 1)),
    VolunteeringModel(
        id: "3",
        title: "Cruz Roja Argentina",
        description:
            "A dos horas al sur de Vicente López en la ciudad de Buenos Aires.",
        imageURL: "https://via.placeholder.com/150",
        category: "Acción Social",
        about: "ASDASDASDA",
        address: "Cabildo 600",
        requirements: [
          "Ser mayor de 18 años",
          "Tener disponibilidad para participar de la actividad",
          "Tener ganas de ayudar",
        ],
        availability: [
          const Availability(dayOfWeek: 1, startHour: 12, endHour: 13)
        ],
        vacancies: 5,
        createdAt: DateTime.now(),
        volunteersIds: [],
        location: const GeoPoint(1, 1)),
    VolunteeringModel(
        id: "4",
        title: "Cruz Roja Argentina",
        description:
            "A dos horas al sur de Vicente López en la ciudad de Buenos Aires.",
        imageURL: "https://via.placeholder.com/150",
        category: "Acción Social",
        about: "ASDASDASDA",
        address: "Cabildo 600",
        requirements: [
          "Ser mayor de 18 años",
          "Tener disponibilidad para participar de la actividad",
          "Tener ganas de ayudar",
        ],
        availability: [
          const Availability(dayOfWeek: 1, startHour: 12, endHour: 13)
        ],
        vacancies: 5,
        createdAt: DateTime.now(),
        volunteersIds: [],
        location: const GeoPoint(1, 1))
  ];
}
