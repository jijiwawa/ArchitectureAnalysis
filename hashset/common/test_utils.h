#ifndef COMMON_TEST_UTILS_H
#define COMMON_TEST_UTILS_H

#include <vector>
#include <cstdlib>
#include <ctime>

class TestUtils {
public:
    static const int SEED = 42;

    static std::vector<int> generateRandomValues(int count, int minVal = 0, int maxVal = 10000) {
        std::srand(SEED);
        std::vector<int> values;
        for (int i = 0; i < count; ++i) {
            values.push_back(minVal + std::rand() % (maxVal - minVal + 1));
        }
        return values;
    }

    static std::vector<int> generateRandomQueries(int count, int minVal = 0, int maxVal = 10000) {
        std::srand(SEED + 100);
        std::vector<int> queries;
        for (int i = 0; i < count; ++i) {
            queries.push_back(minVal + std::rand() % (maxVal - minVal + 1));
        }
        return queries;
    }
};

#endif // COMMON_TEST_UTILS_H
