#pragma once
#include "Def.h"

namespace test
{
    class TEST_API Engine
    {
    private:

    public:
        Engine();
        virtual ~Engine();

        void Begin();

    private:
    };

    /*For Clients */
    Engine* Generate();
}
