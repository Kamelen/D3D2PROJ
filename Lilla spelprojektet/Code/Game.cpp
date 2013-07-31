#include "Game.h"

Game::Game(void)
{
	engine = new Engine();
	input = new Input();
	camera = new Camera();
	
}

Game::~Game(void)
{
	SAFE_DELETE(engine);
	SAFE_DELETE(camera);
	SAFE_DELETE(input);

}

bool Game::init(HINSTANCE hInstance, int cmdShow)
{

	this->hInstance = hInstance;
	this->cmdShow = cmdShow;

	if(!engine->init(hInstance,cmdShow))
		return false;
	

	camera->LookAt(Vec3(50,40,45), Vec3(35, 0, 45), Vec3(-1, 0, 0));
	camera->SetLens((float)D3DX_PI * 0.45f, (float)SCREEN_WIDTH / (float)SCREEN_HEIGHT, 0.1f, 1000.0f);
	camera->UpdateViewMatrix();


	return true; // all initiates went well
}

void Game::render()
{

		//set renderdata to engine if you want something rendered when render() is called

		camera->UpdateViewMatrix();
		engine->render(camera->View(), camera->Proj(),camera->GetPosition());
}

int Game::update(float dt)
{
	handleInput(dt);
	
	input->resetBtnState();
	char title[255];
	sprintf_s(title, "%f", 1/dt);
	SetWindowTextA(engine->getHWND(), title);

	return 1;
}



void Game::handleInput(float dt)
{

	input->updateMs(engine->getMouseState());


	if(input->checkMovement('W'))	//W
		camera->Walk(-100 * dt);

	if(input->checkMovement('A') )	//A
		camera->Strafe(-100 * dt);

	if(input->checkMovement('S'))	//S
		camera->Walk(100 * dt);

	if(input->checkMovement('D') )	//D
		camera->Strafe(100 * dt);

	if(input->checkKeyDown(VK_ESCAPE))
	{
		cout << "escape" << endl;
	}
	
}