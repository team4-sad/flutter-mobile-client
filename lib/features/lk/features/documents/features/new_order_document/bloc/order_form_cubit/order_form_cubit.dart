import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:miigaik/features/lk/features/documents/models/document_form_field.dart';
import 'package:miigaik/features/lk/features/documents/models/document_form_model.dart';

part 'order_form_state.dart';

class OrderFormCubit extends Cubit<OrderFormState> {
  OrderFormCubit(DocumentFormModel form) : super(OrderFormState(form: form, values: {}));
  
  void fillFieldByLabel(String newValue, String labelField) {
    emit(state.fillValue(labelField, newValue));
  }
}
