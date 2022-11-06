unit untMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Grids, Vcl.DBGrids, IdAuthentication,
  DataSet.Serialize, System.JSON, Vcl.Menus, Vcl.WinXPanels, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, untListarEmpresas, Vcl.Buttons, System.ImageList, Vcl.ImgList,
  Vcl.ControlList, Vcl.StdCtrls, Horse, Horse.Jhonson, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, untListarLotes, Vcl.ComCtrls, untListarContasPagar,
  relatorioContasPagar, untCadastrarProducao, untProducao;

type
  TformMain = class(TForm)
    pnlMenu: TPanel;
    Image1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Image2: TImage;
    pnlMenus: TPanel;
    pnlProcessos: TPanel;
    pnlCadastros: TPanel;
    Image3: TImage;
    Image4: TImage;
    Label3: TLabel;
    Label4: TLabel;
    pnlRelatorios: TPanel;
    Image5: TImage;
    Label2: TLabel;
    pnlCadastrosMenu: TPanel;
    menuContasPagar: TPanel;
    Label8: TLabel;
    menuLotes: TPanel;
    Label6: TLabel;
    menuEmpresa: TPanel;
    Label7: TLabel;
    pnlProcessosMenu: TPanel;
    pnlRelatoriosMenu: TPanel;
    menuRelatTempoLotes: TPanel;
    Label11: TLabel;
    menuRelatContasReceber: TPanel;
    Label12: TLabel;
    menuRelatContasPagar: TPanel;
    Label13: TLabel;
    btnEmpresas: TSpeedButton;
    btnLotes: TSpeedButton;
    btnContasPagar: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    menuControleProducao: TPanel;
    Label10: TLabel;
    SpeedButton1: TSpeedButton;
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnEmpresasClick(Sender: TObject);
    procedure btnLotesClick(Sender: TObject);
    procedure btnContasPagarClick(Sender: TObject);
    procedure SpeedButton4MouseEnter(Sender: TObject);
    procedure SpeedButton4MouseLeave(Sender: TObject);
    procedure SpeedButton5MouseEnter(Sender: TObject);
    procedure SpeedButton5MouseLeave(Sender: TObject);
    procedure SpeedButton6MouseEnter(Sender: TObject);
    procedure SpeedButton6MouseLeave(Sender: TObject);
    procedure btnEmpresasMouseLeave(Sender: TObject);
    procedure btnLotesMouseLeave(Sender: TObject);
    procedure btnContasPagarMouseLeave(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton1MouseLeave(Sender: TObject);
  private
    formContasPagar: TformContasPagar;
    formProducao: TformListarProducoes;
    pt: TPoint;
    panelPrevious: TPanel;

    procedure fecharTelas;
    procedure abrirMenus(panel: TPanel);
    procedure colorChangePainels(panel: TPanel);
  public
    { Public declarations }
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}

procedure TformMain.fecharTelas;
begin
  if formListarEmpresas <> nil then
    formListarEmpresas.close;

  if formListarLotes <> nil then
    formListarLotes.Close;

  if formContasPagar <> nil then
    formContasPagar.Close;
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  pnlMenu.Padding.Left := 100;
  pnlMenu.Padding.Right := 100;
  pnlMenu.Padding.Top := 100;
  pnlMenu.Padding.Bottom := 100;
  panelPrevious := TPanel.Create(Self);
end;

procedure TformMain.FormResize(Sender: TObject);
begin
  Self.Constraints.MinWidth := 1050;
end;

procedure TformMain.Image2Click(Sender: TObject);
begin
  if pnlMenus.Width = 180 then
    pnlMenus.Width := 57
  else
    pnlMenus.Width := 180;
end;

procedure TformMain.abrirMenus(panel: TPanel);
var
  I: Integer;
  pt: TPoint;
begin
  pnlCadastrosMenu.Visible := false;
  pnlProcessosMenu.Visible := false;
  pnlRelatoriosMenu.Visible := false;

  case panel.Tag of
    1:
    begin
      pnlCadastrosMenu.Left := pnlCadastros.Width;
      pnlCadastrosMenu.Visible := true;
    end;
    2:
    begin
      pnlProcessosMenu.Left := pnlProcessos.Width;
      pnlProcessosMenu.Top := 98;
      pnlProcessosMenu.Visible := true;
    end;
    3:
    begin
      pnlRelatoriosMenu.Left := pnlRelatorios.Width;
      pnlRelatoriosMenu.Top := 147;
      pnlRelatoriosMenu.Visible := true;
    end;
  end;
end;

