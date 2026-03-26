#include <iostream>
#include <cassert>
#include <thread>
#include <vector>
#include "../optimize/hash_set.h"
#include "../optimize/hash_set_rwlock.h"

void test_functional(const char* name, IHashSet* set) {
    std::cout << "\n【" << name << " 功能测试】\n";
    
    set->init();
    
    // 测试1：插入和查找
    std::cout << "1. 插入和查找...";
    for (int i = 0; i < 1000; i++) {
        set->insert(i);
    }
    for (int i = 0; i < 1000; i++) {
        assert(set->contains(i));
    }
    std::cout << "✓\n";
    
    // 测试2：重复插入
    std::cout << "2. 重复插入...";
    set->insert(100);
    assert(set->size() == 1000);
    std::cout << "✓\n";
    
    // 测试3：删除
    std::cout << "3. 删除...";
    set->remove(100);
    assert(!set->contains(100));
    assert(set->size() == 999);
    std::cout << "✓\n";
    
    // 测试4：多线程安全（简化）
    std::cout << "4. 多线程安全...";
    IHashSet* set2 = set;
    
    std::vector<std::thread> threads;
    for (int t = 0; t < 4; t++) {
        threads.emplace_back([set2, t]() {
            for (int i = 0; i < 100; i++) {
                int key = t * 1000 + i;
                set2->insert(key);
                set2->contains(key);
            }
        });
    }
    
    for (auto& t : threads) {
        t.join();
    }
    
    std::cout << "✓\n";
    std::cout << "所有功能测试通过 ✅\n";
}

int main() {
    std::cout << "========================================\n";
    std::cout << "  HashSet 功能测试（单锁 vs 读写锁）\n";
    std::cout << "========================================\n";
    
    // 测试原始版本（单锁）
    {
        OptimizeHashSet set;
        test_functional("单锁版本", &set);
    }
    
    // 测试读写锁版本
    {
        OptimizeHashSetRwLock set;
        test_functional("读写锁版本", &set);
    }
    
    std::cout << "\n========================================\n";
    std::cout << "  所有版本功能测试通过! ✅\n";
    std::cout << "========================================\n";
    
    return 0;
}
