import { Item, Empty as EmptyItem, ItemIndex } from "ServerStorage/item";

enum State {
  Empty,
  Occupied,
  Full,
}

export interface SlotData {
  slotIndex: number;
  state: State;
  itemId: string;
  size: number;
}

export class InventorySlot {
  currentItem: Item;
  size: number;
  state: State;

  constructor(data?: SlotData, item = EmptyItem, size = 0, state: State = State.Empty) {
    this.currentItem = data ? ((ItemIndex.get(data.itemId) ? ItemIndex.get(data.itemId) : item) as Item) : item;
    this.size = data ? data.size : size;
    this.state = data ? data.state : state;
  }

  addItem(item: Item, amount = 1): InventorySlot {
    switch (this.state) {
      case State.Empty:
        const changedSize = this.size + amount < item.maxAmount ? this.size + amount : item.maxAmount;
        return new InventorySlot(undefined, item, changedSize, State.Occupied);
      case State.Occupied:
        const maxItemAmount = this.currentItem.maxAmount;
        const sumSize = this.size + amount;
        const itemsMatch = item === this.currentItem;
        if (itemsMatch) {
          const newSize = sumSize < this.currentItem.maxAmount ? sumSize : maxItemAmount;
          return newSize >= maxItemAmount
            ? new InventorySlot(undefined, item, maxItemAmount, State.Full)
            : new InventorySlot(undefined, item, newSize, State.Occupied);
        } else {
          return Object.copy(this);
        }
      case State.Full:
        return Object.copy(this);
    }
  }

  removeItem(item: Item, amount = 1): InventorySlot {
    switch (this.state) {
      case State.Empty:
        return this.makeEmpty();
      case State.Full:
      case State.Occupied:
        const changedSize = this.size - amount > 0 ? this.size - amount : 0;
        return changedSize > 0 ? new InventorySlot(undefined, item, changedSize, State.Occupied) : this.makeEmpty();
    }
  }

  isEmpty() {
    return this.state === State.Empty || this.currentItem.id === "emp";
  }

  isFull() {
    return this.state === State.Full;
  }

  makeEmpty() {
    return new InventorySlot(undefined, EmptyItem, 0, State.Empty);
  }

  exportData(slotIndex: number): SlotData {
    const slotData: SlotData = {
      slotIndex: slotIndex,
      state: this.state,
      itemId: this.currentItem.id,
      size: this.size,
    };
    return slotData;
  }
}
