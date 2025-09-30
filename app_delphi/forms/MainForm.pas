unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  PythonEngine, VarPyth, PyEngineService;

type
  TForm1 = class(TForm)
    BtnRun: TButton;
    Memo1: TMemo;
    procedure BtnRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Memo1.Lines.Add('App initialized');
end;

procedure TForm1.BtnRunClick(Sender: TObject);
var
  PyMain, PyRes: Variant;
  PathStr: string;
begin
  if (Memo1.Lines.Count > 0) and (Trim(Memo1.Lines[0]) <> '') then
    PathStr := Trim(Memo1.Lines[0])
  else
    PathStr := 'data/input/sample_points.txt';

  try
    PyEngine.EnsureReady;
    PyMain := Import('main');           // load app_py/main.py
    PyRes  := PyMain.main(PathStr);     // call ONLY main(path)
    Memo1.Lines.Add('---');
    Memo1.Lines.Add('Input path: ' + PathStr);
    Memo1.Lines.Add(VarToStr(PyRes));
  except
    on E: Exception do
    begin
      Memo1.Lines.Add('---');
      Memo1.Lines.Add('Delphi caught error: ' + E.ClassName + ': ' + E.Message);
    end;
  end;
end;


end.

