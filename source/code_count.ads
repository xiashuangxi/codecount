with Ada.Text_IO;
with Ada.Integer_Text_IO;

package Code_Count is

    type CodeMate is private;
    type TotalCodeMate is private;
    
    procedure Skip_Space (Line : String; 
                        Offset : in out Integer);
    -- 跳过空格
    -- @pram Line 字符串
    -- @pram Offset 偏移量

    procedure Print_Core_Count (Count_Ident : String; 
                            Count : Integer; 
                            Number_Of_New_Lines : Ada.Text_IO.Count );
    -- 打印行数信息
    -- @param Count_Ident 说明
    -- @param Count 行数
    -- @param Number_Of_New_Lines 换行数

    procedure Read (FileName : String;
                CM: in out CodeMate;
                TM: in out TotalCodeMate);
    -- 开始读取源码

    procedure Print_To_File_Info(CM: in CodeMate);
    procedure Print_To_AllFile_Info(TM: in TotalCodeMate);

private

    File_Handle : Ada.Text_IO.File_Type;
    -- 文件操作对象

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