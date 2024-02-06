import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thsyd/models/news.dart';

class NewsRepository {
  const NewsRepository({
    required this.firebaseFirestore,
  });

  final FirebaseFirestore firebaseFirestore;

  Stream<List<News>> get news =>
      FirebaseFirestore.instance.collection("news").snapshots().map(
        (snappshot) {
          return snappshot.docs.map((doc) => News.fromMap(doc.data())).toList();
        },
      );
}
