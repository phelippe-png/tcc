unit relatorioContasPagar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Vcl.Imaging.pngimage, System.JSON, FireDAC.Comp.Client,
  Data.DB, Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, DataSet.Serialize,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, IdHTTP;

type
  TformRelatContasPagar = class(TForm)
    RLReport1: TRLReport;
    RLBand1: TRLBand;
    rllTitle: TRLLabel;
    RLDraw1: TRLDraw;
    RLSystemInfo1: TRLSystemInfo;
    RLSystemInfo2: TRLSystemInfo;
    RLImage1: TRLImage;
    RLBand2: TRLBand;
    RLDraw2: TRLDraw;
    RLBand3: TRLBand;
    RLDBText1: TRLDBText;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
  private
    http: TIdHTTP;
  public
    procedure exibirDados(datasource: TDataSource; dataset: TDataSet);
  end;

var
  formRelatContasPagar: TformRelatContasPagar;

implementation

{$R *.dfm}

procedure TformRelatContasPagar.exibirDados(datasource: TDataSource; dataset: TDataSet);
begin
  RLReport1.DataSource := datasource;

  RLDBText1.DataSource := datasource;
  RLDBText1.DataField := 'descricao';

  RLDBText2.DataSource := datasource;
  RLDBText2.DataField := 'data_venc';

  RLDBText3.DataSource := datasource;
  RLDBText3.DataField := 'valor_total';

  RLDBText4.DataSource := datasource;
  RLDBText4.DataField := 'valor_pago';

  RLDBText5.DataSource := datasource;
  RLDBText5.DataField := 'total_pagar';
end;

end.
