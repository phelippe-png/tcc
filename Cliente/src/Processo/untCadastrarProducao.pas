unit untCadastrarProducao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, untListarEmpresas, Vcl.ComCtrls,
  System.ImageList, Vcl.ImgList, untListarLotes, Datasnap.DBClient, functions,
  Vcl.Imaging.pngimage, untProducaoClass, System.JSON, IdHTTP, DataSet.Serialize;

type
  TformCadastrarProducao = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    pickerInicio: TDateTimePicker;
    pickerFinal: TDateTimePicker;
    btnCancel: TPanel;
    btnSave: TPanel;
    Label7: TLabel;
    lblRazao: TLabel;
    lblFantasia: TLabel;
    Label6: TLabel;
    Panel4: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ImageList1: TImageList;
    Label8: TLabel;
    lblValorTotal: TLabel;
    lblTempo: TLabel;
    Label11: TLabel;
    Image1: TImage;
    Label5: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    quantTotal: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    quantProduzir: TLabel;
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
  private
    DataSource: TDataSource;
    ClientDataSet: TClientDataSet;
    http: TIdHTTP;

    idProducao: integer;
    idEmpresa: integer;
    empresa: string;
    functions: TFunctions;
    untEmpresas: TformListarEmpresas;
    untLotes: TformListarLotes;
    classProducao: TProducao;
    resultadoQuantidade: integer;
    resultadoQuantidadeProduzir: integer;
    resultadoValor: Currency;
    resultadoTempo: Double;
    arrayLotesAdicionados: TJSONArray;
    arrayLotesAtualizados: TJSONArray;
    arrayLotesExcluidos: TJSONArray;

    procedure calcularTotais;
    procedure editarTitlesDBGrid;
    procedure inserirStatus;
  public
    editar: boolean;

    function buscarDados(id: integer; tabelaBanco, campo: string): string;
    procedure carregarDados(jsonDados: TJSONObject);
  end;

var
  formCadastrarProducao: TformCadastrarProducao;

implementation

{$R *.dfm}

procedure TformCadastrarProducao.Image1Click(Sender: TObject);
begin
  untEmpresas := TformListarEmpresas.Create(Self);
  untEmpresas.mudarEstadoDBGrid := true;
  untEmpresas.BorderStyle := bsSingle;
  untEmpresas.Align := alNone;
  untEmpresas.ShowModal;

  if untEmpresas.selecionado then
  begin
    idEmpresa := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;
    empresa := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('razaosocial').AsString;
    lblRazao.Caption := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('razaosocial').AsString;
    lblFantasia.Caption := untEmpresas.DBGrid.DataSource.DataSet.FieldByName('nomefantasia').AsString;
  end;
end;

procedure TformCadastrarProducao.inserirStatus;
begin
  ClientDataSet.First;
  while not ClientDataSet.Eof do
  begin
    if ClientDataSet.FieldByName('finalizado').AsBoolean then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('status').AsString := 'CONCLU�DO';
      ClientDataSet.Post;
    end;

    if ClientDataSet.FieldByName('finalizado').AsBoolean = false then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('status').AsString := 'EM PRODU��O';
      ClientDataSet.Post;
    end;

    ClientDataSet.Next;
  end;
end;

procedure TformCadastrarProducao.btnSaveClick(Sender: TObject);
var
  I: Integer;
