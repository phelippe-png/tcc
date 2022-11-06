program VBASistema;

uses
  Vcl.Forms,
  untMain in 'src\untMain.pas' {formMain},
  untListarEmpresas in 'src\Cadastros\Empresas\untListarEmpresas.pas' {formListarEmpresas},
  untCadastrarEmpresa in 'src\Cadastros\Empresas\untCadastrarEmpresa.pas' {formCadastrarEmpresa},
  untListarLotes in 'src\Cadastros\Lotes\untListarLotes.pas' {formListarLotes},
  untEmpresas in 'src\Cadastros\Empresas\untEmpresas.pas',
  untCadastrarLote in 'src\Cadastros\Lotes\untCadastrarLote.pas' {formCadastrarLote},
  untLotes in 'src\Cadastros\Lotes\untLotes.pas',
  functions in 'src\functions.pas',
  untListarContasPagar in 'src\Cadastros\Contas a Pagar\untListarContasPagar.pas' {formContasPagar},
  untCadastrarContaPagar in 'src\Cadastros\Contas a Pagar\untCadastrarContaPagar.pas' {formCadastrarConta},
  untContasPagar in 'src\Cadastros\Contas a Pagar\untContasPagar.pas',
  relatorioContasPagar in 'src\Relatórios\relatorioContasPagar.pas' {formRelatContasPagar},
  untModalValorPago in 'src\Cadastros\Contas a Pagar\untModalValorPago.pas' {formModal},
  untProducao in 'src\Processo\untProducao.pas' {formListarProducoes},
  untCadastrarProducao in 'src\Processo\untCadastrarProducao.pas' {formCadastrarProducao},
  untProducaoClass in 'src\Processo\untProducaoClass.pas';

//  untClasseEmpresas in 'src\Cadastros\Clientes\untClasseEmpresas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
