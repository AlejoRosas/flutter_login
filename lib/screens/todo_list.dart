import 'package:flutter/material.dart';
import 'package:login/widgets/navbar.dart';

import '../services/todo_service.dart';
import '../utils/snackbar_helper.dart';
import '../widgets/todo_card.dart';
import 'add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyNavBar(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 61, 70),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        centerTitle: true,
        title: const Text('Locations'),
      ),
      body: Visibility(
        visible: isLoading,
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No task for now',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return TodoCard(
                    index: index,
                    item: item,
                    navigateEdit: navigateToEditPage,
                    deleteTodo: deleteById);
              },
            ),
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add Todo'),
      ),
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route = MaterialPageRoute(
      builder: (context) => AddTodoPage(location: item),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  void navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    // Delete the item
    final isSuccess = await TodoService.deleteById(id);

    if (isSuccess) {
      fetchTodo();
      // ignore: use_build_context_synchronously
      showSuccessMessage(context, message: 'Element deleted successfully');
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Failed to delete element');
    }
  }

  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodos();

    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Fetch Failed');
    }

    setState(() {
      isLoading = false;
    });
  }
}
