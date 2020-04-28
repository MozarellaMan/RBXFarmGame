
export interface Item {
    name: string
    maxAmount: number
    rarity: string
    class: string
    cost: number
}

export const Items:Array<Item> = [
    {name:'Rock',maxAmount:100,rarity:'common',class:'material',cost:10},
    {name:'Diamond',maxAmount:30,rarity:'rare',class:'material',cost:3000},
    {name:'Bread',maxAmount:10,rarity:'common',class:'food',cost:100},
]

export const Empty :Item = {name:'Empty',maxAmount:1,rarity:'',class:'',cost:0}

