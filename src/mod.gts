// CustomDataLoader 示例；可直接在此基础上编写赛事模组。
import { $, DamageType, DiceType } from "@gi-tcg/core/data";

/**
 * @id 311309
 * @name 便携动力锯
 * @description
 * 所附属角色受到伤害时：如可能，舍弃1张当前元素骰费用最高的手牌，以抵消1点伤害，然后累积1点「坚忍标记」。（每回合最多触发2次）
 * 角色造成伤害时：如果此牌已有「坚忍标记」，则消耗所有「坚忍标记」，使此伤害+1，并且每消耗1点「坚忍标记」就抓1张牌。
 * （「双手剑」角色才能装备。角色最多装备1件「武器」）
 */
define card {
  id 311309 as PortablePowerSaw;
  description "<color=#FFFFFFFF>所附属角色受到伤害时：</color>如可能，$[K56]1张$[K3002]最高的手牌，以抵消1点伤害，然后累积1点<color=#FFFFFFFF>「坚忍标记」</color>。（每回合最多触发2次）\\n<color=#FFFFFFFF>角色造成伤害时：</color>如果此牌已有<color=#FFFFFFFF>「坚忍标记」</color>，则消耗所有<color=#FFFFFFFF>「坚忍标记」</color>，使此伤害+1，并且每消耗1点<color=#FFFFFFFF>「坚忍标记」</color>就抓1张牌。\\n（<color=#FFFFFFFF>「{SPRITE_PRESET#3203}双手剑」角色</color>才能装备。角色最多装备1件「{SPRITE_PRESET#3003}武器」）";
  playingDescription "<color=#FFFFFFFF>所附属角色受到伤害时：</color>如可能，$[K56]1张$[K3002]最高的手牌，以抵消1点伤害，然后累积1点<color=#FFFFFFFF>「坚忍标记」</color>。（每回合最多触发2次）\\n<color=#FFFFFFFF>角色造成伤害时：</color>如果此牌已有<color=#FFFFFFFF>「坚忍标记」</color>，则消耗所有<color=#FFFFFFFF>「坚忍标记」</color>，使此伤害+1，并且每消耗1点<color=#FFFFFFFF>「坚忍标记」</color>就抓1张牌。";
  cost DiceType.Aligned, 2;
  weapon claymore {
    tags barrier;
    variable barrierUsage, 0;
    variable stoic, 0;
    on decreaseDamaged {
      when :( :player.hands.length > 0 );
      usage perRound, 2;
      :discardMaxCostHands(1);
      :e.decreaseDamage(1);
      :addVariable("stoic", 1);
    };
    on increaseSkillDamage {
      when :( :getVariable("stoic") > 0 );
      :e.increaseDamage(1);
      :drawCards(:getVariable("stoic"));
      :setVariable("stoic", 0);
    };
  };
};

/**
 * @id 311509
 * @name 船坞长剑
 * @description
 * 所附属角色受到伤害时：如可能，舍弃1张当前元素骰费用最高的手牌，以抵消1点伤害，然后累积1点「团结」。（每回合最多触发2次）
 * 角色造成伤害时：如果此牌已有「团结」，则消耗所有「团结」，使此伤害+1，并且每消耗1点「团结」就抓1张牌。
 * （「单手剑」角色才能装备。角色最多装备1件「武器」）
 */
define card {
  id 311509 as TheDockhandsAssistant;
  description "<color=#FFFFFFFF>所附属角色受到伤害时：</color>如可能，$[K56]1张$[K3002]最高的手牌，以抵消1点伤害，然后累积1点<color=#FFFFFFFF>「团结」</color>。（每回合最多触发2次）\\n<color=#FFFFFFFF>角色造成伤害时：</color>如果此牌已有<color=#FFFFFFFF>「团结」</color>，则消耗所有<color=#FFFFFFFF>「团结」</color>，使此伤害+1，并且每消耗1点<color=#FFFFFFFF>「团结」</color>就抓1张牌。\\n（<color=#FFFFFFFF>「{SPRITE_PRESET#3205}单手剑」角色</color>才能装备。角色最多装备1件「{SPRITE_PRESET#3003}武器」）";
  playingDescription "<color=#FFFFFFFF>所附属角色受到伤害时：</color>如可能，$[K56]1张$[K3002]最高的手牌，以抵消1点伤害，然后累积1点<color=#FFFFFFFF>「团结」</color>。（每回合最多触发2次）\\n<color=#FFFFFFFF>角色造成伤害时：</color>如果此牌已有<color=#FFFFFFFF>「团结」</color>，则消耗所有<color=#FFFFFFFF>「团结」</color>，使此伤害+1，并且每消耗1点<color=#FFFFFFFF>「团结」</color>就抓1张牌。";
  cost DiceType.Aligned, 2;
  weapon sword {
    tags barrier;
    variable barrierUsage, 0;
    variable solidarity, 0;
    on decreaseDamaged {
      when :( :player.hands.length > 0 );
      usage perRound, 2;
      :discardMaxCostHands(1);
      :e.decreaseDamage(1);
      :addVariable("solidarity", 1);
    };
    on increaseSkillDamage {
      when :( :getVariable("solidarity") > 0 );
      :e.increaseDamage(1);
      :drawCards(:getVariable("solidarity"));
      :setVariable("solidarity", 0);
    };
  };
};

