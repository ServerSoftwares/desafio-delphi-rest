unit ConsultaCEP.Model.Records.Endereco;

interface

type
   TRetornoCEP = record
      CEP,
      Endereco,
      Bairro,
      Cidade,
      Estado: String;
      Status: Integer;
   end;

implementation

end.
