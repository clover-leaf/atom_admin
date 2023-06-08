import 'dart:developer';

import 'package:supabase/supabase.dart';

class DatabaseClient {
  DatabaseClient({required this.url, required this.key});

  final String url;
  final String key;

  Future<void> signupAdmin({
    required String username,
    required String password,
  }) async {
    try {
      final supabaseClient = SupabaseClient(url, key);
      final resUsers = await supabaseClient
          .from('user_admin')
          .select('username') as List<dynamic>;

      final allUsernames =
          resUsers.map((ele) => (ele as Map<String, dynamic>)['username']);

      try {
        if (allUsernames.contains(username)) {
          throw Exception('This username has been used!');
        }
        await supabaseClient.from('user_admin').insert({
          'username': username,
          'password': password,
        });
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Something has been wrong!');
    }
  }

  Future<Map<String, dynamic>> loginAdmin({
    required String username,
    required String password,
  }) async {
    try {
      final supabaseClient = SupabaseClient(url, key);
      final res = await supabaseClient
          .from('user_admin')
          .select()
          .eq('username', username)
          .eq('password', password)
          .single();
      return res as Map<String, dynamic>;
    } catch (e) {
      log(e.toString());
      throw Exception('Usename or password is not correct');
    }
  }

  Future<void> deleteDomain({
    required String domainId,
  }) async {
    final supabaseClient = SupabaseClient(url, key);
    try {
      final res = await supabaseClient
          .from('domain')
          .select()
          .eq('id', domainId)
          .single();
      await supabaseClient
          .rpc('delete_schema', params: {'s_name': res['name']});
      await supabaseClient.from('domain').delete().eq('id', domainId).single();
    } catch (e) {
      log(e.toString());
      throw Exception('Something has been wrong!');
    }
  }

  Future<void> saveDomain({
    required String domain,
    required String userId,
  }) async {
    final supabaseClient = SupabaseClient(url, key);

    // check domain name exist
    final resGetDomains =
        await supabaseClient.from('domain').select('name') as List<dynamic>;
    final allDomains =
        resGetDomains.map((ele) => (ele as Map<String, dynamic>)['name']);

    try {
      if (allDomains.contains(domain)) {
        throw Exception('This domain name has been used!');
      }
    } catch (e) {
      rethrow;
    }

    // check userID
    final res = await supabaseClient
        .from('user_admin')
        .select()
        .eq('id', userId)
        .single();
    final userInfo = res as Map<String, dynamic>;

    try {
      await supabaseClient.rpc('create_schema', params: {'s_name': domain});
      await supabaseClient.rpc('expose_schema', params: {
        'schemas': ['public', 'storage', ...allDomains, domain].join(', ')
      });

      await supabaseClient
          .from('domain')
          .insert({'name': domain, 'owner': userId});

      await supabaseClient.rpc('create_member', params: {'s_name': domain});
      await supabaseClient.rpc('create_broker', params: {'s_name': domain});
      await supabaseClient.rpc('create_dashboard', params: {'s_name': domain});
      await supabaseClient.rpc('create_group', params: {'s_name': domain});
      await supabaseClient.rpc('create_device', params: {'s_name': domain});
      await supabaseClient.rpc('create_tile', params: {'s_name': domain});
      await supabaseClient.rpc('create_alert', params: {'s_name': domain});
      await supabaseClient.rpc('create_command', params: {'s_name': domain});
      await supabaseClient
          .rpc('create_alert_record', params: {'s_name': domain});
      await supabaseClient.rpc('create_record', params: {'s_name': domain});

      final domainClient = createSupabaseClient(domain);
      await domainClient.from('member').insert({
        'username': userInfo['username'],
        'password': userInfo['password'],
        'is_admin': true,
      });
    } catch (e) {
      log(e.toString());
      throw Exception('Something has been wrong!');
    }
  }

  Stream<dynamic> domain({required String userId}) {
    final supabaseClient = SupabaseClient(url, key);
    return supabaseClient
        .from('domain')
        .stream(primaryKey: ['id']).eq('owner', userId);
  }

  SupabaseClient createSupabaseClient(String schema) {
    return SupabaseClient(url, key, schema: schema);
  }
}
