import 'dart:io';
import 'task.dart';

List<Task> all_tasks = [];

void add() {
  late Task new_task = Task.create();

  new_task.ID = all_tasks.length;

  do {
    stdout.write('task title: ');
    new_task.Title = stdin.readLineSync()!;
  } while (new_task.Title == '');

  do {
    stdout.write('task description: ');
    new_task.Description = stdin.readLineSync()!;
  } while (new_task.Description == '');

  all_tasks.add(new_task);

  print('The task has been added successfully!');
  main();
}

void remove() {
  try {
    stdout.write('Please enter the ID of the task you want to remove: ');
    int task_id = int.parse(stdin.readLineSync()!);

    all_tasks.remove(all_tasks[task_id]);

    print('The task has been removed successfully!');

    main();
  } catch (e) {
    print('Please enter valid ID');
    remove();
  }
}

void update() {
  try {
    stdout.write('Please enter the ID of the task you want to update: ');
    int task_id = int.parse(stdin.readLineSync()!);

    Task the_task = all_tasks[task_id];

    stdout.write('What do you want to update (title, description, completed)?');
    String? field = stdin.readLineSync()!;

    field.toLowerCase();

    if (field == 'title') {
      do {
        stdout.write('Enter new title please: ');
        the_task.Title = stdin.readLineSync()!;
      } while (the_task.Title == '');
    } else if (field == 'description') {
      do {
        stdout.write('Enter new description please: ');
        the_task.Description = stdin.readLineSync()!;
      } while (the_task.Description == '');
    } else if (field == 'completed') {
      the_task.isCompleted = !(the_task.isCompleted);
    } else {
      print('Please select a valid field');
    }

    print('The task has been updated successfully!');
    main();
  } catch (e) {
    print('Please enter valid ID');
    update();
  }
}

void printRow(List<String> row, List<int> columnWidths) {
  for (int i = 0; i < row.length; i++) {
    String cell = row[i];
    String padding = ' ' * (columnWidths[i] - cell.length);
    stdout.write('| $cell$padding ');
  }
  stdout.write('|\n');
}

void printSubheadings(List<int> columnWidths) {
  stdout.write('+' +
      ('-' *
          (columnWidths.reduce((a, b) => a + b) +
              3 * columnWidths.length -
              1)) +
      '+');
  stdout.write('\n');
}

void view() {
  try {
    List<List<String>> tasks = [];
    List<String> sub_headings = ['ID', 'Title', 'Description', 'Completed'];
    tasks.add(sub_headings);

    for (var i = 0; i < all_tasks.length; i++) {
      Task task = all_tasks[i];
      List<String> single_task = [
        task.ID.toString(),
        task.Title.toString(),
        task.Description.toString(),
        task.isCompleted.toString()
      ];
      tasks.add(single_task);
    }

    List<int> columnWidths = List.generate(tasks[0].length, (index) => 0);

    for (var row in tasks) {
      for (int i = 0; i < row.length; i++) {
        if (row[i].length > columnWidths[i]) {
          columnWidths[i] = row[i].length;
        }
      }
    }

    // Print the table headings
    printRow(tasks[0], columnWidths);

    // Print the subheadings
    printSubheadings(columnWidths);

    // Print the table rows
    for (int i = 1; i < tasks.length; i++) {
      printRow(tasks[i], columnWidths);
    }

    main();
  } catch (e) {
    print('You dont have any tasks yet!');
    main();
  }
}

void main() {
  print('Welcome to the task tracker app!');
  stdout.write(
      'Choose action: (Add) || (Remove) || (Update) || (View) || (Stop)\n');
  String? action = stdin.readLineSync()!;

  action.toLowerCase();

  if (action == 'add') {
    add();
  } else if (action == 'Remove') {
    remove();
  } else if (action == 'update') {
    update();
  } else if (action == 'view') {
    view();
  } else if (action == 'stop') {
    return;
  } else {
    print('Please select a valid action');
    main();
  }
}
