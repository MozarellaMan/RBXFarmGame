import { Players } from "@rbxts/services"
import { Inventory } from "shared/inventory/inventory"
import Net from "@rbxts/net"
import { ItemIndex, Item } from "shared/inventory/item"

const Inventories = new Map<Player, Inventory>()

Players.PlayerAdded.Connect((player) => {
  print(player.AccountAge, player.Name, player.CameraMode)
  const newInv = new Inventory(player)
  Inventories.set(player, newInv)
})

const addItemToPlayer = Net.CreateEvent("addItemToPlayer")
const getPlayerInventory = Net.CreateFunction("getPlayerInventory")

addItemToPlayer.Connect((player, ...args: Array<unknown>) => {
  print(player, args.toString())
  const itemID = args[0] as string
  const amount = args[1] as number

  const itemToAdd = ItemIndex.get(itemID) as Item

  const inventoryToAffect = Inventories.get(player)

  if (itemToAdd && inventoryToAffect) inventoryToAffect.addItem(itemToAdd, amount)
  print(Inventories.toString())
})

getPlayerInventory.SetCallback((player) => {
  return Inventories.get(player)
})
