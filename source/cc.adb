with Ada.Command_Line;
with Ada.Text_IO;
with Code_Count; use Code_Count;

-- CC
procedure Cc is
    CM : Code_Count.CodeMate;
    TM : Code_Count.TotalCodeMate;
begin

    if Ada.Command_Line.Argument_Count < 1 then
        Ada.Text_IO.Put_Line("command use: ./cc <file 1> <file 1>");
    else
        for cac in 1 .. Ada.Command_Line.Argument_Count loop
            Code_Count.Read(
                Ada.Command_Line.Argument(cac),
                CM,
                TM);
            Ada.Text_IO.Put_Line("File Name: " & Ada.Command_Line.Argument(cac));
            Code_Count.Print_To_File_Info(CM);
        end loop;

        Ada.Text_IO.New_Line(1);
        
        Code_Count.Print_To_AllFile_Info(TM);
        
    end if;
end Cc;