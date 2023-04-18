unit RetornoCEP;

interface
type
  TRetornoCEP = class
  private
    FBairro: string;
    FServico: string;
    FUF: string;
    FCEP: string;
    FCidade: string;
    FEndereco: string;
    FRua: string;

  public
    property CEP: string read FCEP write FCEP;
    property UF: string read FUF write FUF;
    property Cidade: string read FCidade write FCidade;
    property Bairro: string read FBairro write FBairro;
    property Rua: string read FRua write FRua;
    property Endereco: string read FEndereco write FEndereco;
    property Servico: string read FServico write FServico;

    constructor Create(ACEP, AUF, ACidade, ABairro, ARua, AServico: string);
    destructor Destroy; override;

  end;

implementation

{ TRetornoCEP }

constructor TRetornoCEP.Create(ACEP, AUF, ACidade, ABairro, ARua, AServico: string);
begin
  Self.CEP     := ACEP;
  Self.UF      := AUF;
  Self.Cidade  := ACidade;
  Self.Bairro  := ABairro;
  Self.Rua     := ARua;
  Self.Servico := AServico;
end;

destructor TRetornoCEP.Destroy;
begin
   Self.Destroy;
  inherited;
end;

end.
