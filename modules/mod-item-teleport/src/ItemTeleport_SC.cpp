#include "Player.h"
#include "WorldSession.h"
#include "ScriptMgr.h"
#include "Log.h"
#include "World.h"
#include "ModulesConfig.h"
#include "ScriptedGossip.h"
#include "ChatTextBuilder.h"
#include "Chat.h"
#include "ModuleLocale.h"

#define EMOTE_COMBAT "|cffff0000Вы в бою! Чтобы использовать данный предмет, выйдите из боя!|r"
#define EMOTE_TELEPORT "|cffF08080Телепортация выполнено успешно, приятной игры."
#define EMOTE_QUESTIONSFIRST "|cffFFC0CBУсловия задания были выполнены, продолжайте ваш путь."

enum  defines
{
	//quest
    ETHEREAL_CREDIT = 38186, // Эфириальная монета
	
};

class item_teleport : public ItemScript
{
public:
    item_teleport() : ItemScript("item_teleport") { }

   
    bool OnUse(Player* player, Item* item, SpellCastTargets const& /*targets*/) override // Any hook here
    {
        create_menu(player, item);
        return false;
    }
    
    void create_menu(Player* player, Item* item){
        if (player ->IsInCombat() || player ->IsInFlight() || player ->GetMap()->IsBattlegroundOrArena() || player ->HasStealthAura() || player ->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player ->isDead() || player ->GetAreaId() == 616)
        {
            player->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, item, NULL);
            CloseGossipMenuFor(player);
        }
		
		else {
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player, 10, "Шатер Деревни", GOSSIP_SENDER_MAIN,                        	 	 							 1);
			if (player->GetQuestStatus(50003) == QUEST_STATUS_REWARDED){
			AddGossipItemFor(player, 10, "Башня Драконов", GOSSIP_SENDER_MAIN,               						 	 				 2);
			}
			SendGossipMenuFor(player, 68, item->GetGUID());
		}
    }
    
    void OnGossipSelect(Player* player, Item* item, uint32 sender, uint32 action) override
    {
        if (!player->getAttackers().empty())
        {
            Warhead::Text::SendAreaTriggerMessage(player->GetSession(), EMOTE_COMBAT);
            player->PlayerTalkClass->SendCloseGossip();
            return;
        }
		
		if (sender == GOSSIP_SENDER_MAIN)
        {
			player->PlayerTalkClass->ClearMenus();
			switch (action)
			{
				
				case 999: //Хук на создание меню
					create_menu(player, item);
				break;
				
				case 1: //Шатер Деревни
					Warhead::Text::SendAreaTriggerMessage(player->GetSession(), EMOTE_TELEPORT);
					if (player->GetQuestStatus(50001) == QUEST_STATUS_INCOMPLETE){
					Warhead::Text::SendAreaTriggerMessage(player->GetSession(), EMOTE_QUESTIONSFIRST);
					player->KilledMonsterCredit(80016);
					}
					ClearGossipMenuFor(player);
					player->TeleportTo(37, 1064.7357f, 6.245868f, 314.92587f, 3.6755364f);
					player->PlayerTalkClass->SendCloseGossip();
				break;
				
				case 2: //Башня Драконов
					Warhead::Text::SendAreaTriggerMessage(player->GetSession(), EMOTE_TELEPORT);
					ClearGossipMenuFor(player);
					player->TeleportTo(37, 881.2614f, 15.757152f, 348.14883f, 5.2447586f);
					player->PlayerTalkClass->SendCloseGossip();
				break;
			}
		}
	}
	
};



class npc_information : public CreatureScript
{
public:
    npc_information() : CreatureScript("npc_information") { }
 
     bool OnGossipHello(Player* player, Creature* creature) override // Any hook here
    {
        CreateMenu(player, creature);
        return false;
    }
  
    void CreateMenu(Player* player, Creature* creature)
	{
        if (player ->IsInCombat() || player ->IsInFlight() || player ->GetMap()->IsBattlegroundOrArena() || player ->HasStealthAura() || player ->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player ->isDead() || player ->GetAreaId() == 616)
        {
            Warhead::Text::SendAreaTriggerMessage(player->GetSession(), "Сейчас вы не можете выполнить данное действие");
            CloseGossipMenuFor(player);
        }
		
		else {
			player->PlayerTalkClass->ClearMenus();
			AddGossipItemFor(player, 10, "Информация о Проекте", 		GOSSIP_SENDER_MAIN,         1);
			AddGossipItemFor(player, 10, "Информация о Игровом Мире", 	GOSSIP_SENDER_MAIN,    		2);
			AddGossipItemFor(player, 10, "Как написать администрации?", GOSSIP_SENDER_MAIN,  		3);
			AddGossipItemFor(player, 10, "Где скачать Лаунчер", 		GOSSIP_SENDER_MAIN,  		4);
			if (player->IsActiveQuest(50000)){
				AddGossipItemFor(player, 10, "Информация о Деревне", 	GOSSIP_SENDER_MAIN,     	20);
			}
			SendGossipMenuFor(player, 0, creature->GetGUID());
			Warhead::Text::SendAreaTriggerMessage(player->GetSession(), "Тест1");
		}
    }
    
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
		ClearGossipMenuFor(player);
		
        if (sender >= GOSSIP_SENDER_INFO)
        {
			ClearGossipMenuFor(player);
            return false;
        }
			switch (action)
			{
				case 0:
				CreateMenu(player, creature);
				break;
				
				case 1:
				ClearGossipMenuFor(player);
				player->KilledMonsterCredit(80015);
				player->PlayerTalkClass->SendCloseGossip();
				break;
				
				case 2:
				ClearGossipMenuFor(player);
				player->PlayerTalkClass->SendCloseGossip();
				break;
				
				default:
				Warhead::Text::SendAreaTriggerMessage(player->GetSession(), "Ошибка");
				ClearGossipMenuFor(player);
				player->PlayerTalkClass->SendCloseGossip();
				break;
			}
	}
};

void AddSC_ItemTeleport()
{
	new item_teleport();
	new npc_information();
	
}
