// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WidgetSettingsAdapter extends TypeAdapter<WidgetSettings> {
  @override
  final int typeId = 3;

  @override
  WidgetSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WidgetSettings(
      isTextChangeHourly: fields[0] as bool,
      isTextChangeHour: fields[1] as int,
      fontColor: fields[2] as String,
      backgroundColor: fields[3] as String,
      fontFamily: fields[4] as String,
      fontSize: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WidgetSettings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isTextChangeHourly)
      ..writeByte(1)
      ..write(obj.isTextChangeHour)
      ..writeByte(2)
      ..write(obj.fontColor)
      ..writeByte(3)
      ..write(obj.backgroundColor)
      ..writeByte(4)
      ..write(obj.fontFamily)
      ..writeByte(5)
      ..write(obj.fontSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
