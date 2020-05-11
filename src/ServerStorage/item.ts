enum ItemClass {
  Resource,
  Food,
  Tool,
  Seed,
  Furniture,
  Empty,
}

enum ItemRarity {
  Common,
  Uncommon,
  Rare,
  Legendary,
  Exotic,
  None,
}
export interface Item {
  id: string;
  name: string;
  maxAmount: number;
  rarity: ItemRarity;
  class: ItemClass;
  cost: number;
}

export const ItemIndex = new ReadonlyMap<string, Item>([
  [
    "rck",
    {
      id: "rck",
      name: "Rock",
      maxAmount: 100,
      rarity: ItemRarity.Common,
      class: ItemClass.Resource,
      cost: 10,
    },
  ],
  [
    "dia",
    {
      id: "dia",
      name: "Diamond",
      maxAmount: 30,
      rarity: ItemRarity.Legendary,
      class: ItemClass.Resource,
      cost: 3000,
    },
  ],
  [
    "brd",
    {
      id: "brd",
      name: "Bread",
      maxAmount: 10,
      rarity: ItemRarity.Uncommon,
      class: ItemClass.Food,
      cost: 100,
    },
  ],
  [
    "waxe",
    {
      id: "waxe",
      name: "Wooden Axe",
      maxAmount: 1,
      rarity: ItemRarity.Common,
      class: ItemClass.Tool,
      cost: 20,
    },
  ],
  [
    "wlog",
    {
      id: "wlog",
      name: "Wood",
      maxAmount: 100,
      rarity: ItemRarity.Common,
      class: ItemClass.Resource,
      cost: 10,
    },
  ],
]);

export const Empty: Item = {
  id: "emp",
  name: "Empty",
  maxAmount: 1,
  rarity: ItemRarity.None,
  class: ItemClass.Empty,
  cost: 0,
};
