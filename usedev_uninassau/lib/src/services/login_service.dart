import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginService {
  LoginService._();

  static final LoginService instance = LoginService._();

  static const _baseUrl = 'https://fakestoreapi.com/auth/login';
  static const _tokenKey = 'auth_token';

  /// Credenciais de teste da Fake Store API (use exatamente assim).
  static const testUsername = 'mor_2314';
  static const testPassword = r'83r5^_';

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    webOptions: WebOptions(
      dbName: 'usedev_secure_storage',
      publicKey: 'usedev_secure_storage_key',
    ),
  );

  Future<void> login({
    required String username,
    required String password,
  }) async {
    http.Response response;
    try {
      response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
    } catch (_) {
      throw Exception('Falha na conexão. Verifique sua internet.');
    }

    // A Fake Store retorna 201 (Created) em login válido, não 200.
    final success = response.statusCode >= 200 && response.statusCode < 300;
    if (!success) {
      throw Exception(
        'Usuário ou senha inválidos. Use: $testUsername / $testPassword',
      );
    }

    final Map<String, dynamic> data;
    try {
      data = json.decode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw Exception('Resposta inválida do servidor.');
    }

    final token = data['token'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Resposta inválida do servidor.');
    }

    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Erro ao salvar token: $e');
      }
      throw Exception(
        'Login na API ok, mas não foi possível salvar a sessão neste dispositivo.',
      );
    }
  }

  Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Erro ao ler token: $e');
      }
      return null;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: _tokenKey);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Erro ao remover token: $e');
      }
    }
  }
}
