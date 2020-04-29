import { Item, Items, Empty } from "shared/inventory/item"

type stateType = "empty" | "full" | "occupied"

export class InventorySlot {
  currentItem: Item
  size: number
  state: "empty" | "full" | "occupied"

  constructor(item = Empty, size = 0, state: stateType = "empty") {
    this.currentItem = item
    this.size = size
    this.state = state
  }

  addItem(item: Item, amount = 1): InventorySlot {
    switch (this.state) {
      case "empty":
        const changedSize = this.size + amount < item.maxAmount ? this.size + amount : item.maxAmount
        return new InventorySlot(item, changedSize, "occupied")
      case "occupied":
        const maxItemAmount = this.currentItem.maxAmount
        const sumSize = this.size + amount
        const itemsMatch = item === this.currentItem
        if (itemsMatch) {
          const newSize = sumSize < this.currentItem.maxAmount ? sumSize : maxItemAmount
          return newSize >= maxItemAmount
            ? new InventorySlot(item, maxItemAmount, "full")
            : new InventorySlot(item, newSize, "occupied")
        } else {
          return Object.copy(this)
        }
      case "full":
        return Object.copy(this)
    }
  }

  removeItem(item: Item, amount = 1): InventorySlot {
    switch (this.state) {
      case "empty":
        return this.makeEmpty()
      case "full":
      case "occupied":
        const changedSize = this.size - amount > 0 ? this.size - amount : 0
        return changedSize > 0 ? new InventorySlot(item, changedSize, "occupied") : this.makeEmpty()
    }
  }

  isEmpty() {
    return this.state === "empty"
  }

  isFull() {
    return this.state === "full"
  }

  makeEmpty() {
    return new InventorySlot(Empty, 0, "empty")
  }
}
