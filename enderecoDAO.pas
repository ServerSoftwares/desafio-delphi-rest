unit EnderecoDAO;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,

  FireDAC.Stan.Param,

  conexaoDB, Endereco;

type
  TEnderecoDAO = class
    private
      FConexao : TConexao;
      FClausula : TStringList;
    public
      constructor Create();
      destructor Destroy; override;

      function  ListaEnderecos() : TList<TEndereco>;
      procedure filterClear();
      procedure addFilterByUF(aUF : String);
      procedure addFilterByCepRange(aCepInicial, aCepFinal : Integer);
      procedure addFilterByCep(aCep : Integer);
      procedure addFilterByEndereco(aEndereco : String);
      function  Update(aEndereco : TEndereco) : boolean;
      function  Delete(aEndereco : TEndereco) : boolean;
      function  Insert(aEndereco : TEndereco) : boolean;
  end;

implementation

{ TEnderecoCEPDAO }

procedure TEnderecoDAO.addFilterByCep(aCep: Integer);
begin
  FClausula.Add('cep = ' + IntToStr(aCep));
end;

procedure TEnderecoDAO.addFilterByCepRange(aCepInicial, aCepFinal : Integer);
begin
  if ((aCepInicial > 0) and (aCepFinal > 0)) then
    FClausula.Add('cep >= ' + IntToStr(aCepInicial) + ' and cep <= ' + IntToStr(aCepFinal));
end;

procedure TEnderecoDAO.addFilterByEndereco(aEndereco : String);
begin
  if Trim(aEndereco) <> '' then
  FClausula.Add(' UPPER(logradouro) like ''%' + AnsiUpperCase(aEndereco) + '%'' ');
end;

procedure TEnderecoDAO.addFilterByUF(aUF : String);
begin
  if Trim(aUF) <> '' then
    FClausula.Add('UPPER(uf) = ' +  AnsiUpperCase(Trim(aUF)).QuotedString);
end;

constructor TEnderecoDAO.Create();
begin
  FConexao := TConexao.Create;
  FClausula := TStringList.Create;
end;

function TEnderecoDAO.Delete(aEndereco : TEndereco) : boolean;
begin
  FConexao.VerificaConexao;

  FConexao.Query.Close;
  FConexao.Query.SQL.Clear;
  FConexao.Query.SQL.Add(' DELETE FROM cache_endereco.endereco WHERE id = :id ');
  FConexao.Query.ParamByName('id').Value := aEndereco.id;
  FConexao.Query.ExecSQL;
  result := (FConexao.Query.RowsAffected > 0);    
end;

destructor TEnderecoDAO.Destroy;
begin
  FConexao.Free;
  FClausula.Free;
  
  inherited;
end;

procedure TEnderecoDAO.filterClear;
begin
  FClausula.Clear;
end;

function TEnderecoDAO.Insert(aEndereco : TEndereco) : boolean;
var
  vNewID : Int64;
begin
  FConexao.VerificaConexao;

  vNewID := FConexao.FDConnection.ExecSQLScalar('SELECT nextval(''cache_endereco.seq_endereco_id'')');

  FConexao.Query.Close;
  FConexao.Query.SQL.Clear;
  FConexao.Query.SQL.Add(' INSERT INTO cache_endereco.endereco                                                           ');
  FConexao.Query.SQL.Add(' (id, cep, uf, cidade, bairro, logradouro, servico, tipo_localizacao, latitude, longitude )        ');
  FConexao.Query.SQL.Add(' VALUES                                                                                        ');
  FConexao.Query.SQL.Add(' (:id,:cep, :uf, :Cidade, :Bairro, :logradouro, :servico, :tipo_localizacao, :latitude, :longitude)');
  FConexao.Query.ParamByName('id').Value := vNewID;
  FConexao.Query.ParamByName('cep').Value := aEndereco.cep;
  FConexao.Query.ParamByName('uf').Value := aEndereco.UF;
  FConexao.Query.ParamByName('Cidade').Value := aEndereco.Cidade;
  FConexao.Query.ParamByName('bairro').Value := aEndereco.Bairro;
  FConexao.Query.ParamByName('logradouro').Value := aEndereco.Logradouro;
  FConexao.Query.ParamByName('servico').Value := aEndereco.Servico;
  FConexao.Query.ParamByName('tipo_localizacao').Value := aEndereco.Tipo_localizacao;
  FConexao.Query.ParamByName('latitude').Value := aEndereco.Latitude;
  FConexao.Query.ParamByName('longitude').Value := aEndereco.Longitude;
  FConexao.Query.ExecSQL;

  aEndereco.id := vNewID;  
  result := (FConexao.Query.RowsAffected > 0);  
