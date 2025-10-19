// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_schedule_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignatureScheduleTypeAdapter extends TypeAdapter<SignatureScheduleType> {
  @override
  final int typeId = 1;

  @override
  SignatureScheduleType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SignatureScheduleType.group;
      case 1:
        return SignatureScheduleType.audience;
      case 2:
        return SignatureScheduleType.teacher;
      default:
        return SignatureScheduleType.group;
    }
  }

  @override
  void write(BinaryWriter writer, SignatureScheduleType obj) {
    switch (obj) {
      case SignatureScheduleType.group:
        writer.writeByte(0);
        break;
      case SignatureScheduleType.audience:
        writer.writeByte(1);
        break;
      case SignatureScheduleType.teacher:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignatureScheduleTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
