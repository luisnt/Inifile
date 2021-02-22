unit ServiceIniFile;

interface

uses
   ServiceIniFile.Interfaces, System.SysUtils, System.StrUtils, System.IniFiles, System.Classes;

type
   TIniFile = class(TInterfacedObject, iIniFile)
      class function New(AFileName: string; ASessionIniBaseName: string = ''): iIniFile;
      constructor Create(AFileName: string; ASessionIniBaseName: string = '');
      destructor Destroy; override;

      strict private
         FSessionIniBaseName: string;
         FFilename          : string;
         FIniFile           : System.IniFiles.TIniFile;

         function getFilename: string;
         function SessionName(const ASessionIniName: string): string;
      private

         procedure Close;
         function Open: System.IniFiles.TIniFile;

      protected

      public
         function Exists(const Section: String): Boolean; overload;
         function Exists(const Section, Propertie: String): Boolean; overload;

         function Read(const Section, Propertie, Default: string): string; overload;
         function Read(const Section, Propertie: string; Default: TStream): Integer; overload;
         function Read(const Section, Propertie: string; Default: Boolean): Boolean; overload;
         function Read(const Section, Propertie: string; Default: TDateTime): TDateTime; overload;
         function Read(const Section, Propertie: string; Default: TDate): TDate; overload;
         function Read(const Section, Propertie: string; Default: Double): Double; overload;
         function Read(const Section, Propertie: string; Default: Integer): Integer; overload;
         function Read(const Section, Propertie: string; Default: TTime): TTime; overload;

         procedure Write(const Section, Propertie, Value: String); overload;
         procedure Write(const Section, Propertie: string; Value: TStream); overload;
         procedure Write(const Section, Propertie: string; Value: Boolean); overload;
         procedure Write(const Section, Propertie: string; Value: TDateTime); overload;
         procedure Write(const Section, Propertie: string; Value: TDate); overload;
         procedure Write(const Section, Propertie: string; Value: Double); overload;
         procedure Write(const Section, Propertie: string; Value: Integer); overload;
         procedure Write(const Section, Propertie: string; Value: TTime); overload;

         procedure Delete(const Section: string); overload;
         procedure Delete(const Section, Propertie: String); overload;

         property Filename: string read getFilename;
   end;

function IniFile(const AFileName: string = ''): iIniFile;
function IniFileConfig(const AName: string = 'config'): iIniFile; overload;

implementation

function IniFile(const AFileName: string = ''): iIniFile;
begin
   Result := TIniFile.New(AFileName);
end;

function IniFileConfig(const AName: string = 'config'): iIniFile;
begin
   Result := TIniFile.New(ExtractFilePath(ParamStr(0)) + AName + '.ini', ChangeFileExt(ExtractFileName(ParamStr(0)), EmptyStr));
end;

class function TIniFile.New(AFileName: string; ASessionIniBaseName: string = ''): iIniFile;
begin
   Result := Self.Create(AFileName, ASessionIniBaseName);
end;

{ TIniFile }

constructor TIniFile.Create(AFileName: string; ASessionIniBaseName: string = '');
begin
   FFilename           := IFThen(not SameStr(AFileName, EmptyStr), AFileName, ChangeFileExt(ParamStr(0), '.ini'));
   FIniFile            := System.IniFiles.TIniFile.Create(Filename);
   FSessionIniBaseName := IFThen(not SameStr(ASessionIniBaseName, EmptyStr), ASessionIniBaseName, EmptyStr);
end;

destructor TIniFile.Destroy;
begin
   FIniFile.DisposeOf;
   FIniFile := nil;
   inherited;
end;

function TIniFile.getFilename: string;
begin
   Result := FFilename;
end;

function TIniFile.Open: System.IniFiles.TIniFile;
begin
   Result := FIniFile;
end;

procedure TIniFile.Close;
begin
   FIniFile.UpdateFile;
end;

function TIniFile.SessionName(const ASessionIniName: string): string;
begin
   Result := IFThen(SameStr(FSessionIniBaseName, EmptyStr), ASessionIniName, FSessionIniBaseName + '\' + ASessionIniName);
end;

{ TIniFile.Exists() }
function TIniFile.Exists(const Section: String): Boolean;
begin
   try
      Result := Open.SectionExists(SessionName(Section));
   finally
      Close;
   end;
end;

function TIniFile.Exists(const Section, Propertie: String): Boolean;
begin
   try
      Result := Open.ValueExists(SessionName(Section), Propertie);
   finally
      Close;
   end;
end;

{ TIniFile.Read() }
function TIniFile.Read(const Section, Propertie, Default: string): string;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadString(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

function TIniFile.Read(const Section, Propertie: string; Default: Double): Double;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadFloat(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

function TIniFile.Read(const Section, Propertie: string; Default: Integer): Integer;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadInteger(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

function TIniFile.Read(const Section, Propertie: string; Default: TTime): TTime;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadTime(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

function TIniFile.Read(const Section, Propertie: string; Default: TDate): TDate;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadDate(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

function TIniFile.Read(const Section, Propertie: string; Default: TStream): Integer;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadBinaryStream(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

function TIniFile.Read(const Section, Propertie: string; Default: Boolean): Boolean;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadBool(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

function TIniFile.Read(const Section, Propertie: string; Default: TDateTime): TDateTime;
begin
   if not Exists(Section, Propertie) then
      write(Section, Propertie, Default);
   try
      Result := Open.ReadDateTime(SessionName(Section), Propertie, Default);
   finally
      Close;
   end;
end;

{ TIniFile.Write() }
procedure TIniFile.Write(const Section, Propertie, Value: String);
begin
   try
      Open.WriteString(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

procedure TIniFile.Write(const Section, Propertie: string; Value: Double);
begin
   try
      Open.WriteFloat(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

procedure TIniFile.Write(const Section, Propertie: string; Value: Integer);
begin
   try
      Open.WriteInteger(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

procedure TIniFile.Write(const Section, Propertie: string; Value: TTime);
begin
   try
      Open.WriteTime(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

procedure TIniFile.Write(const Section, Propertie: string; Value: TDate);
begin
   try
      Open.WriteDate(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

procedure TIniFile.Write(const Section, Propertie: string; Value: TStream);
begin
   try
      Open.WriteBinaryStream(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

procedure TIniFile.Write(const Section, Propertie: string; Value: Boolean);
begin
   try
      Open.WriteBool(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

procedure TIniFile.Write(const Section, Propertie: string; Value: TDateTime);
begin
   try
      Open.WriteDateTime(SessionName(Section), Propertie, Value);
   finally
      Close;
   end;
end;

{ TIniFile.Delete() }
procedure TIniFile.Delete(const Section: string);
begin
   try
      Open.EraseSection(SessionName(Section));
   finally
      Close;
   end;
end;

procedure TIniFile.Delete(const Section, Propertie: String);
begin
   try
      Open.DeleteKey(SessionName(Section), Propertie);
   finally
      Close;
   end;
end;

end.
