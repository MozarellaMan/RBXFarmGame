import { Players, UserInputService } from "@rbxts/services";
import { hotbarSelectEvent } from "./hotbarSelectEvent";

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

UserInputService.InputBegan.Connect((input) => {
  changeActiveSlot(input);
});
