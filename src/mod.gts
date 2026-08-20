// CustomDataLoader 示例；可直接在此基础上编写赛事模组。
import { $, DamageType, DiceType } from "@gi-tcg/core/data";

define attachment {
  name "费用护盾" as CostShield;
  description "附着于手牌或牌堆中的牌，使其费用增加 1 点。";
  image "https://example.com/cost-shield.png";
  addCost 1;
}

define skill {
  name "普通攻击" as NormalSkill;
  description "造成 1 点物理伤害。";
  skillType normal;
  cost DiceType.Cryo, 1;
  cost DiceType.Void, 2;
  :damage(DamageType.Physical, 1);
}

define skill {
  name "元素战技" as ElementalSkill;
  description "造成 2 点冰元素伤害。";
  skillType elemental;
  cost DiceType.Cryo, 3;
  :damage(DamageType.Cryo, 2);
}

define character {
  name "银狼" as SilverWolf;
  description "自定义角色示例。";
  image "https://example.com/silver-wolf.png";
  tags cryo, catalyst;
  health 10;
  energy 2;
  skills NormalSkill, ElementalSkill;
}

define card {
  name "掀翻牌桌" as TableFlip;
  description "对敌方所有角色造成 10 点穿透伤害。";
  cost DiceType.Omni, 1;
  :damage(DamageType.Piercing, 10, $.opp.character);
}
