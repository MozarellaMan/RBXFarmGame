import { Item, Items, Empty } from 'shared/item'

type stateType  = 'empty' | 'full' | 'occupied'

export class InventorySlot {
    currentItem: Item
    size: number
    state: 'empty' | 'full' | 'occupied'

    constructor(item = Empty, size = 0, state: stateType = "empty"){
        this.currentItem = item
        this.size = size
        this.state = state
        if(item !== Empty)
            this.checkState()
    }

    addItem(item: Item, amount = 1) : InventorySlot {
    
        const newState = (item.maxAmount >= this.size) && (this.state === "occupied") ? 
            "full" 
            : this.currentItem === item ? 
            "occupied" 
            : "empty"

        switch(this.state){
            case "empty":
                const changedSize = (this.size+amount) < item.maxAmount ? this.size+amount : item.maxAmount
                return new InventorySlot(item, changedSize)
            case "occupied":
                const newSize = this.size+amount
                const itemsMatch = item === this.currentItem
                this.size = itemsMatch && newSize < this.currentItem.maxAmount ? newSize : this.currentItem.maxAmount
                this.checkState()
                return Object.copy(this)
            case "full":
                return Object.copy(this)
                
        }
    }

    checkState() {
        this.state = this.currentItem !== Empty && (this.currentItem.maxAmount >= this.size && this.state === 'occupied') ?
            'full'
            : this.size <= 0 ? 'empty' : 'occupied'
    }

    isEmpty(){
        return this.state === 'empty'
    }
}