import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/model/my_user.dart';
import 'package:todo/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task, String uId) {
    var taskCollection = getTasksCollection(uId);
    var docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> removeTaskFromFireStore(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> editIsDone(Task task, String uId) {
    return getTasksCollection(uId)
        .doc(task.id)
        .update({'isDone': !task.isDone!});
  }

  static Future<void> editTask(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).update(task.toFireStore());
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var docSnapshot = await getUsersCollection().doc(uId).get();
    return docSnapshot.data();
  }
}
