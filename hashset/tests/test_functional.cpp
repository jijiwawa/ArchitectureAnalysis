#include <iostream>
#include <vector>
#include <cassert>
#include <random>
#include "../common/i_hash_set.h"
#include "../std/hash_set.h"

#if defined(VERSION_base)
#include "../base/hash_set.h"
#elif defined(VERSION_optimize)
#include "../optimize/hash_set.h"
#endif

// 全局变量存储目标版本实例
IHashSet* targetSet = nullptr;
std::string targetName;
bool all_pass = true;  // 累积所有检查结果，用于 exit code

bool checkEq(const std::string& what, int stdVal, int targetVal) {
    if (stdVal != targetVal) {
        std::cout << what << " mismatch: std=" << stdVal << ", " << targetName << "=" << targetVal << " | ";
        all_pass = false;
        return false;
    }
    return true;
}

void testInit() {
    StdHashSet stdSet;
    targetSet->init();
    stdSet.init();

    checkEq("size", stdSet.size(), targetSet->size());
    checkEq("contains", stdSet.contains(1), targetSet->contains(1));
}

void testInsert() {
    StdHashSet stdSet;
    stdSet.init();
    targetSet->init();

    for (int i = 0; i < 100; ++i) {
        stdSet.insert(i);
        targetSet->insert(i);
    }

    checkEq("size", stdSet.size(), targetSet->size());

    for (int i = 0; i < 100; ++i) {
        checkEq("contains", stdSet.contains(i), targetSet->contains(i));
    }
}

void testRemove() {
    StdHashSet stdSet;
    stdSet.init();
    targetSet->init();

    for (int i = 0; i < 100; ++i) {
        stdSet.insert(i);
        targetSet->insert(i);
    }

    for (int i = 0; i < 50; ++i) {
        stdSet.remove(i);
        targetSet->remove(i);
    }

    checkEq("size", stdSet.size(), targetSet->size());

    for (int i = 0; i < 100; ++i) {
        checkEq("contains", stdSet.contains(i), targetSet->contains(i));
    }
}

void testResizeExpand() {
    StdHashSet stdSet;
    stdSet.init();
    targetSet->init();

    for (int i = 0; i < 100; ++i) {
        stdSet.insert(i);
        targetSet->insert(i);
    }

    stdSet.resize(1000);
    targetSet->resize(1000);

    checkEq("size", stdSet.size(), targetSet->size());

    for (int i = 0; i < 100; ++i) {
        checkEq("contains", stdSet.contains(i), targetSet->contains(i));
    }
}

void testLargeScaleInsert() {
    StdHashSet stdSet;
    stdSet.init();
    targetSet->init();

    for (int i = 0; i < 10000; ++i) {
        stdSet.insert(i);
        targetSet->insert(i);
    }

    checkEq("size", stdSet.size(), targetSet->size());

    for (int i = 0; i < 10000; i += 100) {
        checkEq("contains", stdSet.contains(i), targetSet->contains(i));
    }
}

struct Op {
    int type;  // 0=insert, 1=contains, 2=remove
    int value;
};

void testMixedOperations() {
    StdHashSet stdSet;
    stdSet.init();
    targetSet->init();

    // 生成500个操作
    std::vector<Op> ops;
    std::mt19937 rng(42);
    for (int i = 0; i < 500; ++i) {
        Op op;
        op.type = rng() % 3;      // 0=insert, 1=contains, 2=remove
        op.value = rng() % 101;   // 0~100
        ops.push_back(op);
    }

    // 在两个表按相同顺序执行
    for (auto& op : ops) {
        if (op.type == 0) {
            // insert
            stdSet.insert(op.value);
            targetSet->insert(op.value);
        } else if (op.type == 1) {
            // contains - 对比返回值
            bool r1 = stdSet.contains(op.value);
            bool r2 = targetSet->contains(op.value);
            checkEq("contains", r1, r2);
        } else {
            // remove
            stdSet.remove(op.value);
            targetSet->remove(op.value);
        }
    }

    // 最终对比 size
    checkEq("final size", stdSet.size(), targetSet->size());

    // 验证所有数据一致性
    for (int i = 0; i <= 100; ++i) {
        checkEq("contains after", stdSet.contains(i), targetSet->contains(i));
    }
}

void testEdgeCases() {
    // 空集
    {
        StdHashSet stdSet;
        stdSet.init();
        targetSet->init();
        checkEq("empty size", stdSet.size(), targetSet->size());
    }

    // 单元素
    {
        StdHashSet stdSet;
        stdSet.init();
        targetSet->init();
        stdSet.insert(1);
        targetSet->insert(1);
        checkEq("single size", stdSet.size(), targetSet->size());
        checkEq("single contains", stdSet.contains(1), targetSet->contains(1));
    }

    // 重复插入
    {
        StdHashSet stdSet;
        stdSet.init();
        targetSet->init();
        for (int i = 0; i < 5; ++i) {
            stdSet.insert(1);
            targetSet->insert(1);
        }
        checkEq("dup size", stdSet.size(), targetSet->size());
    }
}

int main() {
#if defined(VERSION_base)
    BaseHashSet target;
    targetSet = &target;
    targetName = "base";
#elif defined(VERSION_optimize)
    OptimizeHashSet target;
    targetSet = &target;
    targetName = "optimize";
#else
    std::cerr << "Must compile with -DVERSION_base or -DVERSION_optimize" << std::endl;
    return 1;
#endif

    std::cout << "========================================" << std::endl;
    std::cout << "  Functional Test: std vs " << targetName << std::endl;
    std::cout << "========================================" << std::endl;

    std::cout << "\n[testInit]" << std::endl;
    testInit();

    std::cout << "[testInsert]" << std::endl;
    testInsert();

    std::cout << "[testRemove]" << std::endl;
    testRemove();

    std::cout << "[testResizeExpand]" << std::endl;
    testResizeExpand();

    std::cout << "[testLargeScaleInsert]" << std::endl;
    testLargeScaleInsert();

    std::cout << "[testMixedOperations]" << std::endl;
    testMixedOperations();

    std::cout << "[testEdgeCases]" << std::endl;
    testEdgeCases();

    std::cout << "\n========================================" << std::endl;
    std::cout << "All functional tests completed!" << std::endl;
    std::cout << "========================================" << std::endl;

    return all_pass ? 0 : 1;
}
