unit Endereco;

interface

uses
  System.SysUtils, System.Generics.Collections;

type
  TEndereco = class
    private
      Fid: Int64;
      Fcep: Integer;
      FLogradouro: String;
      FTipo_localizacao: String;
      FLatitude: String;
      FBairro: String;
      FServico: String;
      FUF: String;
      FCidade: String;
      FLongitude: String;
    public
      property id : Int64 read Fid write Fid;
      property cep : Integer read Fcep write Fcep;
      property UF: String read FUF write FUF;
      property Cidade: String read FCidade write FCidade;
      property Bairro: String read FBairro write FBairro;
      property Logradouro: String read FLogradouro write FLogradouro;
      property Servico: String read FServico write FServico;
      property Tipo_localizacao: String read FTipo_localizacao write FTipo_localizacao;
      property Latitude: String read FLatitude write FLatitude;
      property Longitude: String read FLongitude write FLongitude;

      procedure LimparDados;
  end;

implementation

{ TRetornoCEP }
procedure TEndereco.LimparDados;
begin
  FId := -1;
  Fcep := -1;
  FLogradouro := EmptyStr;
  FTipo_localizacao := EmptyStr;
  FLatitude := EmptyStr;
  FBairro := EmptyStr;
  FServico := EmptyStr;
  FUF := EmptyStr;
  FCidade := EmptyStr;
  FLongitude := EmptyStr;
end;

end.
