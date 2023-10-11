// To parse this JSON data, do
//
//     final bankHoliday = bankHolidayFromJson(jsonString);

import 'dart:convert';

BankHoliday bankHolidayFromJson(String str) => BankHoliday.fromJson(json.decode(str));

String bankHolidayToJson(BankHoliday data) => json.encode(data.toJson());

class BankHoliday {
    EnglandAndWales englandAndWales;
    EnglandAndWales scotland;
    EnglandAndWales northernIreland;

    BankHoliday({
        required this.englandAndWales,
        required this.scotland,
        required this.northernIreland,
    });

    factory BankHoliday.fromJson(Map<String, dynamic> json) => BankHoliday(
        englandAndWales: EnglandAndWales.fromJson(json["england-and-wales"]),
        scotland: EnglandAndWales.fromJson(json["scotland"]),
        northernIreland: EnglandAndWales.fromJson(json["northern-ireland"]),
    );

    Map<String, dynamic> toJson() => {
        "england-and-wales": englandAndWales.toJson(),
        "scotland": scotland.toJson(),
        "northern-ireland": northernIreland.toJson(),
    };
}

class EnglandAndWales {
    String division;
    List<Event> events;

    EnglandAndWales({
        required this.division,
        required this.events,
    });

    factory EnglandAndWales.fromJson(Map<String, dynamic> json) => EnglandAndWales(
        division: json["division"],
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "division": division,
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
    };
}

class Event {
    String title;
    DateTime date;
    Notes notes;
    bool bunting;

    Event({
        required this.title,
        required this.date,
        required this.notes,
        required this.bunting,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        title: json["title"],
        date: DateTime.parse(json["date"]),
        notes: notesValues.map[json["notes"]]!,
        bunting: json["bunting"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "notes": notesValues.reverse[notes],
        "bunting": bunting,
    };
}

enum Notes {
    EMPTY,
    SUBSTITUTE_DAY
}

final notesValues = EnumValues({
    "": Notes.EMPTY,
    "Substitute day": Notes.SUBSTITUTE_DAY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