procedure TformMain.colorChangePainels(panel: TPanel);
begin
  panelPrevious.Color := clGray;

  panel.Color := $004D4D4D;

  panelPrevious := panel;
end;

procedure TformMain.btnEmpresasClick(Sender: TObject);
begin
  fecharTelas;

  formListarEmpresas := TformListarEmpresas.Create(Self);

  formListarEmpresas.Parent := pnlMenu;

  pnlMenu.Padding.Top := 0;
  pnlMenu.Padding.Bottom := 0;
  pnlMenu.Padding.Left := 0;
  pnlMenu.Padding.Right := 0;

  formListarEmpresas.mudarEstadoDBGrid := false;
  formListarEmpresas.Show;

end;

procedure TformMain.btnEmpresasMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or (WindowFromPoint(Pt) = menuLotes.Handle) or (WindowFromPoint(Pt) = menuContasPagar.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnLotesClick(Sender: TObject);
begin
  fecharTelas;

  formListarEmpresas := TformListarEmpresas.Create(Self);
  formListarLotes := TformListarLotes.Create(self);

  formListarLotes.Parent := pnlMenu;

  pnlMenu.Padding.Top := 0;
  pnlMenu.Padding.Bottom := 0;
  pnlMenu.Padding.Left := 0;
  pnlMenu.Padding.Right := 0;

  formListarEmpresas.mudarEstadoDBGrid := true;
  formListarLotes.Show;
end;

procedure TformMain.btnLotesMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or (WindowFromPoint(Pt) = menuLotes.Handle) or (WindowFromPoint(Pt) = menuContasPagar.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.btnContasPagarClick(Sender: TObject);
begin
  fecharTelas;

  formContasPagar := TformContasPagar.Create(self);

  formContasPagar.Parent := pnlMenu;

  pnlMenu.Padding.Top := 0;
  pnlMenu.Padding.Bottom := 0;
  pnlMenu.Padding.Left := 0;
  pnlMenu.Padding.Right := 0;

//  formListarEmpresas.mudarEstadoDBGrid := false;
  formContasPagar.Show;
end;

procedure TformMain.btnContasPagarMouseLeave(Sender: TObject);
begin
  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or (WindowFromPoint(Pt) = menuLotes.Handle) or (WindowFromPoint(Pt) = menuContasPagar.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.SpeedButton1Click(Sender: TObject);
begin
  fecharTelas;

  formProducao := TformListarProducoes.Create(self);

  formProducao.Parent := pnlMenu;

  pnlMenu.Padding.Top := 0;
  pnlMenu.Padding.Bottom := 0;
  pnlMenu.Padding.Left := 0;
  pnlMenu.Padding.Right := 0;

  formProducao.Show;
end;

procedure TformMain.SpeedButton1MouseLeave(Sender: TObject);
begin
  pnlProcessos.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuControleProducao.Handle) then
    exit
  else
    pnlProcessosMenu.Visible := false;
end;

procedure TformMain.SpeedButton4MouseEnter(Sender: TObject);
begin
  pnlCadastros.Color := $00282800;
  abrirMenus(pnlCadastros);
end;

procedure TformMain.SpeedButton4MouseLeave(Sender: TObject);
begin
  pnlCadastros.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuEmpresa.Handle) or (WindowFromPoint(Pt) = menuLotes.Handle) or (WindowFromPoint(Pt) = menuContasPagar.Handle) then
    exit
  else
    pnlCadastrosMenu.Visible := false;
end;

procedure TformMain.SpeedButton5MouseEnter(Sender: TObject);
begin
  pnlProcessos.Color := $00282800;
  abrirMenus(pnlProcessos);
end;

procedure TformMain.SpeedButton5MouseLeave(Sender: TObject);
begin
  pnlProcessos.Color := $00404000;

  GetCursorPos(Pt);

  if WindowFromPoint(Pt) = menuControleProducao.Handle then
    exit
  else
    pnlProcessosMenu.Visible := false;
end;

procedure TformMain.SpeedButton6MouseEnter(Sender: TObject);
begin
  pnlRelatorios.Color := $00282800;
  abrirMenus(pnlRelatorios);
end;

procedure TformMain.SpeedButton6MouseLeave(Sender: TObject);
begin
  pnlRelatorios.Color := $00404000;

  GetCursorPos(Pt);

  if (WindowFromPoint(Pt) = menuRelatContasPagar.Handle) or (WindowFromPoint(Pt) = menuRelatContasReceber.Handle) or (WindowFromPoint(Pt) = menuRelatTempoLotes.Handle) then
    exit
  else
    pnlRelatoriosMenu.Visible := false;
end;

end.
