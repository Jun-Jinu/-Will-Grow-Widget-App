import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class ColorAdapter extends TypeAdapter<Color> {
  @override
  final int typeId = 4; // 고유한 어댑터 ID

  @override
  Color read(BinaryReader reader) {
    final value = reader.readInt32();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt32(obj.value);
  }
}
