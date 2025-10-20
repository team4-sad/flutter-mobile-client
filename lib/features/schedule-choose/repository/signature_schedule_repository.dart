import 'package:hive/hive.dart';
import 'package:miigaik/features/schedule-choose/models/signature_schedule_model.dart';

abstract class ISignatureScheduleRepository {
  Future<void> add(SignatureScheduleModel model);
  Future<void> remove(SignatureScheduleModel model);
  Future<void> select(SignatureScheduleModel selectedModel);
  Future<void> unSelect();
  Future<SignatureScheduleModel?> getSelected();
  Future<List<SignatureScheduleModel>> fetchAll();
}

class SignatureScheduleRepository extends ISignatureScheduleRepository {

  final Box<SignatureScheduleModel> _box;

  static const _selectKey = "select-signature-schedule";

  SignatureScheduleRepository({
    required Box<SignatureScheduleModel> box
  }) : _box = box;

  @override
  Future<void> add(SignatureScheduleModel model) async {
    await _box.add(model);
  }

  @override
  Future<void> remove(SignatureScheduleModel model) async {
    await model.delete();
  }

  @override
  Future<void> select(SignatureScheduleModel selectedModel) async {
    await _box.put(_selectKey, selectedModel.copy());
  }

  @override
  Future<SignatureScheduleModel?> getSelected() async {
    return _box.get(_selectKey);
  }

  @override
  Future<List<SignatureScheduleModel>> fetchAll() async {
    final selected = await getSelected();
    return _box.values.toList()..remove(selected);
  }

  @override
  Future<void> unSelect() async {
    return _box.delete(_selectKey);
  }
}