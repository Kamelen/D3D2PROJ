#pragma once
#include "D3D11Handler.h"
#include "WinHandler.h"
#include "GeometryManager.h"
#include <FW1FontWrapper.h>
//#include "GUI.h"
#include <vector>
using namespace std;

class Engine
{
	public:
		Engine(void);
		~Engine(void);

		void render(Matrix& view, Matrix& proj, Vec3 cameraPos); // Text* text, int nrOfText,
	//	void renderGui(Text* text, int nrOfText);
	//	void renderText(Text* text, int nrOfText);

		bool init(HINSTANCE hInstance, int cmdShow);
		void start(int mapSize);
		PRIMITIVE_TOPOLOGIES changeTopology(int ID);

		void setRenderData(vector<vector<RenderData*>>& renderData);
		void setRenderData(vector<vector<MESH_PNC>> renderData);
		void setHPBars(vector<HPBarInfo>& bars);
//		void setGUI(GUI_Panel* data, int nrOfPanels);

		MouseState* getMouseState();
		HWND getHWND();

	private:
		D3D11Handler* d3d;
		WinHandler* win32;
		GeometryManager *pGeoManager;
		IFW1Factory *pFW1Factory;
		IFW1FontWrapper *pFontWrapper;

		ID3D11BlendState* blendState;

	private:
		void blurTexture(Shader *temp);
		void renderDebug(Matrix &vp);

};

