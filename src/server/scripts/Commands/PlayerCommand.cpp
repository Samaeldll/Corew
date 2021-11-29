/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "PlayerCommand.h"
#include "Language.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

bool Warhead::PlayerCommand::HandleLearnSpellCommand(ChatHandler* handler, Player* targetPlayer, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
{
    if (!SpellMgr::IsSpellValid(spell))
    {
        handler->PSendSysMessage(LANG_COMMAND_SPELL_BROKEN, spell->Id);
        handler->SetSentErrorMessage(true);
        return false;
    }

    if (!allRanks && targetPlayer->HasSpell(spell->Id))
    {
        if (targetPlayer == handler->GetPlayer())
        {
            handler->SendSysMessage(LANG_YOU_KNOWN_SPELL);
        }
        else
        {
            handler->PSendSysMessage(LANG_TARGET_KNOWN_SPELL, handler->GetNameLink(targetPlayer));
        }

        handler->SetSentErrorMessage(true);
        return false;
    }

    targetPlayer->learnSpell(spell->Id, false);

    if (allRanks)
    {
        uint32 spellId = spell->Id;

        while ((spellId = sSpellMgr->GetNextSpellInChain(spellId)))
        {
            targetPlayer->learnSpell(spellId, false);
        }
    }

    if (GetTalentSpellCost(spell->GetFirstRankSpell()->Id))
    {
        targetPlayer->SendTalentsInfoData(false);
    }

    return true;
}

bool Warhead::PlayerCommand::HandleUnlearnSpellCommand(ChatHandler* handler, Player* target, SpellInfo const* spell, Optional<EXACT_SEQUENCE("all")> allRanks)
{
    uint32 spellId = spell->Id;

    if (allRanks)
    {
        spellId = sSpellMgr->GetFirstSpellInChain(spellId);
    }

    if (target->HasSpell(spellId))
    {
        target->removeSpell(spellId, SPEC_MASK_ALL, false);
    }
    else
    {
        handler->SendSysMessage(LANG_FORGET_SPELL);
    }

    if (GetTalentSpellCost(spellId))
    {
        target->SendTalentsInfoData(false);
    }

    return true;
}
