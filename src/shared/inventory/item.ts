export interface Item {
  id: string;
  name: string;
  maxAmount: number;
  rarity: string;
  class: string;
  cost: number;
}

export const Items: Array<Item> = [
  { id: "rck", name: "Rock", maxAmount: 100, rarity: "common", class: "material", cost: 10 },
  { id: "dia", name: "Diamond", maxAmount: 30, rarity: "rare", class: "material", cost: 3000 },
  { id: "brd", name: "Bread", maxAmount: 10, rarity: "common", class: "food", cost: 100 },
];

export const ItemIndex = new ReadonlyMap<string, Item>([
  ["rck", Items[0]],
  ["dia", Items[1]],
  ["brd", Items[2]],
]);

export const Empty: Item = { id: "emp", name: "Empty", maxAmount: 1, rarity: "", class: "", cost: 0 };
