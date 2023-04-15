unit uFuncoesGerais;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, System.UIConsts,
  System.Generics.Collections, FMX.Edit, FMX.Colors, FMX.ListBox, FireDAC.Comp.Client,
  IdHTTP, FMX.ListView, FMX.SearchBox, FMX.ListView.Types, System.DateUtils,
  System.Net.HttpClient, System.JSON, IdURI,

  {$IFDEF MSWINDOWS}
  Winapi.Windows,
  Winapi.ShellAPI,
//  Vcl.Graphics,
  TlHelp32,
  {$ENDIF}


  System.IniFiles,
  FMX.Platform,
  FMX.ListView.Appearances;

  procedure GravaDadosCfgSQL (NomeChave: String; NomeSubChave: String; ConteudoSubChave: String);
  procedure GravaConfiguracaoServidorSQL (Database,
                                          UserName,
                                          Server,
                                          Password: String);
  function RetornaDadosCfgSQL (NomeChave: String;
                               NomeSubChave: String;
                               ConteudoSubChavePadrao: String): String;
  procedure GravaLogArquivoPreDefinido(NomeArquivoLOG: String;
                                       Mensagem: String);
  function SubstituiString (Tira: String;
                            Substitui: String;
                            Texto: String): String;
  procedure ApagaFiltroListViewSearchBox(ListView: TListView);
  procedure ConfiguraFormatSettings ();
  procedure ScrollListViewItemTThreadSynchronize (NomeListView: TListView;
                                                  ItemListView: Integer);
  procedure ClearListViewTThreadSynchronize (NomeListView: TListView);
  function VoltaDadosString (NomeVariavel, OrigemDados: String): String;

implementation

procedure GravaDadosCfgSQL (NomeChave: String; NomeSubChave: String; ConteudoSubChave: String);
var
   Arquivo: TIniFile;
begin
   try
      Arquivo := TIniFile.Create (ExtractFilePath (ParamStr (0))+'CfgSQL.INI');
      Arquivo.WriteString (NomeChave, NomeSubChave, ConteudoSubChave);
      Arquivo.Free;
   except
      Arquivo.Free;
   end;
end;

procedure GravaConfiguracaoServidorSQL (Database,
                                        UserName,
                                        Server,
                                        Password: String);
begin
   try
      // SERVIDOR SQLSERVER
      GravaDadosCfgSQL ('SQLSERVER'{NomeChave}, 'Database'{NomeSubChave}, Database{ConteudoSubChave});
      GravaDadosCfgSQL ('SQLSERVER'{NomeChave}, 'UserName'{NomeSubChave}, UserName{ConteudoSubChave});
      GravaDadosCfgSQL ('SQLSERVER'{NomeChave}, 'Server'{NomeSubChave}, Server{ConteudoSubChave});
      GravaDadosCfgSQL ('SQLSERVER'{NomeChave}, 'Password'{NomeSubChave}, Password{ConteudoSubChave});
   except
      GravaLogArquivoPreDefinido ('EventosConexao.LOG', 'Erro na gravação do arquivo dos dados no arquivo "CfgSQL.ini"...');
   end;
end;

function RetornaDadosCfgSQL (NomeChave: String;
                             NomeSubChave: String;
                             ConteudoSubChavePadrao: String): String;
var
   Arquivo: TIniFile;
begin
   try
      if FileExists (ExtractFilePath (ParamStr (0))+'CfgSQL.INI') then
         begin
            try
               Arquivo := TIniFile.Create (ExtractFilePath (ParamStr(0))+'CfgSQL.INI');
               Result := Arquivo.ReadString(NomeChave, NomeSubChave, ConteudoSubChavePadrao);
            except
               Result := ConteudoSubChavePadrao;
            end;

            Arquivo.Free;
         end
      else
         begin
            Result := ConteudoSubChavePadrao;
         end;
   except
   end;
end;

procedure GravaLogArquivoPreDefinido(NomeArquivoLOG: String;
                                     Mensagem: String);
var
   Data: String;
   TodasLinhasArquivo: TStringList;
