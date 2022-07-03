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
#define EMOTE_TELEPORT "Телепортация выполнено успешно, приятной игры."
#define EMOTE_QUESTIONSFIRST "Условия задания были выполнены, продолжайте ваш путь."

enum  defines
{
	//quest
    ETHEREAL_CREDIT = 38186, // Эфириальная монета
	InformationTake = 50000, //Первое задание - Информатор
	MakeTeleport = 50001, //Второе задание - выполнить телепорт
	
	//npc
	Information = 80014
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
			AddGossipItemFor(player, 10, "|TInterface\\icons\\:35:|tШатер Деревни", GOSSIP_SENDER_MAIN,                        	 	 							 1);
			AddGossipItemFor(player, 10, "|TInterface\\icons\\:35:|tБашня Драконов", GOSSIP_SENDER_MAIN,               						 	 				 2);
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
				
				case 999:
					create_menu(player, item);
				break;
				
				case 1:
					Warhead::Text::SendAreaTriggerMessage(player->GetSession(), EMOTE_TELEPORT);
					if (player->IsActiveQuest(MakeTeleport)){
					Warhead::Text::SendAreaTriggerMessage(player->GetSession(), EMOTE_QUESTIONSFIRST);
					player->KilledMonsterCredit(Information);
					}
					ClearGossipMenuFor(player);
					player->TeleportTo(0, -13230.713867f, 223.944885f, 33.073017f, 1.110926f);
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
        GossipHello(player, creature);
        return false;
    }
  
    void GossipHello(Player* player, Creature* creature)
	{
        if (player ->IsInCombat() || player ->IsInFlight() || player ->GetMap()->IsBattlegroundOrArena() || player ->HasStealthAura() || player ->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player ->isDead() || player ->GetAreaId() == 616)
        {
            sModuleLocale->SendPlayerMessage(player, "IT_LOCALE_COMBAT");
            CloseGossipMenuFor(player);
        }
		
		else {
			ClearGossipMenuFor(player);
			AddGossipItemFor(player, 10, "Информация о Сервере", GOSSIP_SENDER_MAIN,                        	 	 							 1);
			if (player->IsActiveQuest(50000)){
				AddGossipItemFor(player, 10, "Информация о Деревне", GOSSIP_SENDER_MAIN,               						 	 				 2);
			}
			SendGossipMenuFor(player, 68, creature->GetGUID());
		}
    }
    
    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
    {
		ClearGossipMenuFor(player);
		
        if (sender >= GOSSIP_SENDER_INFO)
        {
            GossipHello(player, creature);
            return false;
        }
			switch (action)
			{
				case 1:
				ClearGossipMenuFor(player);
				player->KilledMonsterCredit(80015);
				player->PlayerTalkClass->SendCloseGossip();
				break;
				
				case 2:
				ClearGossipMenuFor(player);
				player->PlayerTalkClass->SendCloseGossip();
				break;
			}
		
		return true;
	}
};

void AddSC_ItemTeleport()
{
	new item_teleport();
	new npc_information();
	
}
