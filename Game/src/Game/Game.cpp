#include "Game.h"

Game::Game()
{
}


Game::~Game()
{
}

test::Engine* test::Generate()
{
    return new Game();
}
