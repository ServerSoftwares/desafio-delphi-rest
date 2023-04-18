unit Model.Request.Interfaces;

interface

uses JSON;

type
  IRequestCEP = interface
    ['{0B4408E2-3ABD-45B4-BDDC-7445ADDA681B}']

    function GetStatusCode: Integer;
    function GetResponse: TJSONValue;

    function Consultar(aCep: String): IRequestCEP;

    property Response  : TJSONValue read GetResponse;
    property StatusCode: Integer    read GetStatusCode;
  end;

implementation

end.
