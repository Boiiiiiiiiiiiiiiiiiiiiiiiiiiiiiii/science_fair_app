// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debt.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DebtAdapter extends TypeAdapter<Debt> {
  @override
  final int typeId = 1;

  @override
  Debt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Debt(
      name: fields[0] as String,
      sum: fields[1] as int,
      percent: fields[2] as int,
      months: fields[3] as int,
      type: fields[4] as DebtType,
      monthlyPayment: fields[5] as int,
      overpay: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Debt obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.sum)
      ..writeByte(2)
      ..write(obj.percent)
      ..writeByte(3)
      ..write(obj.months)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.monthlyPayment)
      ..writeByte(6)
      ..write(obj.overpay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DebtTypeAdapter extends TypeAdapter<DebtType> {
  @override
  final int typeId = 0;

  @override
  DebtType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DebtType.annuity;
      case 1:
        return DebtType.diferentional;
      default:
        return DebtType.annuity;
    }
  }

  @override
  void write(BinaryWriter writer, DebtType obj) {
    switch (obj) {
      case DebtType.annuity:
        writer.writeByte(0);
        break;
      case DebtType.diferentional:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DebtTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
