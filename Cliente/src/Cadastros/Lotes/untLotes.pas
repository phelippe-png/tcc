unit untLotes;

interface

uses
  IdHTTP, System.JSON, System.SysUtils, System.Classes, DataSet.Serialize,
  untEmpresas;

type
  TLotes = class
  private
    FIDEmpresa: integer;
    FCodigo: integer;
    FOP: integer;
    FDescricao: string;
    FEmpresa: TEmpresa;
    FDataEntrada: TDate;
    FDataSaida: TDate;
    FQuantidade: integer;
    FValorUnit: currency;
    FValorTotal: Currency;
    FTempoMin: Double;
    FTempoTotal: Double;

    HTTP: TIdHTTP;
  public
    property idEmpresa: integer read FIDEmpresa write FIDEmpresa;
    property codigo: integer write FCodigo;
    property OP: integer write FOP;
    property descricao: string write FDescricao;
    property empresa: TEmpresa read FEmpresa write FEmpresa;
    property dataEntrada: TDate write FDataEntrada;
    property dataSaida: TDate write FDataSaida;
    property quantidade: integer write FQuantidade;
    property valorUnit: currency write FValorUnit;
    property valorTotal: Currency write FValorTotal;
    property tempoMin: Double write FTempoMin;
    property tempoTotal: Double read FtempoTotal write FtempoTotal;

    function cadastrarDados: string;
  end;

implementation

function TLotes.cadastrarDados: string;
var
  Dados: TJSONObject;
  ConvertJSONToStream: TStream;
begin
  try
    HTTP := TIdHTTP.Create(nil);
    Dados := TJSONObject.Create;

    Dados.AddPair('id_empresa', FIDEmpresa.ToString);
    Dados.AddPair('codigo', FCodigo.ToString);
    Dados.AddPair('op', FOP.ToString);
    Dados.AddPair('descricao', FDescricao);
    Dados.AddPair('empresa', FEmpresa.RazaoSocial);
//      Dados.AddPair('data_entrada', DateToStr(FDataEntrada));
    Dados.AddPair('quantidade', FQuantidade.ToString);
    Dados.AddPair('valor_unit', FormatFloat('###,##0.00', FValorUnit).Replace(',', '.'));
    Dados.AddPair('valor_total', FormatFloat('###,##0.00', FValorTotal).Replace(',', '.'));
    Dados.AddPair('tempo_min', FormatFloat('##0.0000', FTempoMin).Replace(',', '.'));
    Dados.AddPair('tempo_total', FormatFloat('##0.0000', FTempoTotal).Replace(',', '.'));

    ConvertJSONToStream := TStringStream.Create(Dados.ToJSON);

    HTTP.Request.ContentType := 'application/json';
    HTTP.Post('http://localhost:9000/lotes/inserir', ConvertJSONToStream);
    Result := 'Lote cadastrado com sucesso.';
  except
    result := 'Erro!';
  end;
end;

end.
