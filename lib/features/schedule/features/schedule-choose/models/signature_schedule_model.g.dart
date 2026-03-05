// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_schedule_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignatureScheduleModelAdapter
    extends TypeAdapter<SignatureScheduleModel> {
  @override
  final int typeId = 0;

  @override
  SignatureScheduleModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignatureScheduleModel(
      type: fields[0] as SignatureScheduleType,
      title: fields[1] as String,
      id: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignatureScheduleModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignatureScheduleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
