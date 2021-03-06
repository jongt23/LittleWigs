
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Stormsong", 1864, 2155)
if not mod then return end
mod:RegisterEnableMob(134060)
mod.engageId = 2132

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Intruders?! I shall cast your bodies to the blackened depths, to be crushed for eternity!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		268347, -- Void Bolt
		269097, -- Waken the Void
		269131, -- Ancient Mindbender
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")

	self:Log("SPELL_CAST_START", "VoidBolt", 268347)
	self:Log("SPELL_CAST_SUCCESS", "WakentheVoid", 269097)
	self:Log("SPELL_CAST_SUCCESS", "AncientMindbender", 269131)
	self:Log("SPELL_AURA_APPLIED", "AncientMindbenderApplied", 269131)
end

function mod:OnEngage()
	self:CDBar(269097, 13.5) -- Waken the Void _success
	self:CDBar(269131, 22) -- Ancient Mindbender _success
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 19, CL.active, "achievement_dungeon_shrineofthestorm")
	end
end

function mod:VoidBolt(args)
	self:Message(args.spellId, "yellow")
	if self:Interrupter() then
		self:PlaySound(args.spellId, "alert")
	end
	self:CDBar(args.spellId, 8.5)
end

function mod:WakentheVoid(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "Alarm")
	self:CDBar(args.spellId, 43.5)
end

function mod:AncientMindbender(args)
	self:CDBar(args.spellId, 43.5)
end

function mod:AncientMindbenderApplied(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "Warning", nil, args.destName)
end
