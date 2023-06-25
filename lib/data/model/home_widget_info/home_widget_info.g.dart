// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_widget_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HomeWidgetInfoAdapter extends TypeAdapter<HomeWidgetInfo> {
  @override
  final int typeId = 5;

  @override
  HomeWidgetInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HomeWidgetInfo(
      postId: fields[0] as int,
      homeWidgetText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HomeWidgetInfo obj) {
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
      other is HomeWidgetInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
