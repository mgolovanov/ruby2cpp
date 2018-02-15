#include <libhello.h>
#include <json.hpp>

using json = nlohmann::json;

int sayHello(const char* s)
{
    printf("Hello, %s!\n", s);
    return 0;
}

void printMap(const std::map<std::string, std::string>& m)
{
    for(const auto &kv : m)
    {
	printf("[%s] => %s\n", kv.first.c_str(), kv.second.c_str());
    }
}

void printJSON(const char* j)
{
    json j1 = json::parse(j);
    std::string s1 = j1.dump(4); // pretty print
    printf("%s\n", s1.c_str());
}
