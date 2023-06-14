// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeWidgetAdapter extends TypeAdapter<HomeWidget> {
  @override
  final int typeId = 5;

  @override
  HomeWidget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeWidget(
      postId: fields[0] as int,
      homeWidgetText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HomeWidget obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.postId)
      ..writeByte(1)
      ..write(obj.homeWidgetText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeWidgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
