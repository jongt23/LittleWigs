﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Salramm the Fleshcrafter"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Salramm",

	flesh = "Twisted Flesh",
	flesh_desc = "Warn when someone has the Twisted Flesh curse.",

	fleshBar = "Twisted Flesh Bar",
	fleshBar_desc = "Show a bar for the duration of the Twisted Flesh curse.",

	flesh_message = "Twisted Flesh: %s",

	ghouls = "Summon Ghouls",
	ghouls_desc = "Warn when Salramm the Fleshcrafter summons ghouls.",
	ghouls_message = "Summoning Ghouls",
} end )

L:RegisterTranslations("koKR", function() return {
} end )

L:RegisterTranslations("frFR", function() return {
} end )

L:RegisterTranslations("zhTW", function() return {
} end )

L:RegisterTranslations("deDE", function() return {
} end )

L:RegisterTranslations("zhCN", function() return {
} end )

L:RegisterTranslations("ruRU", function() return {
} end )

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.otherMenu = "Caverns of Time"
mod.zonename = BZ["The Culling of Stratholme"]
mod.enabletrigger = boss 
mod.guid = 26530
mod.toggleoptions = {"flesh", "fleshBar", "bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("SPELL_AURA_APPLIED", "Flesh", 58845)
	self:AddCombatListener("SPELL_AURA_REMOVED", "FleshRemoved", 58845)
	self:AddCombatListener("SPELL_CAST_START", "Ghouls", 52451)
	self:AddCombatListener("UNIT_DIED", "BossDeath")
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:Ghouls(_, spellId)
	if self.db.profile.ghouls then
		self:IfMessage(L["ghouls_message"], "Important", spellId)
	end
end

function mod:Flesh(player, spellId)
	if self.db.profile.flesh then
		self:IfMessage(L["flesh_message"]:format(player), "Important", spellId)
	end
	if self.db.profile.fleshBar then
		self:Bar(L["flesh_message"]:format(player), 30, spellId)
	end
end

function mod:FleshRemove(player)
	if self.db.profile.fleshBar then
		self:TriggerEvent("BigWigs_StopBar", self, L["flesh_message"]:format(player))
	end
end
