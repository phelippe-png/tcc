unit untContasPagar;

interface

uses
  System.JSON, System.Classes, DataSet.Serialize, System.SysUtils, IdHTTP;

type
  TContasPagar = class
  private
    Fid: integer;
    FDescricao: string;
    FDataVenc: TDate;
    FvalorTotal: Double;
    FvalorPago: Double;

    HTTP: TIdHTTP;
    dadosConta: TJSONObject;
    convertDadosToStream: TStream;
  public
    property id: integer read Fid write Fid;
    property descricao: string read FDescricao write FDescricao;
    property dataVenc: TDate read FDataVenc write FDataVenc;
    property valorTotal: Double read FvalorTotal write FvalorTotal;
    property valorPago: Double read FvalorPago write FvalorPago;

    function cadastrarConta: string;
    procedure inserirValorPago;
    constructor Create;
  end;

implementation

constructor TContasPagar.Create;
begin
  HTTP := TIdHTTP.Create(nil);
  dadosConta := TJSONObject.Create;
end;

procedure TContasPagar.inserirValorPago;
begin
  dadosConta.AddPair('id', Fid.ToString);
  dadosConta.AddPair('valor_pago', FormatCurr('###,###,##0.00', FvalorPago));

  convertDadosToStream := TStringStream.Create(dadosConta.ToJSON);

  HTTP.Request.ContentType := 'application/json';
  HTTP.Put('http://localhost:9000/contaspagar', convertDadosToStream);
end;

function TContasPagar.cadastrarConta: string;
begin
  try
//    dadosConta := TJSONObject.Create;
    dadosConta.AddPair('descricao', FDescricao);
    dadosConta.AddPair('data_venc', DateToStr(FDataVenc));
    dadosConta.AddPair('valor_total', FormatFloat('###,###,##0.00', FvalorTotal).Replace(',', '.'));
    dadosConta.AddPair('valor_pago', FormatFloat('###,###,##0.00', FvalorPago).Replace(',', '.'));

    convertDadosToStream := TStringStream.Create(dadosConta.ToJSON);

    HTTP.Request.ContentType := 'application/json';
    HTTP.Post('http://localhost:9000/contaspagar/inserir', convertDadosToStream);
                                                              
    result := 'Conta cadastrada.';
  except
    result := 'Erro de servidor!';
  end;
end;

end.
