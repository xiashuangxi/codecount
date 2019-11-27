package body Code_Count is

    ----------------
    -- Skip_Space --
    ----------------

    procedure Skip_Space (Line : String; Offset : in out Integer) is
    begin
        while Line(Offset) = ' ' or Character'Pos(Line(Offset)) = 9 loop
            Offset := Offset + 1;
        end loop;
    end Skip_Space;

    ----------------------
    -- Print_Core_Count --
    ----------------------

    procedure Print_Core_Count (Count_Ident : String; Count : Integer; Number_Of_New_Lines : Ada.Text_IO.Count ) is
    begin
        Ada.Text_IO.Put(Count_Ident);
        Ada.Integer_Text_IO.Put(Count,0);
        Ada.Text_IO.New_Line(Number_Of_New_Lines);
    end Print_Core_Count;

    procedure Print_To_File_Info(CM: in CodeMate) is
    begin
        Print_Core_Count("Line Count: ", CM.Line_Count, 1);
        Print_Core_Count("Code Count: ", CM.Code_Count, 1);
        Print_Core_Count("Comment Count: ", CM.Comment_Count, 1);
        Print_Core_Count("Null Count: ", CM.Null_Count, 1);
    end Print_To_File_Info;

    procedure Print_To_AllFile_Info(TM: in TotalCodeMate) is
    begin
        Print_Core_Count("Total Line Count: ", TM.Line_Count, 1);
        Print_Core_Count("Total Code Count: ", TM.Code_Count, 1);
        Print_Core_Count("Total Comment Count: ", TM.Comment_Count, 1);
        Print_Core_Count("Total Null Count: ", TM.Null_Count, 1);
    end Print_To_AllFile_Info;

    ----------
    -- Read --
    ----------

    procedure Read (FileName : String;
                CM: in out CodeMate;
                TM: in out TotalCodeMate) is
        
    begin
        CM := new CodeCountMate'(0,0,0,0);
        TM := TCM;
        Ada.Text_IO.Open(
            File_Handle,
            Ada.Text_IO.In_File,
            FileName
        );

        while not Ada.Text_IO.End_Of_File(File_Handle) loop
            CM.Line_Count := CM.Line_Count + 1;

            
            declare 
                Line_String : String := Ada.Text_IO.Get_Line(File_Handle);
                Index : Integer := 1;
            begin
                begin
                    Skip_Space(Line_String, Index);
                    if Line_String(Index .. Index + 1) = "--" then
                        CM.Comment_Count := CM.Comment_Count + 1;
                    else
                        CM.Code_Count := CM.Code_Count + 1;
                    end if;
                exception
                    when Constraint_Error =>
                        CM.Null_Count := CM.Null_Count + 1;
                end;
            end;

            
        end loop;
        Ada.Text_IO.Close(File_Handle);
        TM.Line_Count := TM.Line_Count + CM.Line_Count;
        TM.Code_Count := TM.Code_Count + CM.Code_Count;
        TM.Comment_Count := TM.Comment_Count + CM.Comment_Count;
        TM.Null_Count := TM.Null_Count + CM.Null_Count;
    end Read;

end Code_Count;