end;

function TEnderecoDAO.ListaEnderecos: TList<TEndereco>;
var
  vListaEndereco : TList<TEndereco>;
  vEndereco : TEndereco;
  i : Integer;
begin
  FConexao.VerificaConexao;

  vListaEndereco := TList<TEndereco>.Create;
  Result := vListaEndereco;

  FConexao.Query.Close;
  FConexao.Query.SQL.Clear;
  FConexao.Query.SQL.Add(' SELECT   *                       ');
  FConexao.Query.SQL.Add(' FROM     cache_endereco.endereco ');
  
  if FClausula.Count > 0 then
    FConexao.Query.SQL.Add(' WHERE ' + FClausula[0]);
  for i := 1 to Pred(FClausula.Count) do
    FConexao.Query.SQL.Add(' AND ' + FClausula[i]);  
      
  FConexao.Query.Open;  

  while not FConexao.Query.Eof do
  begin
    vEndereco := TEndereco.Create;
    vEndereco.id := FConexao.Query.FieldByName('id').Value;
    vEndereco.CEP := FConexao.Query.FieldByName('cep').AsInteger;
    vEndereco.UF := FConexao.Query.FieldByName('uf').AsString;
    vEndereco.Cidade := FConexao.Query.FieldByName('cidade').AsString;
    vEndereco.Bairro := FConexao.Query.FieldByName('bairro').AsString;
    vEndereco.Logradouro := FConexao.Query.FieldByName('Logradouro').AsString;
    vEndereco.Servico := FConexao.Query.FieldByName('servico').AsString;
    vEndereco.Tipo_localizacao := FConexao.Query.FieldByName('tipo_localizacao').AsString;
    vEndereco.Latitude := FConexao.Query.FieldByName('latitude').AsString;
    vEndereco.Longitude := FConexao.Query.FieldByName('longitude').AsString;
    vListaEndereco.Add(vEndereco);
    FConexao.Query.Next;
  end;

  FConexao.Query.Close;
end;

function TEnderecoDAO.Update(aEndereco : TEndereco) : boolean;
begin
  FConexao.VerificaConexao;

  FConexao.Query.Close;
  FConexao.Query.SQL.Clear;                                                 
  FConexao.Query.SQL.Add(' UPDATE   cache_endereco.endereco                 ');
  FConexao.Query.SQL.Add(' SET      cep = :cep,                             ');
  FConexao.Query.SQL.Add('          uf = :uf,                               ');
  FConexao.Query.SQL.Add('          cidade = :cidade,                       ');
  FConexao.Query.SQL.Add('          bairro = :bairro,                       ');
  FConexao.Query.SQL.Add('          logradouro = :Logradouro,               ');
  FConexao.Query.SQL.Add('          servico = :servico,                     ');
  FConexao.Query.SQL.Add('          tipo_localizacao = :tipo_localizacao,   ');
  FConexao.Query.SQL.Add('          latitude = :latitude,                   ');
  FConexao.Query.SQL.Add('          longitude = :longitude                  ');
  FConexao.Query.SQL.Add('WHERE     id = :id                                ');  
  FConexao.Query.ParamByName('cep').AsInteger := aEndereco.cep;
  FConexao.Query.ParamByName('uf').Value := aEndereco.UF;
  FConexao.Query.ParamByName('cidade').Value := aEndereco.Cidade;
  FConexao.Query.ParamByName('bairro').Value := aEndereco.Bairro;
  FConexao.Query.ParamByName('logradouro').Value := aEndereco.logradouro;
  FConexao.Query.ParamByName('servico').Value := aEndereco.Servico;
  FConexao.Query.ParamByName('tipo_localizacao').Value := aEndereco.Tipo_localizacao;
  FConexao.Query.ParamByName('latitude').Value := aEndereco.Latitude;
  FConexao.Query.ParamByName('longitude').Value := aEndereco.Longitude;
  FConexao.Query.ParamByName('id').Value := aEndereco.id;
  FConexao.Query.ExecSQL;
  result := (FConexao.Query.RowsAffected > 0);
end;

end.
