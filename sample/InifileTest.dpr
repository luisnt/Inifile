program InifileTest;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils
    , ServiceInifile
    ;

const 
  DEFAULT_IP_VALUE = '127.0.0.1';

var
  value : string;
begin
  ReportMemoryLeaksOnShutdown := true;

  try
    value :=  IniFile.Read('SESSION', 'Property-ip', DefaultValue{ OPTIONAL }); 
    WriteLn('value: ', value);

    value :=  IniFile.Write('SESSION', 'Property', 'xpto'); 
    WriteLn('value: ', value);

    value :=  IniFile.Read('SESSION', 'Property-Xpto', 'DefaultValue'{ OPTIONAL }); 
    WriteLn('value: ', value);

    ReadLn;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
