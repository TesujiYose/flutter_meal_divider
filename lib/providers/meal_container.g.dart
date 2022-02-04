// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_container.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealContainerAdapter extends TypeAdapter<MealContainer> {
  @override
  final int typeId = 1;

  @override
  MealContainer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealContainer(
      id: fields[0] as String,
      name: fields[1] as String,
      scheduledTime: fields[2] as TimeOfDay,
      storage: (fields[3] as List).cast<Meal>(),
      color: fields[4] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, MealContainer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.scheduledTime)
      ..writeByte(3)
      ..write(obj.storage)
      ..writeByte(4)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealContainerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
