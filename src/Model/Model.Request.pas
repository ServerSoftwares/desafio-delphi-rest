unit Model.Request;

interface

uses
  Model.Request.Interfaces;

type
  TReq = class(TInterfacedObject, IReq)
  private

  public
    class function New: IReq;

    function CEP: IRequestCEP;
  end;

implementation

uses
  Model.Request.Factory;

{ TRequest }

class function TReq.New: IReq;
begin
  Result := Self.Create;
end;

function TReq.CEP: IRequestCEP;
begin
  Result := TFactorytRequest.NewCEP;
end;

end.