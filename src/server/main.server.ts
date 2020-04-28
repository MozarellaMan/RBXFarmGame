import { makeHello } from "shared/inventory/module"
import { Players } from "@rbxts/services"
import { Inventory } from "shared/inventory/inventory"
import { Item, Items } from "shared/inventory/item"

Players.PlayerAdded.Connect((player) => {
  print(player.AccountAge, player.Name, player.CameraMode)
  const newInv = new Inventory(player)
})
