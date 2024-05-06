import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? location;
  const AddTodoPage({
    super.key,
    this.location,
  });

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    final location = widget.location;
    if (location != null) {
      isEdit = true;
      final name = location['nombre'];
      final value = location['valor'].toString();
      nameController.text = name;
      valueController.text = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 61, 70),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: Text(
          isEdit ? 'Edit Location' : 'Add Location',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Name',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: valueController,
            decoration: const InputDecoration(
              hintText: 'Value',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isEdit ? updateData : submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(isEdit ? 'Update' : 'Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final location = widget.location;

    if (location == null) {
      showErrorMessage(context, message: 'No data to edit');
      return;
    }

    final isSuccess = await TodoService.updateTodo(body);
    if (isSuccess) {
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Edit Success');
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Edit Failed');
    }
  }

  Future<void> submitData() async {
    // Get data from the server

    // Submit data to the server
    final isSuccess = await TodoService.addTodo(body);

    // show succes or fail message
    if (isSuccess) {
      nameController.text = '';
      valueController.text = '';
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Creation Success');
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Creation Failed');
    }
  }

  Map get body {
    final location = widget.location;
    final id = location?['id'];
    final name = nameController.text;
    final value = valueController.text;

    if (isEdit) {
      //Body para editar
      return {
        "nombre": name,
        "valor": value,
        "id": id,
        "activo": true,
        "version": 0
      };
    } else {
      //Body para crear
      return {
        "nombre": name,
        "valor": value,
      };
    }
  }
}
