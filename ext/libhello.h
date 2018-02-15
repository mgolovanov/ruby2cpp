#include <stdio.h>
#include <stdlib.h>

#include <map>
#include <string>

extern "C" int sayHello(const char* s);

extern void printMap(const std::map<std::string, std::string>& m);

extern "C" void printJSON(const char* j);
