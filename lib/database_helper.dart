import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models.dart';

class DatabaseHelper {
  static const _databaseName = 'cadastros.db';
  static const _databaseVersion = 1;

  static const tableFazenda = 'fazenda';
  static const columnId = 'id';
  static const columnNome = 'nome';
  static const columnLocalizacao = 'localizacao';
  static const columnProprietario = 'proprietario';
  static const columnImagem = 'imagem';
  static const columnDescricao = 'descricao';

  static const tableSemen = 'semen';
  static const columnSemenId = 'id';
  static const columnSemenNome = 'nome';
  static const columnCodigo = 'codigo';
  static const columnSemenDescricao = 'descricao';

  static const tableLote = 'lote';
  static const columnLoteId = 'id';
  static const columnLoteNome = 'nome';
  static const columnNumero = 'numero';
  static const columnLoteDescricao = 'descricao';

  static const tableVacas = 'vacas';
  static const columnVacasId = 'id';
  static const columnVacasNome = 'nome';
  static const columnVacasNumero = 'numero';
  static const columnRaca = 'raca';

  static const tableIAFTProtocolo = 'iaft_protocolo';
  static const columnProtocoloId = 'id';
  static const columnProtocoloNome = 'nome';
  static const columnProtocoloDescricao = 'descricao';
  static const columnDataInicio = 'data_inicio';
  static const columnMedicamentos = 'medicamentos';
  static const columnProcedimentos = 'procedimentos';
  static const columnObservacoes = 'observacoes';

  Future<Database> _initializeDatabase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreateDatabase,
    );
  }

  Future<void> _onCreateDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableFazenda (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnNome TEXT,
        $columnLocalizacao TEXT,
        $columnProprietario TEXT,
        $columnImagem TEXT,
        $columnDescricao TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableSemen (
        $columnSemenId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnSemenNome TEXT,
        $columnCodigo TEXT,
        $columnSemenDescricao TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableLote (
        $columnLoteId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnLoteNome TEXT,
        $columnNumero TEXT,
        $columnLoteDescricao TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableVacas (
        $columnVacasId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnVacasNome TEXT,
        $columnVacasNumero TEXT,
        $columnRaca TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableIAFTProtocolo (
        $columnProtocoloId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnProtocoloNome TEXT,
        $columnProtocoloDescricao TEXT,
        $columnDataInicio TEXT,
        $columnMedicamentos TEXT,
        $columnProcedimentos TEXT,
        $columnObservacoes TEXT
      )
    ''');
  }

  Future<int> insertFazenda(Fazenda fazenda) async {
    final Database db = await _initializeDatabase();
    final int id = await db.insert(
      tableFazenda,
      fazenda.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertSemen(Semen semen) async {
    final Database db = await _initializeDatabase();
    final int id = await db.insert(
      tableSemen,
      semen.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertLote(Lote lote) async {
    final Database db = await _initializeDatabase();
    final int id = await db.insert(
      tableLote,
      lote.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertVacas(Vacas vacas) async {
    final Database db = await _initializeDatabase();
    final int id = await db.insert(
      tableVacas,
      vacas.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertIAFTProtocolo(IAFTProtocolo protocolo) async {
    final Database db = await _initializeDatabase();
    final int id = await db.insert(
      tableIAFTProtocolo,
      protocolo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<Fazenda>> getALLFazendas() async {
    final Database db = await _initializeDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableFazenda);
    return List.generate(maps.length, (index) {
      return Fazenda(
        id: maps[index][columnId],
        nome: maps[index][columnNome],
        localizacao: maps[index][columnLocalizacao],
        proprietario: maps[index][columnProprietario],
        imagem: maps[index][columnImagem],
        descricao: maps[index][columnDescricao],
      );
    });
  }

  Future<void> deleteFazenda(int fazendaId) async {
    final db = await _initializeDatabase();
    await db.delete(
      tableFazenda,
      where: '$columnId = ?',
      whereArgs: [fazendaId],
    );
  }
}
