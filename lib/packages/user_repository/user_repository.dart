import 'package:atom_admin/packages/supabase_client/supabase_client.dart';

class UserRepository {
  UserRepository({
    required DatabaseClient databaseClient,
  }) : _databaseClient = databaseClient;

  final DatabaseClient _databaseClient;

  // ================== GATEWAY ======================

  Future<Map<String, dynamic>> loginAdmin({
    required String username,
    required String password,
  }) async =>
      _databaseClient.loginAdmin(username: username, password: password);

  Future<void> signupAdmin({
    required String username,
    required String password,
  }) async =>
      _databaseClient.signupAdmin(username: username, password: password);

  Future<void> deleteDomain({
    required String domainId,
  }) async =>
      _databaseClient.deleteDomain(domainId: domainId);

  Stream<dynamic> domain(String userId) =>
      _databaseClient.domain(userId: userId);

  Future<void> saveDomain({
    required String domain,
    required String userId,
  }) async =>
      _databaseClient.saveDomain(domain: domain, userId: userId);
}
