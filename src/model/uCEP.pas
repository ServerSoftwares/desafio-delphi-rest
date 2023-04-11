unit uCEP;

interface
type
  TCEP = class
    private
    Fstreet: string;
    Fstate: string;
    Fcep: string;
    Fservice: string;
    Fneighborhood: string;
    Fcity: string;
    procedure SetCep(const Value: string);
    procedure SetCity(const Value: string);
    procedure SetNeighborhood(const Value: string);
    procedure SetService(const Value: string);
    procedure SetState(const Value: string);
    procedure SetStreet(const Value: string);
    public
      property cep: string read Fcep write SetCep;
      property state: string read Fstate write SetState;
      property city: string read Fcity write SetCity;
      property neighborhood: string read Fneighborhood write SetNeighborhood;
      property street: string read Fstreet write SetStreet;
      property service: string read Fservice write SetService;
  end;

implementation

{ TCEP }

procedure TCEP.SetCep(const Value: string);
begin
  Fcep := Value;
end;

procedure TCEP.SetCity(const Value: string);
begin
  Fcity := Value;
end;

procedure TCEP.SetNeighborhood(const Value: string);
begin
  Fneighborhood := Value;
end;

procedure TCEP.SetService(const Value: string);
begin
  Fservice := Value;
end;

procedure TCEP.SetState(const Value: string);
begin
  Fstate := Value;
end;

procedure TCEP.SetStreet(const Value: string);
begin
  Fstreet := Value;
end;

end.
