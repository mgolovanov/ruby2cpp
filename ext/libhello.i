%module libhello
%{
    #include "libhello.h"
%}

%include <stl.i>
//%include <std_map.i>
//%include <std_string.i>

%template(StringMap)  std::map<std::string,std::string>; 

namespace std {
   %template(Imap) map<swig::GC_VALUE, swig::GC_VALUE>;
}

extern int sayHello(const char* s);

extern void printMap(const std::map<std::string, std::string>& m);

extern void printJSON(const char* j);

