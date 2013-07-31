#include "ParticleSystem.h"

ParticleSystem::ParticleSystem(void)
{
}


ParticleSystem::~ParticleSystem(void)
{
	for(int i = 0; i < (int)this->particlePolicies.size(); i++)
	{
		delete particlePolicies.at(i);
	}
}

void ParticleSystem::shutdown()
{
	delete particleSystem;
	particleSystem = NULL;
}

ParticleSystem* ParticleSystem::particleSystem = NULL;
ParticleSystem* ParticleSystem::Getinstance()
{
	if(particleSystem==NULL)
	{
		particleSystem = new ParticleSystem();
	}
	return particleSystem;
}

void ParticleSystem::update(float dt)
{
	//update all policies
	for(int i = 0; i < (int)particlePolicies.size(); i++)
	{
		int id = particlePolicies.at(i)->update(dt);

		if(id == 2)
		{
			SAFE_DELETE(particlePolicies.at(i));
			particlePolicies.erase(particlePolicies.begin() + i);
			i--;
		}
	}
}

vector<vector<MESH_PNC>> ParticleSystem::getVertexData()
{
	vector<vector<MESH_PNC>> vertexData;

	//fyll med all vertexdata från particlePolicies
	for(int i = 0; i < (int)particlePolicies.size(); i++)
	{
		vertexData.push_back(particlePolicies.at(i)->getVertexData());
	}

	return vertexData;
}


bool ParticleSystem::removePolicy(ParticlePolicy* temp) // kompletera med hur detta ska ske, hur removar man den policy man vill åt?(id? string namn?)
{
	for(int i = 0; i < (int)particlePolicies.size(); i++)
	{
		if(particlePolicies.at(i) == temp)
		{
			delete particlePolicies.at(i);
			particlePolicies.at(i) = NULL;
			particlePolicies.erase(particlePolicies.begin() + i);
			temp = NULL;
		}
	}

	return true;
}