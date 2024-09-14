class MyUser {
  static const String collectionName = 'users';

  String? id;
  String? name;
  String? mail;

  MyUser({required this.id, required this.name, required this.mail});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          mail: data['mail'],
          name: data['name'],
        );

  Map<String, dynamic> toFireStore() {
    return {'id': id, 'name': name, 'mail': mail};
  }
}
