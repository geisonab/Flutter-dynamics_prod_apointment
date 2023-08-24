import 'adaptative_button.dart';
import 'package:flutter/material.dart';
import 'adaptative_text_field.dart';
import 'adaptative_date_picker.dart';

class ApointmentForm extends StatefulWidget {
  const ApointmentForm(this.onSubmit, {super.key});

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<ApointmentForm> createState() => _ApointmentFormState();
}

class _ApointmentFormState extends State<ApointmentForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _dateChanged(DateTime value) {
    setState(() {
      _selectedDate = value;
    });
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) return;

    widget.onSubmit(title, value, _selectedDate as DateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 10.0,
            bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                labelText: 'Título',
                onSubmitted: (_) => _submitForm(),
                controller: _titleController,
              ),
              AdaptativeTextField(
                inputType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (_) => _submitForm(),
                labelText: 'Valor R\$',
                controller: _valueController,
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: _dateChanged,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: /*ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text(
                        'Nova transação',
                      ),
                    ),*/
                        AdaptativeButton(
                      label: 'Nova transação',
                      onPressedLocal: _submitForm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
