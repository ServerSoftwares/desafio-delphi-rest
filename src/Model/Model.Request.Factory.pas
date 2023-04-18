unit Model.Request.Factory;

interface

uses
  Model.Request.Interfaces;

type
  TFactorytRequest = class
  private

  public
    class function NewCEP: IRequestCEP;
  end;

implementation

uses
  Model.Request.CEP;

{ TFactorytRequest }

class function TFactorytRequest.NewCEP: IRequestCEP;
begin
  Result := TRequestCEP.New;
end;

end.
