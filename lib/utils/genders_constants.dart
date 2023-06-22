import 'dart:collection';

Map<String, int> genderIdByName = HashMap.from({
  "Hombre": 0,
  "Mujer": 2,
  "No binario": 3,
});

Map<int, String> genderStrById =
    HashMap.from({0: "Hombre", 2: "Mujer", 3: "No binario"});
