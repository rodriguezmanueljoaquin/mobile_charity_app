import 'package:mobile_charity_app/routes/paths.dart';

enum HomeTabs {
  volunteering(pageName: SerManosPagesName.volunteering, tabText: "Postularse"),
  profile(pageName: SerManosPagesName.profile, tabText: "Mi perfil"),
  news(pageName: SerManosPagesName.news, tabText: "Novedades");

  final String pageName;
  final String tabText;

  const HomeTabs({required this.pageName, required this.tabText});
}