begin
   try
      try
         Data := FormatDateTime ('dd/mm/yyyy', Date);
         Data := SubstituiString ('/', '', Data);
         Data := SubstituiString ('\', '', Data);
         Data := SubstituiString ('.', '', Data);
         Data := SubstituiString (' ', '', Data);
      except
         Data := '';
      end;

      NomeArquivoLOG := Data+'_'+NomeArquivoLOG;

      try
         TodasLinhasArquivo := TStringList.Create;

         // se existir o arquivo, leio todas as linhas
         if FileExists(ExtractFilePath(ParamStr(0))+'LOG\'+NomeArquivoLOG) then
            begin
               try
                  TodasLinhasArquivo.LoadFromFile(ExtractFilePath(ParamStr(0))+'LOG\'+NomeArquivoLOG);
               except
                  Mensagem := 'Não foi possível ler o arquivo: '+ExtractFilePath(ParamStr(0))+'LOG\'+NomeArquivoLOG+#13+#10+Mensagem;
               end;
            end;

         TodasLinhasArquivo.Add (FormatDateTime ('dd/mm/yyyy', Date)+' '+FormatDateTime ('hh:mm:ss', Time)+' - '+Mensagem);
         TodasLinhasArquivo.SaveToFile (ExtractFilePath(ParamStr(0))+'LOG\'+NomeArquivoLOG);
      except
         Mensagem := 'Não foi possível ler o arquivo: '+ExtractFilePath(ParamStr(0))+'LOG\'+NomeArquivoLOG+#13+#10+Mensagem;
      end;
   finally
      TodasLinhasArquivo.Free;
   end;
end;

function SubstituiString (Tira: String;
                          Substitui: String;
                          Texto: String): String;
var
   PosString: Integer;
begin
   PosString := Pos (Tira, Texto);
   while PosString <> 0 do
      begin
         Delete (Texto, PosString, Length (Tira));
         Insert (Substitui, Texto, PosString);
         PosString := Pos (Tira, Texto);
      end;
   Result := Texto;
end;

procedure ApagaFiltroListViewSearchBox(ListView: TListView);
begin
   TThread.Synchronize(nil,
      procedure
      var
        a: Integer;
        SearchBox: TSearchBox;
      begin
         try
            for a := 0 to ListView.Controls.Count-1 do
               begin
                  if ListView.Controls[a].ClassType = TSearchBox then
                     begin
                        SearchBox := TSearchBox(ListView.Controls[a]);
                        SearchBox.Text := '';
                        Break;
                      end;
               end;

            // SEMPRE USAR O ListView.Items.Filter := nil SE NÃO OCORRE UM ERRO DE MEMÓRIA
            ListView.Items.Filter := nil;
         except
         end;
      end);
end;

procedure ConfiguraFormatSettings ();
begin
   try
      FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
      FormatSettings.DecimalSeparator := ',';
      FormatSettings.ThousandSeparator := '.';
      FormatSettings.CurrencyDecimals := 2;
      FormatSettings.CurrencyString := 'R$';
   except
   end;
end;

procedure ScrollListViewItemTThreadSynchronize (NomeListView: TListView;
                                                ItemListView: Integer);
begin
   // SE USAR ScrollViewPos no ListView DEVE TER UM TThread.Synchronize
   TThread.Synchronize(nil,
      procedure
      begin
         try
            NomeListView.ScrollViewPos := ItemListView;
         except
         end;
      end);
end;

procedure ClearListViewTThreadSynchronize (NomeListView: TListView);
begin
   // SE USAR Items.Clear DEVE TER UM TThread.Synchronize
   TThread.Synchronize(nil,
      procedure
      begin
         try
            NomeListView.Items.Clear;
         except
         end;
      end);
end;

function VoltaDadosString (NomeVariavel, OrigemDados: String): String;
var
   PosIni,
   PosFim: Integer;
   NomeVariavelInicio,
   NomeVariavelFim: String;
begin
   try
      NomeVariavelInicio := '##INICIO_'+NomeVariavel+'##';
      NomeVariavelFim := '##FIM_'+NomeVariavel+'##';

      // PROCURO OS DADOS NA VARIÁVEL ORIGEM
      PosIni := Pos (NomeVariavelInicio, OrigemDados);
      PosFim := Pos (NomeVariavelFim, OrigemDados);
      Result := Copy (OrigemDados, PosIni+Length (NomeVariavelInicio), PosFim-(PosIni+Length (NomeVariavelInicio)));
   except
      Result := '';
   end;
end;

end.
