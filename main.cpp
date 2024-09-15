#include <unistd.h>
#include <string>
#include <iostream>
#include <fstream>

void emitSymbol();
void writeToCppFile();
void setInstantiate(std::ofstream &);
void listInstantiate(std::ofstream &);
void vectorInstantiate(std::ofstream &);

int vectorflag = 0;
int listflag = 0;
int setflag = 0;
int _class = 0;
int _struct = 0;
std::string class_name;
std::string struct_name;

int main(int argc, char** argv)
{
    int opt;
    while((opt = getopt(argc, argv, "lvs:C:S:")) != -1){
        switch(opt)
        {
            case 'l':
                listflag = 1;
                break;
            case 'v':
                vectorflag = 1;
                break;
            case 's':
                if (strcmp(optarg, "set") == 0)
                    setflag = 1;
                else
                    std::cout << "unknown argument ";
                    return -1;
                break;
            case 'C':
                _class = 1;
                class_name = optarg;
                break;
            case 'S':
                _struct = 1;
                struct_name = optarg;
                break;
        }
    }

    emitSymbol();
    return 0;
}

void emitSymbol()
{
    std::cout << class_name << std::endl;
    std::cout << struct_name << std::endl;
    std::cout << listflag << std::endl;
    std::cout << vectorflag << std:: endl;
    std::cout << setflag << std::endl;
    std::cout << _class << std::endl;
    std::cout << _struct << std::endl;
}

void writeToCppFile()
{
    std::ofstream cppfile;
    cppfile.open("test.cpp");
    if (vectorflag)
        vectorInstantiate(cppfile);
    if (listflag)
        listInstantiate(cppfile);
    if (setflag)
        setInstantiate(cppfile);
    return;
}

void vectorInstantiate(std::ofstream &file)
{
    file << "\n";
    if (_class)
        file << "class " << class_name << ";";
        file << "template class std::vector<" << class_name << ">;" << "\n";
    if (_struct)
        file << "struct " << struct_name << ";";
        file << "template class std::vector<" << struct_name << ">;" << "\n";
    return;
}

void listInstantiate(std::ofstream &file)
{
    file << "\n";
    if (_class)
        file << "class " << class_name << ";";
        file << "template class std::list<" << class_name << ">;" <<"\n";
    if (_struct)
        file << "struct " << struct_name << ";";
        file << "template class std::list<" << struct_name << ">;" << "\n";
    return;
}

void setInstantiate(std::ofstream &file)
{
    file << "\n";
    if (_class)
        file << "class " << class_name << ";";
        file << "template class std::set<" << class_name << ">;" << "\n";
    if (_struct)
        file << "struct " << struct_name << ";";
        file << "template class std::set<" << struct_name << ">;" << "\n";
    return;
}