begin
  if idEmpresa = 0 then
  begin
    Application.MessageBox('Selecione uma empresa!', 'Aten��o', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if (pickerInicio.Date < Date) or ((pickerFinal.Date < Date) or (pickerFinal.Date < pickerInicio.Date)) then
  begin
    Application.MessageBox('As datas informadas s�o inv�lidas!', 'Aten��o', MB_ICONWARNING + MB_OK);
    exit;
  end;

  if ClientDataSet.RecordCount = 0 then
  begin
    Application.MessageBox('Selecione pelo menos um lote na produ��o!', 'Aten��o', MB_ICONWARNING + MB_OK);
    exit;
  end;

  classProducao := TProducao.Create;
  classProducao.idProducao := idProducao;
  classProducao.idEmpresa := idEmpresa;
  classProducao.empresa := empresa;
  classProducao.dataInicio := pickerInicio.Date;
  classProducao.dataFinal := pickerFinal.Date;
  classProducao.quantidadeTotal := resultadoQuantidade;
  classProducao.quantidadeProduzir := resultadoQuantidadeProduzir;
  classProducao.valorTotal := resultadoValor;
  classProducao.tempoTotal := resultadoTempo;

  try
    if editar then
      classProducao.modo := 'editar';

    classProducao.enviarDadosProducao;

    for I := 0 to arrayLotesAdicionados.Count - 1 do
    begin
      classProducao.modo := 'adicionar';
      classProducao.idLote := arrayLotesAdicionados.Get(I).GetValue<integer>('id_lote');
      classProducao.finalizado := arrayLotesAdicionados.Get(I).GetValue<boolean>('finalizado');
      classProducao.enviarDadosCorpoProducao;
    end;

    for I := 0 to arrayLotesAtualizados.Count - 1 do
    begin
      classProducao.modo := 'editar';
      classProducao.idLote := arrayLotesAtualizados.Get(I).GetValue<integer>('id_lote');
      classProducao.finalizado := arrayLotesAtualizados.Get(I).GetValue<boolean>('finalizado');
      classProducao.idCorpoProducao := arrayLotesAtualizados.Get(I).GetValue<integer>('id_corpoproducao');
      classProducao.enviarDadosCorpoProducao;
    end;

    for I := 0 to arrayLotesExcluidos.Count - 1 do
    begin
      classProducao.modo := 'excluir';
      classProducao.idCorpoProducao := arrayLotesExcluidos.Get(I).GetValue<integer>('id_corpoproducao');
      classProducao.enviarDadosCorpoProducao;
    end;
        
//    ClientDataSet.First;
//    for I := 0 to Pred(ClientDataSet.RecordCount) do
//    begin
//      classProducao.idCorpoProducao := ClientDataSet.FieldByName('id_corpoproducao').AsInteger;
//      classProducao.idLote := ClientDataSet.FieldByName('id').AsInteger;
//      classProducao.finalizado := ClientDataSet.FieldByName('id').AsBoolean;
//      classProducao.enviarDadosCorpoProducao;
//
//      ClientDataSet.Next;
//    end;

    Application.MessageBox('Cadastro efetuado com sucesso.', 'Confirma��o', MB_ICONINFORMATION + MB_OK);

    Self.Close;
  except
    Application.MessageBox('Erro ao cadastrar produ��o!', 'Confirma��o', MB_ICONINFORMATION + MB_OK);
  end;
end;

function TformCadastrarProducao.buscarDados(id: integer; tabelaBanco, campo: string): string;
begin
  http.Request.CustomHeaders.Clear;
  http.Request.CustomHeaders.AddValue('id', IntToStr(id));
  http.Request.CustomHeaders.AddValue('tabelaBanco', tabelaBanco);
  http.Request.CustomHeaders.AddValue('campo', campo);
  result := http.Get('http://localhost:9000/producoes/producao');
end;

procedure TformCadastrarProducao.calcularTotais;
var
  I: Integer;
begin
  resultadoQuantidade := 0;
  resultadoValor := 0;
  resultadoTempo := 0;
  resultadoQuantidadeProduzir := 0;

  ClientDataSet.First;
  for I := 0 to ClientDataSet.RecordCount - 1 do
  begin
    resultadoQuantidade := resultadoQuantidade + ClientDataSet.FieldByName('quantidade').AsInteger;
    resultadoValor := resultadoValor + ClientDataSet.FieldByName('valor_total').AsCurrency;
    resultadoTempo := resultadoTempo + ClientDataSet.FieldByName('tempo_total').AsFloat;

    if ClientDataSet.FieldByName('finalizado').AsBoolean = false then
      resultadoQuantidadeProduzir := resultadoQuantidadeProduzir + ClientDataSet.FieldByName('quantidade').AsInteger;

    ClientDataSet.Next;
  end;

  quantTotal.Caption := IntToStr(resultadoQuantidade);
  quantProduzir.Caption := IntToStr(resultadoQuantidadeProduzir);
  lblValorTotal.Caption := FormatCurr('###,###,##0.00', resultadoValor);
  lblTempo.Caption := FormatFloat('###,##0.000', resultadoTempo);
end;

procedure TformCadastrarProducao.carregarDados(jsonDados: TJSONObject);
var
  idLote: integer;
  idCorpoProducao: integer;
  finalizado: boolean;

  jsonDadosEmpresa: TJSONObject;
  jsonCorpoProducao: TJSONArray;
  jsonLote: TJSONObject;
  I: Integer;
begin
  idEmpresa := jsonDados.GetValue<integer>('id_empresa');
  jsonDadosEmpresa := TJSONObject.Create;
  jsonDadosEmpresa := TJSONObject.ParseJSONValue(buscarDados(idEmpresa, 'tab_empresas', 'id')) as TJSONObject;

  idEmpresa := jsonDados.GetValue<integer>('id_empresa');
  empresa := jsonDadosEmpresa.GetValue<string>('razaosocial');

  lblRazao.Caption := jsonDadosEmpresa.GetValue<string>('razaosocial');
  lblFantasia.Caption := jsonDadosEmpresa.GetValue<string>('nomefantasia');
  pickerInicio.Date := StrToDate(jsonDados.GetValue<string>('data_inicio'));
  pickerFinal.Date := StrToDate(jsonDados.GetValue<string>('data_final'));

  idProducao := jsonDados.GetValue<integer>('id');
  jsonCorpoProducao := TJSONArray.Create;
  jsonCorpoProducao := TJSONObject.ParseJSONValue(buscarDados(idProducao, 'tab_controleproducao_corpo', 'id_producao')) as TJSONArray;

  jsonLote := TJSONObject.Create;
  for I := 0 to jsonCorpoProducao.Count - 1 do
  begin
    idLote := jsonCorpoProducao.Get(I).GetValue<integer>('idLote');
    idCorpoProducao := jsonCorpoProducao.Get(I).GetValue<integer>('id');
    finalizado := jsonCorpoProducao.Get(I).GetValue<boolean>('finalizado');
    
    jsonLote := TJSONObject.ParseJSONValue(buscarDados(idLote, 'tab_lotes', 'id')) as TJSONObject;

    ClientDataSet.Append;
    ClientDataSet.FieldByName('id_corpoproducao').AsInteger := idCorpoProducao;
    ClientDataSet.FieldByName('id_lote').AsInteger := jsonLote.GetValue<integer>('id');
    ClientDataSet.FieldByName('op').AsInteger := jsonLote.GetValue<integer>('op');
    ClientDataSet.FieldByName('descricao').AsString := jsonLote.GetValue<string>('descricao');
    ClientDataSet.FieldByName('quantidade').AsInteger := jsonLote.GetValue<integer>('quantidade');
    ClientDataSet.FieldByName('valor_unit').AsCurrency := jsonLote.GetValue<currency>('valorUnit');
    ClientDataSet.FieldByName('valor_total').AsCurrency := jsonLote.GetValue<currency>('valorTotal');
    ClientDataSet.FieldByName('tempo_min').AsFloat := jsonLote.GetValue<Double>('tempoMin');
    ClientDataSet.FieldByName('tempo_total').AsFloat := jsonLote.GetValue<Double>('tempoTotal');
    ClientDataSet.FieldByName('finalizado').AsBoolean := finalizado;
    ClientDataSet.Post;
  end;

  calcularTotais;
  inserirStatus;
end;

procedure TformCadastrarProducao.DBGridDblClick(Sender: TObject);
var
  jsonLote: TJSONObject;
  I: Integer;
begin
  if ClientDataSet.FieldByName('id_corpoproducao').AsInteger <> 0 then
  begin
    if ClientDataSet.FieldByName('status').AsString = 'EM PRODU��O' then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('status').AsString := 'CONCLU�DO';
      ClientDataSet.FieldByName('finalizado').AsBoolean := true;
      ClientDataSet.Post;
    end
    else if ClientDataSet.FieldByName('status').AsString = 'CONCLU�DO' then
    begin
      ClientDataSet.Edit;
      ClientDataSet.FieldByName('status').AsString := 'EM PRODU��O';
      ClientDataSet.FieldByName('finalizado').AsBoolean := false;
      ClientDataSet.Post;
    end;
  end;

  for I := 0 to arrayLotesAtualizados.Count - 1 do
  begin
    if arrayLotesAtualizados.Get(I).GetValue<integer>('id_lote') = ClientDataSet.FieldByName('id_lote').AsInteger then
    begin
      arrayLotesAtualizados.Remove(I);
      exit;
    end;
  end;

  jsonLote := TJSONObject.Create;
  jsonLote.AddPair('id_corpoproducao', ClientDataSet.FieldByName('id_corpoproducao').AsString);
  jsonLote.AddPair('id_lote', ClientDataSet.FieldByName('id_lote').AsString);
  jsonLote.AddPair('finalizado', BoolToStr(ClientDataSet.FieldByName('finalizado').AsBoolean));
  arrayLotesAtualizados.Add(jsonLote);
end;

procedure TformCadastrarProducao.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (ClientDataSet.FieldByName('finalizado').AsBoolean = false) and (Column.FieldName = 'status') then
  begin
    DBGrid.Canvas.Brush.Color := clWebOrange;
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
    exit;
  end;

  if (ClientDataSet.FieldByName('finalizado').AsBoolean) and (Column.FieldName = 'status') then
  begin
    DBGrid.Canvas.Brush.Color := clGreen;
    DBGrid.DefaultDrawDataCell(Rect, Column.Field, State);
    exit;
  end;
end;

procedure TformCadastrarProducao.editarTitlesDBGrid;
begin
  DBGrid.Columns.Items[0].Title.Caption := 'Status';
  DBGrid.Columns.Items[1].Title.Caption := 'ID';
  DBGrid.Columns.Items[2].Title.Caption := 'OP';
  DBGrid.Columns.Items[3].Title.Caption := 'Descri��o';
  DBGrid.Columns.Items[4].Title.Caption := 'Quantidade';
  DBGrid.Columns.Items[5].Title.Caption := 'Valor Unit�rio';
  DBGrid.Columns.Items[6].Title.Caption := 'Valor Total';
  DBGrid.Columns.Items[7].Title.Caption := 'Tempo Minutos';
  DBGrid.Columns.Items[8].Title.Caption := 'Tempo Total';
  functions.FitGrid(DBGrid);
end;

procedure TformCadastrarProducao.FormCreate(Sender: TObject);
begin
  arrayLotesAdicionados := TJSONArray.Create;
  arrayLotesAtualizados := TJSONArray.Create;
  arrayLotesExcluidos := TJSONArray.Create;
  http := TIdHTTP.Create(nil);

  ClientDataSet := TClientDataSet.Create(Self);
  ClientDataSet.FieldDefs.Add('status', ftString, 20);
  ClientDataSet.FieldDefs.Add('id_corpoproducao', ftInteger);
  ClientDataSet.FieldDefs.Add('id_lote', ftInteger);
  ClientDataSet.FieldDefs.Add('op', ftInteger);
  ClientDataSet.FieldDefs.Add('descricao', ftString, 40);
  ClientDataSet.FieldDefs.Add('quantidade', ftInteger);
  ClientDataSet.FieldDefs.Add('valor_unit', ftCurrency);
  ClientDataSet.FieldDefs.Add('valor_total', ftCurrency);
  ClientDataSet.FieldDefs.Add('tempo_min', ftFloat);
  ClientDataSet.FieldDefs.Add('tempo_total', ftFloat);
  ClientDataSet.FieldDefs.Add('finalizado', ftBoolean);
  ClientDataSet.CreateDataSet;

  DataSource := TDataSource.Create(Self);
  DataSource.DataSet := ClientDataSet;

  DBGrid.DataSource := DataSource;

  classProducao := TProducao.Create;

  ClientDataSet.FieldByName('id_corpoproducao').Visible := false;
  ClientDataSet.FieldByName('finalizado').Visible := false;

  editarTitlesDBGrid;
  calcularTotais;
end;

procedure TformCadastrarProducao.SpeedButton2Click(Sender: TObject);
var
  I: Integer;
  resultadoTempo: Double;
  jsonLote: TJSONObject;
begin
  untLotes := TformListarLotes.Create(Self);
  untLotes.BorderStyle := bsSingle;
  untLotes.Align := alNone;
  untLotes.btnSelect.Visible := true;
  untLotes.ShowModal;

  if untLotes.lib then
  begin
    for I := 0 to untLotes.DBGrid.SelectedRows.Count - 1 do
    begin
      untLotes.DBGrid.DataSource.DataSet.Bookmark := untLotes.DBGrid.SelectedRows.Items[I];

      ClientDataSet.Append;
      ClientDataSet.FieldByName('status').AsString := 'EM PRODU��O';
      ClientDataSet.FieldByName('id_lote').AsInteger := untLotes.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;
      ClientDataSet.FieldByName('op').AsInteger := untLotes.DBGrid.DataSource.DataSet.FieldByName('op').AsInteger;
      ClientDataSet.FieldByName('descricao').AsString := untLotes.DBGrid.DataSource.DataSet.FieldByName('descricao').AsString;
      ClientDataSet.FieldByName('quantidade').AsInteger := untLotes.DBGrid.DataSource.DataSet.FieldByName('quantidade').AsInteger;
      ClientDataSet.FieldByName('valor_unit').AsCurrency := untLotes.DBGrid.DataSource.DataSet.FieldByName('valor_unit').AsCurrency;
      ClientDataSet.FieldByName('valor_total').AsCurrency := untLotes.DBGrid.DataSource.DataSet.FieldByName('valor_total').AsCurrency;
      ClientDataSet.FieldByName('tempo_min').AsFloat := untLotes.DBGrid.DataSource.DataSet.FieldByName('tempo_min').AsFloat;
      ClientDataSet.FieldByName('tempo_total').AsFloat := untLotes.DBGrid.DataSource.DataSet.FieldByName('tempo_total').AsFloat;
      ClientDataSet.FieldByName('finalizado').AsBoolean := false;
      ClientDataSet.Post;

      jsonLote := TJSONObject.Create;
      jsonLote.AddPair('id_lote', IntToStr(untLotes.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger));
      jsonLote.AddPair('finalizado', BoolToStr(false));
      arrayLotesAdicionados.Add(jsonLote);
    end;

    calcularTotais;
    functions.FitGrid(DBGrid);
  end;
end;

procedure TformCadastrarProducao.SpeedButton3Click(Sender: TObject);
var
  I: Integer;
  jsonLote: TJSONObject;
begin
  if DBGrid.SelectedRows.Count > 0 then
  begin
    for I := 0 to DBGrid.SelectedRows.Count - 1 do
    begin
      ClientDataSet.Bookmark := DBGrid.SelectedRows.Items[I];

      jsonLote := TJSONObject.Create;
      jsonLote.AddPair('id_corpoproducao', ClientDataSet.FieldByName('id_corpoproducao').AsString);
      arrayLotesExcluidos.Add(jsonLote);

      DBGrid.DataSource.DataSet.Delete;
    end;
  end;
end;

end.
