import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const VolunteerForm());
}

class VolunteerForm extends StatelessWidget {
  const VolunteerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NotificationForm(),
    );
  }
}

class NotificationForm extends StatefulWidget {
  const NotificationForm({super.key});

  @override
  _NotificationFormState createState() => _NotificationFormState();
}

class _NotificationFormState extends State<NotificationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _messageContent;
  DateTime? _sendDate;
  String? _deliveryMethod;
  String? _notificationType;
  String? _status;

  final List<String> _deliveryMethods = ['SMS', 'Email'];
  final List<String> _notificationTypes = ['Reminder', 'Warning'];
  final List<String> _statuses = ['Active', 'Idle'];

  final DateTime _subscriptionEndDate = DateTime(2024, 12, 31);

  void _selectSendDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _sendDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _sendDate) {
      setState(() {
        _sendDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showSuccessDialog(); // Show success dialog
    } else {
      _showErrorDialog(); // Show error dialog if validation fails
    }
  }

  // Show success dialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Your notification has been successfully saved!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Show error dialog
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('There was an error saving the notification. Please check your inputs.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String? _validateMessageContent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Message Content';
    }
    if (value.length > 200) {
      return 'Message content is too long, Maximum length is 200 characters.';
    }
    return null;
  }

  String? _validateSendDate() {
    if (_sendDate == null) {
      return 'Please select a send date';
    }
    if (_sendDate!.isBefore(DateTime.now()) &&
        _sendDate!.isBefore(_subscriptionEndDate)) {
      return 'Send date must be within the notification period before the subscription ends';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Notifications'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Message Content'),
                validator: _validateMessageContent,
                onSaved: (value) {
                  _messageContent = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Send Date',
                  hintText: 'Select date',
                ),
                readOnly: true,
                onTap: () => _selectSendDate(context),
                validator: (value) => _validateSendDate(),
                controller: TextEditingController(
                  text: _sendDate != null
                      ? DateFormat('yyyy-MM-dd').format(_sendDate!)
                      : '',
                ),
              ),
              const SizedBox(height: 20),
              const Text('Delivery Method'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _deliveryMethods.map((method) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: method,
                        groupValue: _deliveryMethod,
                        onChanged: (value) {
                          setState(() {
                            _deliveryMethod = value;
                          });
                        },
                      ),
                      Text(method),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Notification Type'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _notificationTypes.map((type) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: type,
                        groupValue: _notificationType,
                        onChanged: (value) {
                          setState(() {
                            _notificationType = value;
                          });
                        },
                      ),
                      Text(type),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text('Status'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _statuses.map((status) {
                  return Row(
                    children: [
                      Radio<String>(
                        value: status,
                        groupValue: _status,
                        onChanged: (value) {
                          setState(() {
                            _status = value;
                          });
                        },
                      ),
                      Text(status),
                    ],
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}