#include "Player.h"
#include "WorldSession.h"
#include "ScriptMgr.h"
#include "Log.h"
#include "World.h"
#include "ModulesConfig.h"

class start_quest : public PlayerScript
{
public:
    start_quest() : PlayerScript("start_quest") { }

    void OnFirstLogin(Player* player)
    {
		if (!MOD_CONF_GET_BOOL("QuestStart.Enable"))
            return;
		
		Quest const* quest = sObjectMgr->GetQuestTemplate(MOD_CONF_GET_INT("QuestStart.QuestID"));
		if (quest)
        {
			if (player->CanAddQuest(quest, true))
			{
				player->AddQuest(quest, nullptr);
			}
		}    
    }
};


class Quest_World : public WorldScript
{
public:
    Quest_World() : WorldScript("Quest_World") { }

    void OnAfterConfigLoad(bool /*reload*/) override
    {
        sModulesConfig->AddOption<bool>("QuestStart.Enable");
        sModulesConfig->AddOption<int32>("QuestStart.QuestID", 0);
    }
};

void AddSC_StartQuest()
{
	new Quest_World();
	new start_quest();
}
