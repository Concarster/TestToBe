#pragma once

#include "Engine\Engine.h"

extern test::Engine* test::Generate();

#ifdef TEST_WINDOW

int main(int argc, char** argv)
{
    auto game = test::Generate();
    game->Begin();
    delete game;
}

#endif // TEST_WINDOW