/**
 * @id 330005
 * @name 万家灶火
 * @description
 * 第1回合打出此牌时：如果我方牌组中初始包含至少4/2张不同的「天赋」牌，则抓2/1张「天赋」牌。
 * 第2回合及以后打出此牌时：我方抓当于当前的回合数的牌。（最多抓4张）
 * （整局游戏只能打出一张「秘传」卡牌；这张牌一定在你的起始手牌中）
 * 【此卡含描述变量】
 */
define card {
  id 330005 as InEveryHouseAStove;
  description "<color=#FFFFFFFF>第1回合打出此牌时：</color>如果我方牌组中初始包含至少4/2张不同的「{SPRITE_PRESET#3006}天赋」牌，则抓2/1张「{SPRITE_PRESET#3006}天赋」牌。\\n<color=#FFFFFFFF>第2回合及以后打出此牌时：</color>我方抓当于当前的回合数的牌。（最多抓4张）\\n（整局游戏只能打出一张「{SPRITE_PRESET#3007}秘传」卡牌；这张牌一定在你的起始手牌中）";
  dynamicDescription "<color=#FFFFFFFF>第1回合打出此牌时：</color>如果我方牌组中初始包含至少4/2张不同的「{SPRITE_PRESET#3006}天赋」牌，则抓2/1张「{SPRITE_PRESET#3006}天赋」牌。\\n<color=#FFFFFFFF>第2回合及以后打出此牌时：</color>我方抓当于当前的回合数的牌。（最多抓4张，<color=#D3BC8EFF>当前为回合${[T]}</color>）\\n（整局游戏只能打出一张「{SPRITE_PRESET#3007}秘传」卡牌；这张牌一定在你的起始手牌中）";
  legend;
  replaceDescription "[T]", ((st) => st.roundNumber);
  filter :{
    if (:roundNumber === 1) {
      return (
        new Set(
          :player.initialPile
            .filter((card) => card.tags.includes("talent"))
            .map((card) => card.id),
        ).size >= 2
      );
    } else {
      return true;
    }
  };
  if (:roundNumber === 1) {
    const initTalentDefIds = :player.initialPile
      .filter((card) => card.tags.includes("talent"))
      .map((card) => card.id);
    const size = new Set(initTalentDefIds).size;
    if (size >= 4) {
      :drawCards(2, { withTag: "talent" });
    } else if (size >= 2) {
      :drawCards(1, { withTag: "talent" });
    }
  } else {
    const count = Math.min(:roundNumber, 4);
    :drawCards(count);
  }
};

/**
 * @id 323005
 * @name 化种匣
 * @description
 * 我方打出支援牌，或我方打出当前元素骰费用为1的装备牌时：少花费1个元素骰。（每回合1次）
 * 可用次数：2
 */
define card {
  id 323005 as SeedDispensary;
  description "<color=#FFFFFFFF>我方打出支援牌，或我方打出$[K3002]为1的装备牌时：</color>少花费1个元素骰。（每回合1次）\\n<color=#FFFFFFFF>$[K3]：2</color>";
  support item {
    on deductOmniDiceCard {
      when :(
        :e.action.skill.caller.definition.type === "support" ||
          (:e.action.skill.caller.definition.type === "equipment" &&
            :e.currentDiceCostSize() === 1)
      );
      usage perRound, 1;
      usage 2;
      :e.deductOmniCost(1);
    };
  };
};
