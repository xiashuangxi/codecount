with Ada.Text_IO;
with Ada.Integer_Text_IO;

package Code_Count is

    type CodeMate is private;
    type TotalCodeMate is private;
    
    -- Code_Count/Skip_Space
    -- FUNCTION
    -- 跳过空格
    -- PARAMETERS
    -- Line   - 字符串
    -- Offset - 偏移量
    procedure Skip_Space 
        (Line : String; 
        Offset : in out Integer);

    -- Code_Count/Print_Core_Count
    -- FUNCTION
    -- 打印行数信息
    -- PARAMETERS
    -- Count_Ident          - 说明
    -- Count                - 行数
    -- Number_Of_New_Lines  - 换行数
    procedure Print_Core_Count 
        (Count_Ident : String; 
        Count : Integer; 
        Number_Of_New_Lines : Ada.Text_IO.Count );
    
    -- Code_Count/Read
    -- FUNCTION
    -- 开始读取源码
    -- PARAMETERS
    -- FileName - 文件名
    -- CM       - 当前文件的行数信息
    -- TM       - 所有文件的行数信息
    procedure Read 
        (FileName : String;
        CM: in out CodeMate;
        TM: in out TotalCodeMate);

    -- Code_Count/Print_To_File_Info
    -- FUNCTION
    -- 打印一个文件的信息
    -- PARAMETERS
    -- CM - 当前文件的行数信息
    procedure Print_To_File_Info(CM: in CodeMate);

    -- Code_Count/Print_To_File_Info
    -- FUNCTION
    -- 打印所有文件的信息
    -- PARAMETERS
    -- TM - 所有文件的行数信息
    procedure Print_To_AllFile_Info(TM: in TotalCodeMate);

private

    -- 文件操作对象
    File_Handle : Ada.Text_IO.File_Type;

    type CodeCountMate is
        record
            Line_Count : Integer := 0;
            Code_Count : Integer := 0;
            Comment_Count : Integer := 0;
            Null_Count : Integer := 0;
        end record;

    type CodeMate is access all CodeCountMate;
    type TotalCodeMate is access all CodeCountMate;

    TCM : TotalCodeMate := new CodeCountMate'(0,0,0,0);
end Code_Count;