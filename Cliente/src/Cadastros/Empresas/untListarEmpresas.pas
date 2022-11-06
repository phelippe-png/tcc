unit untListarEmpresas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, IdHTTP, System.JSON, DataSet.Serialize, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, FireDAC.Comp.Client, Vcl.WinXPanels,
  Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons, untCadastrarEmpresa, System.Types,
  untEmpresas, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, Datasnap.DBClient, functions;

type
  TformListarEmpresas = class(TForm)
    Panel1: TPanel;
    pnlTitle: TPanel;
    Label2: TLabel;
    pnlContainer: TPanel;
    DBGrid: TDBGrid;
    Label1: TLabel;
    edSearch: TEdit;
    pnlSearch: TPanel;
    Panel5: TPanel;
    btnSelect: TPanel;
    btnDelete: TPanel;
    btnEdit: TPanel;
    btnAdd: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteMouseEnter(Sender: TObject);
    procedure btnDeleteMouseLeave(Sender: TObject);
    procedure btnEditMouseEnter(Sender: TObject);
    procedure btnEditMouseLeave(Sender: TObject);
    procedure btnAddMouseEnter(Sender: TObject);
    procedure btnAddMouseLeave(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure edSearchChange(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure Panel2Click(Sender: TObject);
  private
    HTTP: TIdHTTP;
    MemTable: TFDMemTable;
    DataSource: TDataSource;
    formCadastrarEmpresa: TformCadastrarEmpresa;
    Empresa: TEmpresa;
    functions: TFunctions;

    procedure EditDBGrid;
    procedure SQL;
  public
    selecionado: boolean;
    mudarEstadoDBGrid: boolean;
  end;

var
  formListarEmpresas: TformListarEmpresas;

implementation

{$R *.dfm}

procedure TformListarEmpresas.btnAddClick(Sender: TObject);
begin
  try
    formCadastrarEmpresa := TformCadastrarEmpresa.Create(self);
    formCadastrarEmpresa.ShowModal;
  finally
    SQL;
    formCadastrarEmpresa.Free;
  end;
end;

procedure TformListarEmpresas.btnEditClick(Sender: TObject);
var
  I: Integer;
begin
  formCadastrarEmpresa := TformCadastrarEmpresa.Create(self);
  formCadastrarEmpresa.DadosEmpresa := TJSONObject.Create;

  formCadastrarEmpresa.IDAtualizarEmpresa := DBGrid.Columns.Items[0].Field.AsInteger;

  for I := 1 to Pred(DBGrid.Columns.Count) do
  begin
    formCadastrarEmpresa.DadosEmpresa.AddPair(
      DBGrid.Columns.Items[I].FieldName, DBGrid.Columns.Items[I].Field.AsString);
  end;

  formCadastrarEmpresa.Show;
end;

procedure TformListarEmpresas.SQL;
begin
  try
    MemTable.Close;

    MemTable.LoadFromJSON(HTTP.Get('http://localhost:9000/empresas'));

    MemTable.FieldByName('id').Visible := false;

    functions.FitGrid(DBGrid);
    EditDBGrid;
  except
    abort;
  end;
end;

procedure TformListarEmpresas.DBGridDblClick(Sender: TObject);
begin
  if mudarEstadoDBGrid then
    btnSelectClick(Self)
  else
    btnEditClick(Self);
end;

procedure TformListarEmpresas.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if MemTable.FieldByName('numero').AsInteger > 500 then
  begin
    dbgrid.Canvas.Brush.Color := clGreen;
    dbgrid.DefaultDrawDataCell(Rect, dbgrid.columns[datacol].field, State);
  end;
end;

procedure TformListarEmpresas.EditDBGrid;
begin
  DBGrid.Columns[0].Title.Caption := 'Raz�o Social';
  DBGrid.Columns[1].Title.Caption := 'Nome Fantasia';
  DBGrid.Columns[2].Title.Caption := 'CPF/CNPJ';
  DBGrid.Columns[3].Title.Caption := 'Inscri��o Estadual';
  DBGrid.Columns[4].Title.Caption := 'Telefone';
  DBGrid.Columns[5].Title.Caption := 'CEP';
  DBGrid.Columns[6].Title.Caption := 'Logradouro';
  DBGrid.Columns[7].Title.Caption := 'N�mero';
  DBGrid.Columns[8].Title.Caption := 'Bairro';
  DBGrid.Columns[9].Title.Caption := 'Cidade';
  DBGrid.Columns[10].Title.Caption := 'Estado';
end;

procedure TformListarEmpresas.edSearchChange(Sender: TObject);
begin
  MemTable.Filtered := false;
  MemTable.Filter := 'razaosocial like ' + QuotedStr('%' + edSearch.Text + '%') + ' or' +
  ' nomefantasia like ' + QuotedStr('%' + edSearch.Text + '%');
  MemTable.Filtered := true;
end;

procedure TformListarEmpresas.FormCreate(Sender: TObject);
begin
  functions := TFunctions.Create;
  HTTP := TIdHTTP.Create(nil);
  MemTable := TFDMemTable.Create(nil);
  DataSource := TDataSource.Create(nil);

  DataSource.DataSet := MemTable;
  DBGrid.DataSource := DataSource;

  mudarEstadoDBGrid := true;

  SQL;
end;

procedure TformListarEmpresas.FormShow(Sender: TObject);
begin
  SQL;
end;

procedure TformListarEmpresas.Panel2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TformListarEmpresas.btnDeleteClick(Sender: TObject);
var
  Confirmacao: integer;
begin
  Confirmacao := Application.MessageBox('Deseja realmente excluir a empresa?', 'Confirma��o', MB_ICONINFORMATION + MB_YESNO);

  if Confirmacao = ID_YES then
  begin
    HTTP.Delete('http://localhost:9000/empresas/deletar/' + DBGrid.Columns.Items[0].Field.AsString);
    SQL;
  end;
end;

procedure TformListarEmpresas.btnExitClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TformListarEmpresas.btnAddMouseEnter(Sender: TObject);
begin
  btnAdd.Color := clBlack;
end;

procedure TformListarEmpresas.btnAddMouseLeave(Sender: TObject);
begin
  btnAdd.Color := $0009770E;
end;

procedure TformListarEmpresas.btnDeleteMouseEnter(Sender: TObject);
begin
  btnDelete.Color := clBlack;
end;

procedure TformListarEmpresas.btnDeleteMouseLeave(Sender: TObject);
begin
  btnDelete.Color := $00000095;
end;

procedure TformListarEmpresas.btnSelectClick(Sender: TObject);
begin
  selecionado := true;
  Self.Close;
end;

procedure TformListarEmpresas.btnEditMouseEnter(Sender: TObject);
begin
  btnEdit.Color := clBlack;
end;

procedure TformListarEmpresas.btnEditMouseLeave(Sender: TObject);
begin
  btnEdit.Color := $00787307;
end;

end.
