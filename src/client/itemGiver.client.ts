import Net from "@rbxts/net"
import { Workspace, Players } from "@rbxts/services"
import { Items } from "shared/inventory/item"

type ItemGiverPart = Part & {
  ClickDetector: ClickDetector
}

const button: ItemGiverPart = Workspace.WaitForChild("ItemGiverPart") as ItemGiverPart

button.ClickDetector.MouseClick.Connect(() => {
  const addItemToPlayer = Net.WaitForClientEventAsync("addItemToPlayer")
    .then((event) => {
      const localPlayer: Player = Players.LocalPlayer
      event.SendToServer("brd", 3)
    })
    .catch((excep: unknown) => print(excep))
})
