import std.getopt;
import std.stdio;
import std.process;

void writeToCppFile();
void setInstantiate(File);
void listInstantiate(File);
void vectorInstantiate(File);
void declareSetStruct(File);
void declareSetClass(File);
void declarelistStruct(File);
void declarelistClass(File);
void declareVectorClass(File);
void declareVectorStruct(File);
void declareStruct(File file, string[]);
void declareClass(File, string[]);

/* storing classes */
string[] vectorclass;
string[] listclass;
string[] setclass;

/* storing structs */
string[] vectorstruct;
string[] liststruct;
string[] setstruct;

string[] classes;
string[] structs;

int vclass = 0;
int vstruct = 0;
int lclass = 0;
int lstruct = 0;
int sclass = 0;
int sstruct = 0;
int listflag = 0;
int setflag = 0;
int vectorflag = 0;

void main(string[] args) {
    getopt(args, std.getopt.config.caseSensitive,
            "vclass|vc", &vectorclass,
            "lclass|lc", &listclass,
            "sclass|sc", &setclass,
            "vstruct|vs", &vectorstruct,
            "lstruct|ls", &liststruct,
            "sstruct|ss", &setstruct);

    if (vectorclass.length || vectorstruct.length)
        vectorflag = 1;
    if (listclass.length || liststruct.length)
        listflag = 1;
    if (setclass.length || setstruct.length)
        setflag = 1;

    if (vectorclass.length)
        vclass = 1;

     if (vectorstruct.length)
        vstruct = 1;

    if (listclass.length)
        lclass = 1;

    if (liststruct.length)
        lstruct = 1;

    if (setclass.length)
        sclass = 1;

    if (setstruct.length)
        sstruct = 1;

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
    if (vclass)
        declareVectorClass(file);
        foreach(name; vectorclass)
        {
            file.writeln("template class std::vector<", name, ">;\n");
        }

    if (vstruct)
        declareVectorStruct(file);
        foreach(name; vectorstruct)
        {
            file.writeln("template struct std::vector<",name , ">;\n");
        }

    return;
}

void listInstantiate(File file)
{
    if (lclass)
        declarelistClass(file);
        foreach(name; listclass)
        {
            file.writeln("template class std::list<", name, ">;\n");
        }

    if (lstruct)
        declarelistStruct(file);
        foreach(name; liststruct)
        {
            file.writeln("template struct std::list<", name, ">;\n");
        }

    return;
}

void setInstantiate(File file)
{
    if (sclass)
        declareSetClass(file);
        foreach(name; setclass)
        {
            file.writeln("template class std::set<", name, ">;\n");
        }

    if (sstruct)
        declareSetStruct(file);
        foreach(name; setstruct)
        {
            file.writeln("template struct std::set<", name, ">;\n");
        }

    return;
}

void declareVectorClass(File file)
{
    declareClass(file, vectorclass);
}

void declareVectorStruct(File file)
{
    declareStruct(file, vectorstruct);
}

void declarelistClass(File file)
{
    declareClass(file, listclass);
}

void declarelistStruct(File file)
{
    declareStruct(file, listclass);
}

void declareSetClass(File file)
{
    declareClass(file, setclass);
}

void declareSetStruct(File file)
{
    declareStruct(file, setstruct);
}

void declareClass(File file, string[] _class)
{
    foreach(name; _class)
    {
        file.writeln("class ", name, ";\n");
    }
}

void declareStruct(File file, string[] _struct)
{
    foreach(name; _struct)
    {
        file.writeln("struct ", name, ";\n");
    }
}

