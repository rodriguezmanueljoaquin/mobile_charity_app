// map that pairs number to day of the week
import 'package:mobile_charity_app/models/availability.dart';

const Map<int, String> dayOfWeekToStr = {
  0: 'Domingo',
  1: 'Lunes',
  2: 'Martes',
  3: 'Miércoles',
  4: 'Jueves',
  5: 'Viernes',
  6: 'Sábado',
};

String availabilityToStr(Availability availability) {
  return '${dayOfWeekToStr[availability.dayOfWeek]} de ${availability.startHour}h a ${availability.endHour}h';
}

String availabilitiesToMarkdown(List<Availability> availabilities) {
  return availabilities
      .map((availability) => '+ ${availabilityToStr(availability)}')
      .join('\n');
}
