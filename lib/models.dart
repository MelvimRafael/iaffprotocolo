class Fazenda {
  int? id; // Alteração: tornar o ID opcional
  String nome;
  String localizacao;
  String proprietario;
  String imagem;
  String descricao;

  Fazenda({
    this.id,
    required this.nome,
    required this.localizacao,
    required this.proprietario,
    required this.imagem,
    required this.descricao,
  });

  factory Fazenda.fromMap(Map<String, dynamic> map) {
    return Fazenda(
      id: map['id'],
      nome: map['nome'],
      localizacao: map['localizacao'],
      proprietario: map['proprietario'],
      imagem: map['imagem'],
      descricao: map['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'localizacao': localizacao,
      'proprietario': proprietario,
      'imagem': imagem,
      'descricao': descricao,
    };
  }
}


class Semen {
  int? id;
  String nome;
  String codigo;
  String descricao;

  Semen({
    this.id,
    required this.nome,
    required this.codigo,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'codigo': codigo,
      'descricao': descricao,
    };
  }
}

class Lote {
  int? id;
  String nome;
  String numero;
  String descricao;

  Lote({
    this.id,
    required this.nome,
    required this.numero,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'numero': numero,
      'descricao': descricao,
    };
  }
}

class Vacas {
  int? id;
  String nome;
  String numero;
  String raca;

  Vacas({
    this.id,
    required this.nome,
    required this.numero,
    required this.raca,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'numero': numero,
      'raca': raca,
    };
  }
}

class IAFTProtocolo {
  int? id;
  String nome;
  String descricao;
  String dataInicio;
  String medicamentos;
  String procedimentos;
  String observacoes;

  IAFTProtocolo({
    this.id,
    required this.nome,
    required this.descricao,
    required this.dataInicio,
    required this.medicamentos,
    required this.procedimentos,
    required this.observacoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'data_inicio': dataInicio,
      'medicamentos': medicamentos,
      'procedimentos': procedimentos,
      'observacoes': observacoes,
    };
  }
}
