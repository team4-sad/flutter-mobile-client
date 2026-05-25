part of 'order_form_cubit.dart';

class OrderFormState {
  final DocumentFormModel form;
  final Map<String, dynamic> values;

  OrderFormState({required this.form, required this.values});

  OrderFormState copyWith({
    DocumentFormModel? form,
    Map<String, dynamic>? values
  }) => OrderFormState(form: form ?? this.form, values: values ?? this.values);

  OrderFormState fillValue(String label, dynamic value) {
    return copyWith(
      values: values..update(label, value)
    );
  }

  bool isValid(){
    final requiredFields = form.fields.where((e) => e.isRequired);
    final isAllFilledRequiredFields = requiredFields.every((e) => values.containsKey(e.label));
    return isAllFilledRequiredFields;
  }
}


