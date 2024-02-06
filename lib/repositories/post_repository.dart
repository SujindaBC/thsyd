import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thsyd/models/post.dart';

class PostRepository {
  const PostRepository({
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;

  Stream<List<Post>> get jobhubs => FirebaseFirestore.instance
          .collection("jobHub")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .map(
        (snappshot) {
          return snappshot.docs.map((doc) => Post.fromMap(doc.data())).toList();
        },
      );

  Stream<List<Post>> get housemates => FirebaseFirestore.instance
          .collection("houseMate")
          .orderBy("createdAt", descending: true)
          .snapshots()
          .map(
        (snappshot) {
          return snappshot.docs.map((doc) => Post.fromMap(doc.data())).toList();
        },
      );
}
