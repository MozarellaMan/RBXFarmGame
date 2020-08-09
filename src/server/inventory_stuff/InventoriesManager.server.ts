import { Players, ServerStorage } from "@rbxts/services";
import { Inventory, InventoryData } from "shared/inventory/inventory";
import Net from "@rbxts/net";
import { Item, ItemIndex, tools } from "ServerStorage/item";
import t from "@rbxts/t";
import DataStore2 from "@rbxts/datastore2";
import { createLocalInventorySlot, createInventoryDataStore, updateLocalInventory } from "./InventoryManagerHelper";

const Inventories = new Map<Player, Inventory>();
const inventoryChanged = Net.CreateEvent("inventoryChanged");
const addItemToPlayer = new Net.ServerEvent("addItemToPlayer", t.string, t.number);
const equipItemToPlayer = new Net.ServerEvent("equipItemToPlayer", t.number);
const dequipItemsFromPlayer = new Net.ServerEvent("dequipItemsFromPlayer");
const removeItemFromPlayer = new Net.ServerEvent("removeItemFromPlayer", t.string, t.number);
const getPlayerInventory = new Net.ServerAsyncFunction("getPlayerInventory");
const toolFolder = ServerStorage.WaitForChild("tools") as tools;

Players.PlayerAdded.Connect(async (player) => {

  createLocalInventorySlot(player);

  const storedInventory = createInventoryDataStore(player,inventoryChanged);

  updateLocalInventory(player,storedInventory,Inventories,inventoryChanged);
  
});

addItemToPlayer.Connect((player, itemID, amount) => {
  const itemToAdd = ItemIndex.get(itemID) as Item;

  const invStore = DataStore2<InventoryData>("inventory", player);

  const inventoryToAffect = Inventories.get(player);

  if (itemToAdd && inventoryToAffect) {
    inventoryToAffect
      .addItem(itemToAdd, amount)
      .then(invStore.Set(inventoryToAffect.exportData()))
      .catch((excep: unknown) => print(excep));
  }
});

equipItemToPlayer.Connect((player, invSlotNum) => {
  if (!Inventories.get(player)!.contents[invSlotNum].isEmpty()) {
    const itemId = Inventories.get(player)!.contents[invSlotNum].currentItem.id;
    print(`${player.Name} wants to equip ${Inventories.get(player)!.contents[invSlotNum].currentItem.name}!`);
    const humanoid = player.Character!.FindFirstChildOfClass("Humanoid");
    const toolToEquip = toolFolder.FindFirstChild(itemId) as Tool;
    if (humanoid && toolToEquip) {
      print(`humanoid ${humanoid} and tool ${toolToEquip.Name} exists!`);
      const tool = toolToEquip.Clone();
      tool.Parent = player.Character;
      humanoid.EquipTool(tool);
    }
  } else if (Inventories.get(player)!.contents[invSlotNum].isEmpty()) {
    const backpack = player.WaitForChild("Backpack") as Backpack;
    const humanoid = player.Character!.FindFirstChildOfClass("Humanoid");

    if (backpack && humanoid) {
      humanoid.UnequipTools();
      backpack.ClearAllChildren();
    }
  }
});

dequipItemsFromPlayer.Connect((player) => {
  const backpack = player.WaitForChild("Backpack") as Backpack;
  const humanoid = player.Character!.FindFirstChildOfClass("Humanoid");

  if (backpack && humanoid) {
    humanoid.UnequipTools();
    backpack.ClearAllChildren();
  }
});

removeItemFromPlayer.Connect((player, itemID, amount) => {
  const itemToRemove = ItemIndex.get(itemID) as Item;
  const invStore = DataStore2<InventoryData>("inventory", player);

  const inventoryToAffect = Inventories.get(player);

  if (itemToRemove && inventoryToAffect)
    inventoryToAffect
      .takeItem(itemToRemove, amount)
      .then(invStore.Set(inventoryToAffect.exportData()))
      .catch((excep: unknown) => print(excep));
});

getPlayerInventory.SetCallback(
  (player): Promise<Inventory> => {
    return new Promise((resolve, reject) => {
      if (Inventories.get(player) === undefined) return reject("inventory does not exist!");

      resolve(Inventories.get(player) as Inventory);
    });
  },
);


