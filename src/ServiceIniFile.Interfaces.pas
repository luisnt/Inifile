unit ServiceIniFile.Interfaces;

interface

uses System.Classes, System.IniFiles;

Type
   iIniFile = interface
      ['{DC2A6BCF-3FAB-4D9E-9D7B-1E020FDF6775}']

      function getFilename: string;

      procedure Close;
      function Open: TIniFile;

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

implementation

end.
