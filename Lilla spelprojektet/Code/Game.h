#pragma once
#include "Engine.h"
#include "GameLogic.h"
#include "Input.h"
#include "Camera.h"
#include "ParticleSystem.h"
#include <fstream>

using namespace std;
class Game
{
public:
	Game(void);
	~Game(void);

	void render();
	int update(float dt);
	bool init(HINSTANCE hInstance, int cmdShow);
	void handleInput(float dt);

private:
	Engine* engine;
	Input* input;
	Camera* camera;

	HINSTANCE hInstance; 
	int cmdShow;
};

