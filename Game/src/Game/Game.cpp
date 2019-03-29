#include "Game.h"

Game::Game()
{
}


Game::~Game()
{
}

int main(int argc, char** argv)
{
    Game* game = new Game();
    game->Begin();
    delete game;
}
