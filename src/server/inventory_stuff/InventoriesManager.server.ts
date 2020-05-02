import { Players } from "@rbxts/services"
import { Inventory } from "shared/inventory/inventory"
import Net from "@rbxts/net"
import { ItemIndex, Item } from "shared/inventory/item"
import t from "@rbxts/t"

const Inventories = new Map<Player, Inventory>()
const inventoryChanged = Net.CreateEvent("inventoryChanged")
const addItemToPlayer = new Net.ServerEvent("addItemToPlayer", t.string, t.number)
const removeItemFromPlayer = new Net.ServerEvent("removeItemFromPlayer", t.string, t.number)
const getPlayerInventory = Net.CreateFunction("getPlayerInventory")

Players.PlayerAdded.Connect((player) => {
  print(player.AccountAge, player.Name, player.CameraMode)
  const newInv = new Inventory(player)
  const activeSlotVal: IntValue = new Instance("IntValue")
  activeSlotVal.Value = -1
  activeSlotVal.Name = "activeSlot"
  activeSlotVal.Parent = player
  Inventories.set(player, newInv)
  inventoryChanged.SendToPlayer(player)
})

addItemToPlayer.Connect((player, itemID, amount) => {
  const itemToAdd = ItemIndex.get(itemID) as Item

  const inventoryToAffect = Inventories.get(player)

  if (itemToAdd && inventoryToAffect)
    inventoryToAffect
      .addItem(itemToAdd, amount)
      .then(inventoryChanged.SendToPlayer(player))
      .catch((excep: unknown) => print(excep))
})

removeItemFromPlayer.Connect((player, itemID, amount) => {
  const itemToRemove = ItemIndex.get(itemID) as Item

  const inventoryToAffect = Inventories.get(player)

  if (itemToRemove && inventoryToAffect)
    inventoryToAffect
      .takeItem(itemToRemove, amount)
      .then(inventoryChanged.SendToPlayer(player))
      .catch((excep: unknown) => print(excep))
})

getPlayerInventory.SetCallback((player) => {
  return Inventories.get(player)
})
