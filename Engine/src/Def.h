#pragma once

#ifdef TEST_ENGINE
#ifdef TEST_WINDOW
#ifdef TEST_BUILD_DLL

#define TEST_API __declspec(dllexport)
#else
#define TEST_API __declspec(dllimport)

#endif // TEST_BUILD_DLL

#else
#error BooErEngine only support Windows!

#endif // TEST_WINDOW
#endif // TEST_ENGINE


#ifdef TEST_DEBUG
#define TEST_ENABLE_ASSERTS
#endif

#ifdef TEST_ENABLE_ASSERTS
#define TEST_CLIENT_ASSERT(x, ...) { if(!(x)) { TEST_CLIENT_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#define TEST_ENGINE_ASSERT(x, ...) { if(!(x)) { TEST_ENGINE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#else
#define TEST_ASSERT(x, ...)
#define TEST_CORE_ASSERT(x, ...)
#endif

#define BIT(x) (1 << x)

#define TEST_BIND_EVENT_FN(fn) std::bind(&fn, this, std::placeholders::_1)




