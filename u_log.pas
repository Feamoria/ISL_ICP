unit u_log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls;

type
  TFM_log = class(TForm)
    Memo_1: TMemo;
    mm1: TMainMenu;
    clear1: TMenuItem;
    procedure clear1Click(Sender: TObject);
  private
    { Private declarations }
  public
      procedure log(s:string);
    { Public declarations }
  end;

var
  FM_log: TFM_log;

implementation

procedure TFM_log.log(s: string);
begin
  FM_log.Memo_1.Lines.Add(DateTimeToStr(now())+'| '+s);
end;
{$R *.dfm}

procedure TFM_log.clear1Click(Sender: TObject);
begin
       Memo_1.Clear;
end;

end.

