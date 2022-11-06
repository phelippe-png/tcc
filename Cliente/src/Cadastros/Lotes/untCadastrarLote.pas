unit untCadastrarLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, untLotes, untListarEmpresas, untEmpresas;

type
  TformCadastrarLote = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    btnSave: TPanel;
    btnCancel: TPanel;
    Label2: TLabel;
    edCodigo: TEdit;
    Panel1: TPanel;
    edOP: TEdit;
    Label1: TLabel;
    edDescricao: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edDataEnt: TDateTimePicker;
    edDataSaida: TDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    edQuantidade: TEdit;
    Label7: TLabel;
    edValorUnit: TEdit;
    edValorTotal: TEdit;
    Label8: TLabel;
    edTempoMin: TEdit;
    Label9: TLabel;
    edEmpresa: TEdit;
    Label10: TLabel;
    SpeedButton1: TSpeedButton;
    procedure btnSaveMouseEnter(Sender: TObject);
    procedure btnSaveMouseLeave(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    Lotes: TLotes;
    Empresa: TEmpresa;
    Empresas: TformListarEmpresas;
    IDEmpresaSelecionada: integer;
  public
    { Public declarations }
  end;

var
  formCadastrarLote: TformCadastrarLote;

implementation

{$R *.dfm}

procedure TformCadastrarLote.btnSaveClick(Sender: TObject);
var
  resultadoTempoTotal: Double;
begin
  resultadoTempoTotal := StrToFloat(edTempoMin.Text) * StrToInt(edQuantidade.Text);

  Lotes := TLotes.Create;
  Empresa := TEmpresa.Create;

  Empresa.RazaoSocial := edEmpresa.Text;

  Lotes.IDEmpresa := IDEmpresaSelecionada;
  Lotes.Codigo := StrToInt(edCodigo.Text);
  Lotes.OP := StrToInt(edOP.Text);
  Lotes.Descricao := edDescricao.Text;
  Lotes.Empresa := Empresa;
//  Lotes.DataEntrada := edDataEnt.Date;
  Lotes.Quantidade := StrToInt(edQuantidade.Text);
  Lotes.ValorUnit := StrToCurr(edValorUnit.Text);
  Lotes.ValorTotal := StrToCurr(edValorTotal.Text);
  Lotes.TempoMin := StrToFloat(edTempoMin.Text);
  Lotes.tempoTotal := resultadoTempoTotal;

  Application.MessageBox(PWideChar(Lotes.cadastrarDados), 'Confirmação', MB_ICONINFORMATION + MB_OK);
end;

procedure TformCadastrarLote.btnSaveMouseEnter(Sender: TObject);
begin
  btnSave.Color := clBlack;
end;

procedure TformCadastrarLote.btnSaveMouseLeave(Sender: TObject);
begin
  btnSave.Color := $0007780B;
end;

procedure TformCadastrarLote.SpeedButton1Click(Sender: TObject);
begin
  Empresas := TformListarEmpresas.Create(self);

  Empresas.WindowState := TWindowState.wsNormal;
  Empresas.BorderStyle := bsSingle;
  Empresas.Align := alNone;
  Empresas.btnSelect.Visible := true;

  Empresas.ShowModal;

  if Empresas.selecionado then
  begin
    edEmpresa.Text := Empresas.DBGrid.Columns.Items[1].Field.Value;
    IDEmpresaSelecionada := Empresas.DBGrid.DataSource.DataSet.FieldByName('id').AsInteger;
  end;
end;

end.
