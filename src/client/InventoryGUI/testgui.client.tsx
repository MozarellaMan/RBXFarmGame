import * as Roact from "@rbxts/roact"
import { InvSlot } from "client/InventoryGUI/InvSlotComp"
import { InventorySlot } from "shared/inventory/invSlot"
import Net from "@rbxts/net"
import { Inventory } from "shared/inventory/inventory"
import { ReplicatedFirst } from "@rbxts/services"
const Players = game.GetService("Players")

let handle: Roact.ComponentInstanceHandle

interface InvState {
  selectedSlot: number
}

class InventoryGui extends Roact.Component<{ contents: Array<InventorySlot> }, InvState> {
  constructor(props: { contents: Array<InventorySlot> }) {
    super(props)

    this.setState({
      selectedSlot: -1,
    })
  }

  render(): Roact.Element {
    return (
      <screengui>
        <frame Position={new UDim2(0.1, 0, 0.9, -60)} Size={new UDim2(0, 1000, 0, 50)} BackgroundTransparency={1}>
          <uigridlayout
            CellSize={new UDim2(0, 90, 0, 90)}
            CellPadding={new UDim2(0, 10, 0, 0)}
            FillDirection={Enum.FillDirection.Vertical}
            SortOrder={Enum.SortOrder.LayoutOrder}
          />
          {this.props.contents.map((slot, i) => {
            return (
              <InvSlot
                order={i}
                Key={i}
                itemName={slot.currentItem.name}
                amount={slot.size}
                onClick={() => this.setState({ selectedSlot: i })}
                selected={this.state.selectedSlot === i}
              />
            )
          })}
        </frame>
      </screengui>
    )
  }
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
