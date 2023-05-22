import 'package:flutter/material.dart';
import 'models.dart';

typedef OnAddPill = void Function(Pill pill);

class PillInput extends StatefulWidget {
  final OnAddPill onAddPill;

  PillInput({Key? key, required this.onAddPill}) : super(key: key);

  @override
  _PillInputState createState() => _PillInputState();
}

class _PillInputState extends State<PillInput> {
  final _formKey = GlobalKey<FormState>();
  String _pillName = '';
  TimeOfDay _pillTime = TimeOfDay.now();
  int _pillFrequency = 0;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _pillTime,
    );

    if (pickedTime != null && pickedTime != _pillTime) {
      setState(() {
        _pillTime = pickedTime;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      widget.onAddPill(Pill(
        name: _pillName,
        time: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, _pillTime.hour, _pillTime.minute),
        frequency: _pillFrequency,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pill added')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Pill Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a pill name';
                }
                return null;
              },
              onSaved: (value) => _pillName = value!,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: TextEditingController(
                      text: _pillTime.format(context)),
                  decoration: const InputDecoration(labelText: 'Pill Time'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Frequency (in hours)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a pill frequency';
                }
                return null;
              },
              onSaved: (value) => _pillFrequency = int.parse(value!),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Pill'),
            ),
          ],
        ),
      ),
    );
  }
}
