import std.getopt;
import std.stdio;
import std.process;

void writeToCppFile();
void setInstantiate(File);
void listInstantiate(File);
void vectorInstantiate(File);
void declareStruct();
void declareClass();

int vectorflag = 0;
int listflag = 0;
int setflag = 0;
int _class = 0;
int _struct = 0;
string class_name;
string struct_name;

void main(string[] args) {
    getopt(args, std.getopt.config.caseSensitive,
            "vflag|v", &vectorflag,
            "lflag|l", &listflag,
            "sflag|s", &setflag,
            "cl|C", &class_name,
            "str|S", &struct_name);

    if (class_name)
        _class = 1;
    if (struct_name)
        _struct = 1;

    writeToCppFile();
    executeShell("clang++ -c test.cpp");
}


void writeToCppFile()
{
    File cppfile;
    cppfile.open("test.cpp", "a");
    if (vectorflag)
        vectorInstantiate(cppfile);
    if (listflag)
        listInstantiate(cppfile);
    if (setflag)
        setInstantiate(cppfile);
    return;
}

void vectorInstantiate(File file)
{
    file.writeln("\n");
    if (_class)
        declareClass(file);
        file.writeln("template class std::vector<", class_name, ">;\n");
    if (_struct)
        declareStruct(file);
        file.writeln("template struct std::vector<", struct_name, ">;\n");
    return;
}

void listInstantiate(File file)
{
    file.writeln("\n");
    if (_class)
        declareClass(file);
        file.writeln("template class std::list<", class_name, ">;\n");
    if (_struct)
        declareStruct(file);
        file.writeln("template struct std::list<", struct_name, ">;\n");
    return;
}

void setInstantiate(File file)
{
    file.writeln("\n");
    if (_class)
        declareClass(file);
        file.writeln("template class std::set<", class_name, ">;\n");
    if (_struct)
        declareStruct(file);
        file.writeln("template struct std::set<", struct_name, ">;\n");

    return;
}

void declareClass(File file)
{
    file.writeln("class ", class_name, ";\n");
}

void declareStruct(File file)
{
    file.writeln("struct ", struct_name, ";\n");
}