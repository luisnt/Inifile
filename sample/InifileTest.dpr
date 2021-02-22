program InifileTest;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils,
  ServiceInifile;

const
  DEFAULT_IP_VALUE   = '127.0.0.1';
  DEFAULT_XPTO_VALUE = 'Default Value';

var
  value: string;

begin
  ReportMemoryLeaksOnShutdown := true;
  try
    value := IniFile.Read('SESSION', 'Property-ip', DEFAULT_IP_VALUE { OPTIONAL } );
    WriteLn('ip: ', value);

    IniFile.Write('SESSION', 'Property-Xpto', 'xpto');
    value := IniFile.Read('SESSION', 'Property-Xpto', DEFAULT_XPTO_VALUE { OPTIONAL } );
    WriteLn('outer value: ', value);

    ReadLn;
  except
    on E: Exception do
      WriteLn(E.ClassName, ': ', E.Message);
  end;

end.
