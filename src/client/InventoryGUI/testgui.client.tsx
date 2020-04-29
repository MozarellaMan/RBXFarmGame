import * as Roact from "@rbxts/roact"
import { InvSlot } from "client/InventoryGUI/InvSlotComp"
import { InventorySlot } from "shared/inventory/invSlot"
import Net from "@rbxts/net"
import { Inventory } from "shared/inventory/inventory"
const Players = game.GetService("Players")

let handle: Roact.ComponentInstanceHandle

const InventoryGui = (props: { contents: Array<InventorySlot> }) => {
  const { contents } = props

  return (
    <screengui>
      <frame Position={new UDim2(0.1, 0, 0.9, -60)} Size={new UDim2(0, 1000, 0, 50)} BackgroundTransparency={1}>
        <uigridlayout
          CellSize={new UDim2(0, 90, 0, 90)}
          CellPadding={new UDim2(0, 10, 0, 0)}
          FillDirection={Enum.FillDirection.Vertical}
          SortOrder={Enum.SortOrder.LayoutOrder}
        />
        {contents.map((slot, i) => {
          return <InvSlot order={i} Key={i} itemName={slot.currentItem.name} amount={slot.size} />
        })}
      </frame>
    </screengui>
  )
}

const PlayerGui = Players.LocalPlayer!.FindFirstChildOfClass("PlayerGui")

const updateInventory = Net.WaitForClientEventAsync("inventoryChanged").then((event) => {
  event.Connect(() => {
    const getInventory = Net.WaitForClientFunctionAsync("getPlayerInventory").then((result) => {
      const response = result
        .CallServerAsync(Players.LocalPlayer)
        .then((inv: Inventory) => {
          const invContents = inv.contents

          const inventoryElement = <InventoryGui contents={invContents} />

          if (handle) Roact.unmount(handle)

          handle = Roact.mount(inventoryElement, PlayerGui, "Inventory")
        })
        .catch((excep: unknown) => print(excep))
    })
  })
})
