import Net from "@rbxts/net";
import { Workspace, Players } from "@rbxts/services";
import { Items } from "shared/inventory/item";

type ItemGiverPart = Part & {
  ClickDetector: ClickDetector;
};

const buttons: Array<ItemGiverPart> = [
  Workspace.WaitForChild("ItemGiverPart") as ItemGiverPart,
  Workspace.WaitForChild("ItemGiverPart2") as ItemGiverPart,
  Workspace.WaitForChild("ItemGiverPart3") as ItemGiverPart,
];

buttons.forEach((button, i) => {
  button.ClickDetector.MouseClick.Connect(() => {
    const addItemToPlayer = Net.WaitForClientEventAsync("addItemToPlayer")
      .then((event) => {
        switch (i) {
          case 0:
            event.SendToServer("brd", 3);
            break;
          case 1:
            event.SendToServer("dia", 2);
            break;
          case 2:
            event.SendToServer("rck", 8);
            break;
        }
      })
      .catch((excep: unknown) => print(excep));
  });

  button.ClickDetector.RightMouseClick.Connect(() => {
    const removeItemFromPlayer = Net.WaitForClientEventAsync("removeItemFromPlayer")
      .then((event) => {
        switch (i) {
          case 0:
            event.SendToServer("brd", 9);
            break;
          case 1:
            event.SendToServer("dia", 5);
            break;
          case 2:
            event.SendToServer("rck", 1);
            break;
        }
      })
      .catch((excep: unknown) => print(excep));
  });
});
