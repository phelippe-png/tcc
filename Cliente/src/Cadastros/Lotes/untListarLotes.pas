unit untListarLotes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.Client, IdHTTP, DataSet.Serialize,
  untCadastrarLote, Vcl.ComCtrls, System.JSON, functions, Datasnap.DBClient;

type
  TformListarLotes = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    Label1: TLabel;
    DBGrid: TDBGrid;
    edSearch: TEdit;
    Panel6: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    btnDelete: TPanel;
    btnEdit: TPanel;
    btnAdd: TPanel;
    procedure btnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private
    ClientDataSet: tclientdataset;
    MemTable: TFDMemTable;
    DataSource: TDataSource;
    HTTP: TIdHTTP;
    formCadastrarLote: TformCadastrarLote;
    functions: TFunctions;

    procedure SQL;
    procedure EditDBGrid;
  public
    lib: boolean;
  end;

var
  formListarLotes: TformListarLotes;

implementation

{$R *.dfm}

procedure TformListarLotes.EditDBGrid;
begin
  DBGrid.Columns[0].Title.Caption := 'C?digo';
  DBGrid.Columns[1].Title.Caption := 'OP';
  DBGrid.Columns[2].Title.Caption := 'Descri??o';
  DBGrid.Columns[3].Title.Caption := 'Empresa';
  DBGrid.Columns[4].Title.Caption := 'Data Entrada';
  DBGrid.Columns[5].Title.Caption := 'Quantidade';
  DBGrid.Columns[6].Title.Caption := 'Valor Unit?rio';
  DBGrid.Columns[7].Title.Caption := 'Valor Total';
  DBGrid.Columns[8].Title.Caption := 'Tempo Minutos';
end;

procedure TformListarLotes.btnAddClick(Sender: TObject);
begin
  try
    formCadastrarLote := TformCadastrarLote.Create(Self);
    formCadastrarLote.ShowModal;
  finally
    SQL;
  end;
end;

procedure TformListarLotes.btnExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformListarLotes.btnSelectClick(Sender: TObject);
begin
  if DBGrid.SelectedRows.Count > 0 then
  begin
    lib := true;
    Self.Close;
  end;
end;

procedure TformListarLotes.DBGridDblClick(Sender: TObject);
begin
  btnSelectClick(Self);
end;

procedure TformListarLotes.FormCreate(Sender: TObject);
var
  stream: TStream;
begin
  functions := TFunctions.create;
  MemTable := TFDMemTable.Create(nil);
  DataSource := TDataSource.Create(nil);
  HTTP := TIdHTTP.Create(nil);
  HTTP.Request.ContentType := 'application/json';

  DataSource.DataSet := MemTable;
  DBGrid.DataSource := DataSource;

  SQL;
end;

procedure TformListarLotes.SQL;
begin
  MemTable.Close;

  MemTable.LoadFromJSON(HTTP.Get('http://localhost:9000/lotes'));

  MemTable.FieldByName('id').Visible := false;
  MemTable.FieldByName('id_empresa').Visible := false;
  MemTable.FieldByName('pago').Visible := false;

  functions.FitGrid(DBGrid);
  EditDBGrid;
end;

end.
