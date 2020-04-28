import { Players } from "@rbxts/services";
import { Item } from 'shared/item';
import { InventorySlot } from 'shared/invSlot'

export class Inventory{
    owner: Player;
    contents: Array<InventorySlot>;
    maxSize: number;
    size: number;

    constructor(owner: Player){
        this.owner = owner;
        this.maxSize = 12;
        this.size = 0;
        this.contents = new Array<InventorySlot>(this.maxSize, new InventorySlot())
    }

    addItem(item:Item) {
        const itemExists = this.contents.filter(slot => !slot.isEmpty()).map(slot=> slot.currentItem).includes(item)
        const emptySlotIndex = this.contents.findIndex(slot => slot.isEmpty())

        if(itemExists){
            const existingItemSlot = this.contents.findIndex(slot => slot.currentItem === item && !slot.isFull())
            this.contents = existingItemSlot+1 ? 
                this.contents.map((slot,index) => index !== existingItemSlot ? slot : slot.addItem(item)) 
                : this.contents
        }
        if(!itemExists){
            this.contents = this.contents.map((slot,index) => index !== emptySlotIndex ? slot : slot.addItem(item))
        }

    }

}


