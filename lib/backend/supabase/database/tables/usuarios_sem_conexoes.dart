import '../database.dart';

class UsuariosSemConexoesTable extends SupabaseTable<UsuariosSemConexoesRow> {
  @override
  String get tableName => 'usuarios_sem_conexoes';

  @override
  UsuariosSemConexoesRow createRow(Map<String, dynamic> data) =>
      UsuariosSemConexoesRow(data);
}

class UsuariosSemConexoesRow extends SupabaseDataRow {
  UsuariosSemConexoesRow(super.data);

  @override
  SupabaseTable get table => UsuariosSemConexoesTable();

  int? get id => getField<int>('id');
  set id(int? value) => setField<int>('id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get uuid => getField<String>('uuid');
  set uuid(String? value) => setField<String>('uuid', value);

  String? get nome => getField<String>('nome');
  set nome(String? value) => setField<String>('nome', value);

  String? get instagram => getField<String>('instagram');
  set instagram(String? value) => setField<String>('instagram', value);

  String? get linkedin => getField<String>('linkedin');
  set linkedin(String? value) => setField<String>('linkedin', value);

  String? get whatsapp => getField<String>('whatsapp');
  set whatsapp(String? value) => setField<String>('whatsapp', value);

  String? get sobre => getField<String>('sobre');
  set sobre(String? value) => setField<String>('sobre', value);

  String? get profilePic => getField<String>('profile_pic');
  set profilePic(String? value) => setField<String>('profile_pic', value);

  int? get empresa => getField<int>('empresa');
  set empresa(int? value) => setField<int>('empresa', value);

  String? get cargo => getField<String>('cargo');
  set cargo(String? value) => setField<String>('cargo', value);

  String? get empresaNome => getField<String>('empresa_nome');
  set empresaNome(String? value) => setField<String>('empresa_nome', value);

  int? get destaque => getField<int>('destaque');
  set destaque(int? value) => setField<int>('destaque', value);
}
