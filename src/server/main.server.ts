import { makeHello } from "shared/module";
import { Players } from "@rbxts/services";
import { Inventory } from "shared/inventory";
import { Item, Items} from "shared/item"

Players.PlayerAdded.Connect((player) => {
    print(player.AccountAge, player.Name, player.CameraMode)
    let newInv = new Inventory(player)

    newInv.addItem(Items[2])
    print(newInv.owner.Name, newInv.contents.toString())
    newInv.addItem(Items[1])
    print(newInv.owner.Name, newInv.contents.toString())
    newInv.addItem(Items[0])
    print(newInv.owner.Name, newInv.contents.toString())
    newInv.addItem(Items[2])
    newInv.addItem(Items[2])
    for (let i = 0; i < 20; i++) {
        newInv.addItem(Items[2])     
    }



    print(newInv.owner.Name, newInv.contents.toString())
})