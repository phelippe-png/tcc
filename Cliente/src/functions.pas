unit functions;

interface

uses
  Vcl.Controls, Winapi.Windows, Winapi.Messages, Vcl.DBGrids, Data.DB;

type
  TFunctions = class
  private

  public
    procedure DrawControl(Control: TWinControl);
    procedure FitGrid(const Grid: TDBGrid; const CoverWhiteSpace: Boolean = True);
  end;

implementation

procedure TFunctions.DrawControl(Control: TWinControl);
var
  R: TRect;
  Rgn: HRGN;
begin
  with Control do
  begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 5, 5) ;
    Perform(EM_GETRECT, 0, lParam(@r)) ;
    InflateRect(r, - 4, - 4) ;
    Perform(EM_SETRECTNP, 0, lParam(@r)) ;
    SetWindowRgn(Handle, rgn, True) ;
    Invalidate;
  end;
end;

procedure TFunctions.FitGrid(const Grid: TDBGrid; const CoverWhiteSpace: Boolean = True);
const
  C_Add=3;
var
  DS: TDataSet;
  BM: TBookmark;
  I, W, VisibleColumnsCount: Integer;
  A: array of Integer;
  VisibleColumns: array of TColumn;
begin
  DS := Grid.DataSource.DataSet;
  if Assigned(DS) then
  begin
    VisibleColumnsCount := 0;
    SetLength(VisibleColumns, Grid.Columns.Count);
    for I := 0 to Grid.Columns.Count - 1 do
      if Assigned(Grid.Columns[I].Field) and (Grid.Columns[I].Visible) then
      begin
        VisibleColumns[VisibleColumnsCount] := Grid.Columns[I];
        Inc(VisibleColumnsCount);
      end;
    SetLength(VisibleColumns, VisibleColumnsCount);

    DS.DisableControls;
    BM := DS.GetBookmark;
    try
      DS.First;
      SetLength(A, VisibleColumnsCount);
      while not DS.Eof do
      begin
        for I := 0 to VisibleColumnsCount - 1 do
        begin
            W :=  Grid.Canvas.TextWidth(DS.FieldByName(VisibleColumns[I].Field.FieldName).DisplayText);
            if A[I] < W then
               A[I] := W;
        end;
        DS.Next;
      end;
      //if fieldwidth is smaller than Row 0 (field names) fix
      for I := 0 to VisibleColumnsCount - 1 do
      begin
        W := Grid.Canvas.TextWidth(VisibleColumns[I].Field.FieldName);
        if A[I] < W then
           A[I] := W;
      end;

      W := 0;
      if CoverWhiteSpace then
      begin
        for I := 0 to VisibleColumnsCount - 1 do
          Inc(W, A[I] + C_Add);
        W := (Grid.ClientWidth - W - 5) div VisibleColumnsCount;
        if W < 0 then
          W := 0;
      end;

      for I := 0 to VisibleColumnsCount - 1 do
        VisibleColumns[I].Width := A[I] + C_Add + W;
      DS.GotoBookmark(BM);
    finally
      DS.FreeBookmark(BM);
      DS.EnableControls;
    end;
  end;
end;

end.
