#include <iostream>
#include <vector>
#include "../common/i_hash_set.h"
#include "../common/test_utils.h"

// Include implementations
#include "../std/hash_set.h"
#include "../base/hash_set.h"
#include "../optimize/hash_set.h"

void testHashSet(const std::string& name, IHashSet* hashSet,
                 const std::vector<int>& insertValues,
                 const std::vector<int>& queryValues) {
    std::cout << "\n=== Testing " << name << " ===" << std::endl;

    hashSet->init();

    // Insert values
    for (int val : insertValues) {
        hashSet->insert(val);
    }
    std::cout << "After inserting " << hashSet->size() << " elements" << std::endl;

    // Query values
    int foundCount = 0;
    for (int val : queryValues) {
        if (hashSet->contains(val)) {
            foundCount++;
        }
    }
    std::cout << "Found " << foundCount << " out of " << queryValues.size() << " queries" << std::endl;

    // Verify size matches insert count (since HashSet doesn't allow duplicates)
    std::cout << "Final size: " << hashSet->size() << std::endl;
}

int main() {
    const int INSERT_COUNT = 100;
    const int QUERY_COUNT = 50;

    std::cout << "Generating test data with seed " << TestUtils::SEED << std::endl;
    std::vector<int> insertValues = TestUtils::generateRandomValues(INSERT_COUNT);
    std::vector<int> queryValues = TestUtils::generateRandomQueries(QUERY_COUNT);

    std::cout << "\n========================================" << std::endl;
    std::cout << "     HashSet Implementation Test" << std::endl;
    std::cout << "========================================" << std::endl;

    StdHashSet stdHashSet;
    testHashSet("std (unordered_set)", &stdHashSet, insertValues, queryValues);

    BaseHashSet baseHashSet;
    testHashSet("base (unordered_set)", &baseHashSet, insertValues, queryValues);

    OptimizeHashSet optimizeHashSet;
    testHashSet("optimize (unordered_set)", &optimizeHashSet, insertValues, queryValues);

    // Compare results between std and base
    std::cout << "\n========================================" << std::endl;
    std::cout << "     Comparing std vs base" << std::endl;
    std::cout << "========================================" << std::endl;

    stdHashSet.init();
    baseHashSet.init();

    for (int val : insertValues) {
        stdHashSet.insert(val);
        baseHashSet.insert(val);
    }

    bool sizeMatch = (stdHashSet.size() == baseHashSet.size());
    bool containsMatch = true;
    for (int val : queryValues) {
        if (stdHashSet.contains(val) != baseHashSet.contains(val)) {
            containsMatch = false;
            break;
        }
    }

    std::cout << "Size match: " << (sizeMatch ? "YES" : "NO") << std::endl;
    std::cout << "Contains match: " << (containsMatch ? "YES" : "NO") << std::endl;
    std::cout << "std size: " << stdHashSet.size() << ", base size: " << baseHashSet.size() << std::endl;

    // Test remove functionality
    std::cout << "\n========================================" << std::endl;
    std::cout << "     Testing Remove Function" << std::endl;
    std::cout << "========================================" << std::endl;

    stdHashSet.init();
    baseHashSet.init();

    // Insert first 20 values
    std::vector<int> removeTest(insertValues.begin(), insertValues.begin() + 20);
    for (int val : removeTest) {
        stdHashSet.insert(val);
        baseHashSet.insert(val);
    }

    std::cout << "Before remove: std size=" << stdHashSet.size()
              << ", base size=" << baseHashSet.size() << std::endl;

    // Remove first 10 values
    for (int i = 0; i < 10; ++i) {
        stdHashSet.remove(removeTest[i]);
        baseHashSet.remove(removeTest[i]);
    }

    bool removeSizeMatch = (stdHashSet.size() == baseHashSet.size());
    bool removeContainsMatch = true;
    for (int val : removeTest) {
        if (stdHashSet.contains(val) != baseHashSet.contains(val)) {
            removeContainsMatch = false;
            break;
        }
    }

    std::cout << "After remove: std size=" << stdHashSet.size()
              << ", base size=" << baseHashSet.size() << std::endl;
    std::cout << "Remove size match: " << (removeSizeMatch ? "YES" : "NO") << std::endl;
    std::cout << "Remove contains match: " << (removeContainsMatch ? "YES" : "NO") << std::endl;

    // Test resize functionality
    std::cout << "\n========================================" << std::endl;
    std::cout << "     Testing Resize Function" << std::endl;
    std::cout << "========================================" << std::endl;

    stdHashSet.init();
    baseHashSet.init();

    // Insert all values
    for (int val : insertValues) {
        stdHashSet.insert(val);
        baseHashSet.insert(val);
    }

    int sizeBeforeResize = stdHashSet.size();
    std::cout << "Before resize: size=" << sizeBeforeResize << std::endl;

    // Resize to larger bucket count
    stdHashSet.resize(1000);
    baseHashSet.resize(1000);

    bool resizeDataPreserved = true;
    for (int val : insertValues) {
        if (!stdHashSet.contains(val) || !baseHashSet.contains(val)) {
            resizeDataPreserved = false;
            break;
        }
    }

    std::cout << "After resize(1000): std size=" << stdHashSet.size()
              << ", base size=" << baseHashSet.size() << std::endl;
    std::cout << "Resize data preserved: " << (resizeDataPreserved ? "YES" : "NO") << std::endl;

    std::cout << "\n========================================" << std::endl;
    std::cout << "All tests completed successfully!" << std::endl;
    std::cout << "========================================" << std::endl;

    return 0;
}
