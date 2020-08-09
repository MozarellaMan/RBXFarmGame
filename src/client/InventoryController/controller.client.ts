import { Players, UserInputService, StarterGui } from "@rbxts/services";
import { hotbarSelectEvent } from "./hotbarSelectEvent";
import Net from "@rbxts/net";


StarterGui.SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

const activeSlot = Players.LocalPlayer.WaitForChild("activeSlot") as IntValue;
const hotbarInputCodes = new Array<number>(9, 0).map((_, indx) => 49 + indx).concat([48, 45, 61]);

const changeActiveSlot = (input: InputObject) => {
  if (input.UserInputType === Enum.UserInputType.Keyboard) {
    const keyPressed = input.KeyCode.Value;

    if (hotbarInputCodes.includes(keyPressed as number)) {
      const hotbarNum = hotbarInputCodes.indexOf(keyPressed as number);
      activeSlot.Value = hotbarNum === activeSlot.Value ? -1 : hotbarNum;
      hotbarSelectEvent.go();
    }
  }
};

activeSlot.Changed.Connect((newSlot) => {
  if (newSlot !== -1 && newSlot < 13) {
    Net.WaitForClientEventAsync("equipItemToPlayer").then((event) => event.SendToServer(newSlot));
  } else if (newSlot === -1) {
    Net.WaitForClientEventAsync("dequipItemsFromPlayer").then((event) => event.SendToServer());
  }
});

UserInputService.InputBegan.Connect((input) => {
  changeActiveSlot(input);
});
