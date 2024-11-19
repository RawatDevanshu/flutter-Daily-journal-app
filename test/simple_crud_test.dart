import 'package:daily_journal/services/firestore_crud_methods.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'mocks.mocks.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late CrudMethods crudMethods;
  late MockUser mockUser;
  late MockFirebaseAuth mockAuth;
  late MockBuildContext mockContext;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockUser = MockUser(
      uid: 'test-user-id',
      email: 'test@test.com',
      isAnonymous: false,
    );
    mockAuth = MockFirebaseAuth(mockUser: mockUser, signedIn: true);
    mockContext = MockBuildContext();

    final mockScaffoldMessengerState = MockScaffoldMessengerState();
    when(mockContext.findAncestorStateOfType<ScaffoldMessengerState>())
        .thenReturn(mockScaffoldMessengerState);

    crudMethods = CrudMethods(fakeFirestore, auth: mockAuth);
  });

  test('Simple add journal entry test', () async {
    // Arrange
    const title = 'My First Journal';
    const content = 'Hello World!';

    // Act
    await crudMethods.addData(
      title: title,
      data: content,
      context: mockContext,
    );

    // Assert
    final snapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();

    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.data()['title'], title);
    expect(snapshot.docs.first.data()['text'], content);
  });

  test('Delete journal entry test', () async {
    // Arrange
    const title = 'Journal to Delete';
    const content = 'This will be deleted';

    // First add a document
    await crudMethods.addData(
      title: title,
      data: content,
      context: mockContext,
    );

    // Get the document ID
    final snapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();
    final docId = snapshot.docs.first.id;

    // Act
    await crudMethods.delete(docId: docId);

    // Assert
    final afterDeleteSnapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();

    expect(afterDeleteSnapshot.docs.length, 0);
  });

  test('getData returns all journal entries', () async {
    // Arrange
    final entries = [
      {'title': 'Journal 1', 'data': 'Content 1'},
      {'title': 'Journal 2', 'data': 'Content 2'},
    ];

    // Add multiple entries
    for (var entry in entries) {
      await crudMethods.addData(
        title: entry['title']!,
        data: entry['data']!,
        context: mockContext,
      );
    }

    // Act
    final result = await crudMethods.getData();

    // Assert
    expect(result.docs.length, 2);
    expect(
        (result.docs[0].data() as Map<String, dynamic>)['title'], 'Journal 1');
    expect(
        (result.docs[0].data() as Map<String, dynamic>)['text'], 'Content 1');
    expect(
        (result.docs[1].data() as Map<String, dynamic>)['title'], 'Journal 2');
    expect(
        (result.docs[1].data() as Map<String, dynamic>)['text'], 'Content 2');
  });

  test('updateData modifies existing journal entry', () async {
    // Arrange
    const originalTitle = 'Original Title';
    const originalContent = 'Original Content';

    // Add initial document
    await crudMethods.addData(
      title: originalTitle,
      data: originalContent,
      context: mockContext,
    );

    // Get the document ID
    final snapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();
    final docId = snapshot.docs.first.id;

    // Act
    const updatedTitle = 'Updated Title';
    const updatedContent = 'Updated Content';
    await crudMethods.updateData(
      docId: docId,
      title: updatedTitle,
      text: updatedContent,
      context: mockContext,
    );

    // Assert
    final updatedSnapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();

    expect(updatedSnapshot.docs.length, 1);
    expect(updatedSnapshot.docs.first.data()['title'], updatedTitle);
    expect(updatedSnapshot.docs.first.data()['text'], updatedContent);
    // Verify date wasn't changed
    expect(updatedSnapshot.docs.first.data()['date'],
        snapshot.docs.first.data()['date']);
  });

  test('Add journal entry with empty title', () async {
    // Arrange
    const content = 'This should fail';

    // Act & Assert
    expect(
      () async => await crudMethods.addData(
        title: '',
        data: content,
        context: mockContext,
      ),
      throwsA(isA<FirebaseException>()),
    );
  });

  test('Update non-existent journal entry', () async {
    // Arrange
    const nonExistentDocId = 'non-existent-id';
    const updatedTitle = 'Updated Title';
    const updatedContent = 'Updated Content';

    // Act & Assert
    expect(
      () async => await crudMethods.updateData(
        docId: nonExistentDocId,
        title: updatedTitle,
        text: updatedContent,
        context: mockContext,
      ),
      throwsA(isA<FirebaseException>()),
    );
  });

  test('Delete non-existent journal entry', () async {
    // Arrange
    const nonExistentDocId = 'non-existent-id';

    // Act & Assert
    expect(
      () async => await crudMethods.delete(docId: nonExistentDocId),
      throwsA(isA<FirebaseException>()),
    );
  });

  test('Add journal entry with empty content', () async {
    // Arrange
    const title = 'Title with no content';

    // Act
    await crudMethods.addData(
      title: title,
      data: '',
      context: mockContext,
    );

    // Assert
    final snapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();

    expect(snapshot.docs.length, 1);
    expect(snapshot.docs.first.data()['title'], title);
    expect(snapshot.docs.first.data()['text'], ''); // Content should be empty
  });

  test('Get data returns empty when no entries exist', () async {
    // Act
    final result = await crudMethods.getData();

    // Assert
    expect(result.docs.length, 0);
  });

  test('Update journal entry with empty title', () async {
    // Arrange
    const originalTitle = 'Original Title';
    const originalContent = 'Original Content';

    // Add initial document
    await crudMethods.addData(
      title: originalTitle,
      data: originalContent,
      context: mockContext,
    );

    // Get the document ID
    final snapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();
    final docId = snapshot.docs.first.id;

    // Act & Assert
    expect(
      () async => await crudMethods.updateData(
        docId: docId,
        title: '',
        text: originalContent,
        context: mockContext,
      ),
      throwsA(isA<FirebaseException>()),
    );
  });

  test('Update journal entry with empty text', () async {
    // Arrange
    const originalTitle = 'Original Title';
    const originalContent = 'Original Content';

    // Add initial document
    await crudMethods.addData(
      title: originalTitle,
      data: originalContent,
      context: mockContext,
    );

    // Get the document ID
    final snapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();
    final docId = snapshot.docs.first.id;

    // Act
    await crudMethods.updateData(
      docId: docId,
      title: originalTitle,
      text: '',
      context: mockContext,
    );

    // Assert
    final updatedSnapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();

    expect(updatedSnapshot.docs.length, 1);
    expect(updatedSnapshot.docs.first.data()['title'], originalTitle);
    expect(
        updatedSnapshot.docs.first.data()['text'], ''); // Text should be empty
  });

  test('Delete an existing journal entry', () async {
    // Arrange
    const title = 'Journal to Keep';
    const content = 'This will be kept';

    // First add a document
    await crudMethods.addData(
      title: title,
      data: content,
      context: mockContext,
    );

    // Get the document ID
    final snapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();
    final docId = snapshot.docs.first.id;

    // Act
    await crudMethods.delete(docId: docId);

    // Assert
    final afterDeleteSnapshot =
        await fakeFirestore.collection('users/${mockUser.uid}/journals').get();

    expect(afterDeleteSnapshot.docs.length, 0);
  });
}
