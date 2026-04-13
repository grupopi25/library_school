import 'package:flutter/material.dart';

class LivroModel {
  final String capa;
  final String titulo;
  final String autor;
  final String categoria;
  final int tombo;
  final String anoPublicacao;
  final String isbn;
  final bool status;

  LivroModel({
    required this.capa,
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.tombo,
    required this.anoPublicacao,
    required this.isbn,
    required this.status,
  });

  factory LivroModel.fromMap(Map<String, dynamic> map) {
    return LivroModel(
      capa: map['capa'] ?? '',
      titulo: map['titulo'] ?? '',
      autor: map['autor'] ?? '',
      categoria: map['categoria'] ?? '',
      tombo: map['tombo'] ?? 0,
      anoPublicacao: map['anoPublicacao'] ?? '',
      isbn: map['isbn'] ?? '',
      status: map['status'] == true,
    );
  }
}