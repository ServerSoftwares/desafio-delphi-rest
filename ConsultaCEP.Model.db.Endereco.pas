unit ConsultaCEP.Model.db.Endereco;

interface

uses
  FireDAC.Comp.Client,
  Data.DB,
  System.Classes,
  System.SysUtils,
  dmDataBase,
  ConsultaCEP.Model.Records.Endereco;

type
   TDB_Enderecos = class
      private

      public
         constructor Create;
         destructor Destroy; override;

         function ListarEnderecos (TextoSQL: String): Boolean;
         function InserirEndereco (EnderecoCompleto: TRetornoCEP): Boolean;
         function ExcluirEndereco (CEP: String): Boolean;
   end;

implementation

{ TDB_Enderecos }

constructor TDB_Enderecos.Create;
begin
//
end;

destructor TDB_Enderecos.Destroy;
begin
   try
      // FECHO O BANCO DE DADOS E TABELAS
      dmDB.tblEnderecos.Close;
      dmDB.fdConexao.Close;
   except
   end;
end;

function TDB_Enderecos.ExcluirEndereco(CEP: String): Boolean;
begin
   try
      Result := True;

      // DELETO DO BANCO DE DADOS O CEP
      dmDB.tblEnderecos.ExecSQL('DELETE FROM tblEnderecos '+
                                'WHERE CEP = '''+CEP+'''  ');
   except
      Result := False;
   end;
end;

function TDB_Enderecos.InserirEndereco(EnderecoCompleto: TRetornoCEP): Boolean;
begin
   try
      Result := True;

      dmDB.tblEnderecos.SQL.Clear;
      dmDB.tblEnderecos.SQL.Add('INSERT INTO tblEnderecos '+
                                '       (CEP,       '+
                                '        Endereco,  '+
                                '        Bairro,    '+
                                '        Cidade,    '+
                                '        Estado)    '+
                                'VALUES (:CEP,      '+
                                '        :Endereco, '+
                                '        :Bairro,   '+
                                '        :Cidade,   '+
                                '        :Estado)   ');
      dmDB.tblEnderecos.ParamByName('CEP').AsString := EnderecoCompleto.CEP;
      dmDB.tblEnderecos.ParamByName('Endereco').AsString := EnderecoCompleto.Endereco;
      dmDB.tblEnderecos.ParamByName('Bairro').AsString := EnderecoCompleto.Bairro;
      dmDB.tblEnderecos.ParamByName('Cidade').AsString := EnderecoCompleto.Cidade;
      dmDB.tblEnderecos.ParamByName('Estado').AsString := EnderecoCompleto.Estado;

      // EXCUTA A GRAVAÇÃO NO DB LOCAL DA VERSÃO ATUAL DO APP
      dmDB.tblEnderecos.ExecSQL;
   except
      Result := False;
   end;
end;

function TDB_Enderecos.ListarEnderecos(TextoSQL: String): Boolean;
begin
   try
      Result := True;
      dmDB.tblEnderecos.Open(TextoSQL);
   except
      Result := False;
   end;
end;

end.
