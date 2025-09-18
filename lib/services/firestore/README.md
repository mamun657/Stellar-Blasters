StreamBuilder<List<Task>>(
  stream: FirestoreService().tasksStream(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    final tasks = snapshot.data ?? [];
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, i) {
        final t = tasks[i];
        return ListTile(
          title: Text(t.title),
          subtitle: Text(t.createdAt.toDate().toString()),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => FirestoreService().deleteTask(t.id),
          ),
        );
      },
    );
  },
);StreamBuilder<List<Task>>(
  stream: FirestoreService().tasksStream(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }
    final tasks = snapshot.data ?? [];
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, i) {
        final t = tasks[i];
        return ListTile(
          title: Text(t.title),
          subtitle: Text(t.createdAt.toDate().toString()),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => FirestoreService().deleteTask(t.id),
          ),
        );
      },
    );
  },
);# Firestore Services

This folder contains Firestore related services and utilities.
