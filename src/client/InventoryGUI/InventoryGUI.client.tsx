import * as Roact from "@rbxts/roact"
import { InvSlot } from "client/InventoryGUI/Components/InvSlotComp"
import { InventorySlot } from "shared/inventory/invSlot"
import Net from "@rbxts/net"
import { Inventory } from "shared/inventory/inventory"
import { ReplicatedFirst } from "@rbxts/services"
import { InventoryGui } from "./Components/InventoryHotbarComp"
import { hotbarSelectEvent } from "client/InventoryController/hotbarSelectEvent"

const Players = game.GetService("Players")

let handle: Roact.ComponentInstanceHandle
const ActiveSlot = Players.LocalPlayer.WaitForChild("activeSlot") as IntValue
let InventoryCache: Inventory
const PlayerGui = Players.LocalPlayer!.FindFirstChildOfClass("PlayerGui")

const getInventory = (): Promise<Inventory> => {
  return new Promise((resolve, reject) => {
    const getInventory = Net.WaitForClientFunctionAsync("getPlayerInventory").then((result) => {
      const response = result
        .CallServerAsync(Players.LocalPlayer)
        .then((inv: Inventory) => {
          resolve(inv)
          InventoryCache = inv
        })
        .catch((excep: unknown) => reject(excep))
    })
  })
}

const mountInventoryGUI = async () => {
  const playerinventory = await getInventory().catch(() => InventoryCache)
  const inventoryElement = <InventoryGui contents={playerinventory.contents} activeSlot={ActiveSlot} />

  if (handle) Roact.unmount(handle)

  handle = Roact.mount(inventoryElement, PlayerGui, "Inventory")
}

const updateInventoryGUI = async () => {
  const playerinventory = await getInventory().catch(() => InventoryCache)
  const inventoryElement = <InventoryGui contents={playerinventory.contents} activeSlot={ActiveSlot} />

  handle = Roact.update(handle, inventoryElement)
}

const updateInventory = Net.WaitForClientEventAsync("inventoryChanged").then((event) => {
  event.Connect(() => {
    const getInventory = Net.WaitForClientFunctionAsync("getPlayerInventory").then((result) => {
      const response = result.CallServerAsync(Players.LocalPlayer).then((inv: Inventory) => {
        mountInventoryGUI()
      })
    })
  })
})

hotbarSelectEvent.bind(() => {
  updateInventoryGUI()
})
