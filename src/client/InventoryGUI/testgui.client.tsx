import * as Roact from "@rbxts/roact"
import { InvSlot } from "client/InventoryGUI/InvSlotComp"
import { InventorySlot } from "shared/inventory/invSlot"
import Net from "@rbxts/net"
import { Inventory } from "shared/inventory/inventory"
const Players = game.GetService("Players")

const InventoryGui = (props: { contents: Array<InventorySlot> }) => {
  const { contents } = props

  return (
    <screengui>
      <frame Position={new UDim2(0.1, 0, 0.9, -60)} Size={new UDim2(0, 1000, 0, 0)}>
        <uigridlayout />
        <InvSlot itemName="Bread" amount={0} />
      </frame>
    </screengui>
  )
}

const PlayerGui = Players.LocalPlayer!.FindFirstChildOfClass("PlayerGui")
const getInventory = Net.WaitForClientFunctionAsync("getPlayerInventory").then((result) => {
  const response = result
    .CallServerAsync(Players.LocalPlayer)
    .then((inv: Inventory) => {
      print(inv.contents.toString())
    })
    .catch((excep: unknown) => print(excep))
})
