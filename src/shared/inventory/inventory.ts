/* eslint-disable roblox-ts/lua-truthiness */
import { Item } from "ServerStorage/item";
import { InventorySlot, SlotData } from "shared/inventory/invSlot";

export interface InventoryData {
  readonly contents: Array<SlotData>;
  readonly maxSize: number;
  readonly size: number;
}

export class Inventory {
  owner: Player;
  contents: Array<InventorySlot>;
  maxSize: number;
  size: number;

  constructor(owner: Player, data?: InventoryData) {
    const savedIndexes = data ? data.contents.map((slotData) => slotData.slotIndex) : undefined;
    // savedIndexes ? print(savedIndexes.toString()) : print("no saved inedexes.");
    this.owner = owner;
    this.maxSize = data ? data.maxSize : 12;
    this.size = data ? data.size : 0;
    this.contents =
      savedIndexes && data
        ? new Array<InventorySlot>(this.maxSize, new InventorySlot()).map((oldSlot, i) =>
            savedIndexes.includes(i)
              ? new InventorySlot(data.contents.find((slotData) => slotData.slotIndex === i))
              : oldSlot,
          )
        : new Array<InventorySlot>(this.maxSize, new InventorySlot());
  }

  freeItemSlotExists(item: Item): boolean {
    return this.contents
      .filter((slot) => !slot.isEmpty() && !slot.isFull())
      .map((slot) => slot.currentItem)
      .includes(item);
  }

  itemExists(item: Item): boolean {
    return this.contents
      .filter((slot) => !slot.isEmpty())
      .map((slot) => slot.currentItem)
      .includes(item);
  }

  findItemSlot = (item: Item): Promise<number> => {
    return new Promise<number>((resolve, reject) => {
      const resultIndexes = this.contents
        .map((slot, i) => (slot.currentItem === item && !slot.isEmpty() ? i : -1))
        .filter((index) => index !== -1);

      const index = resultIndexes[resultIndexes.size() - 1];

      resultIndexes.size() < 1 ? reject("Item not in inventory!") : resolve(index);
    });
  };

  addItem(item: Item, amount = 1): Promise<Item> {
    return new Promise<Item>((resolve, reject) => {
      const itemExists = this.freeItemSlotExists(item);
      const emptySlotIndex = this.contents.findIndex((slot) => slot.isEmpty());

      if (itemExists) {
        const existingItemSlot = this.contents.findIndex((slot) => slot.currentItem === item && !slot.isFull());
        this.contents =
          existingItemSlot + 1
            ? this.contents.map((slot, index) => (index !== existingItemSlot ? slot : slot.addItem(item, amount)))
            : this.contents;

        existingItemSlot + 1 ? resolve(item) : reject("Item does not exist!");
      }
      if (!itemExists) {
        if (emptySlotIndex === -1) {
          reject("No space left in inventory!");
        } else {
          this.contents = this.contents.map((slot, index) =>
            index !== emptySlotIndex ? slot : slot.addItem(item, amount),
          );
          resolve(item);
        }
      }
    });
  }

  takeItem(item: Item, amount = 1): Promise<Item> {
    return new Promise<Item>(async (resolve, reject) => {
      const itemExists = this.itemExists(item);

      if (itemExists) {
        const itemSlot = await this.findItemSlot(item);

        this.contents = this.contents.map((slot, index) => (index !== itemSlot ? slot : slot.removeItem(item, amount)));

        resolve(item);
      } else {
        reject("Item does not exist!");
      }
    });
  }

  exportData(): InventoryData {
    const invData: InventoryData = {
      contents: this.contents.mapFiltered((slot, i) => (!slot.isEmpty() ? slot.exportData(i) : undefined)),
      maxSize: this.maxSize,
      size: this.size,
    };
    return invData;
  }
}
