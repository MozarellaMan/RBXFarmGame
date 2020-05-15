import { Players } from "@rbxts/services";
import { Inventory, InventoryData } from "shared/inventory/inventory";
import Net from "@rbxts/net";
import { Item, ItemIndex } from "ServerStorage/item";
import t from "@rbxts/t";
import DataStore2 from "@rbxts/datastore2";

const Inventories = new Map<Player, Inventory>();
const inventoryChanged = Net.CreateEvent("inventoryChanged");
const addItemToPlayer = new Net.ServerEvent(
  "addItemToPlayer",
  t.string,
  t.number
);
const equipItemToPlayer = new Net.ServerEvent("equipItemToPlayer", t.number);
const removeItemFromPlayer = new Net.ServerEvent(
  "removeItemFromPlayer",
  t.string,
  t.number
);
const getPlayerInventory = new Net.ServerAsyncFunction("getPlayerInventory");

Players.PlayerAdded.Connect(async (player) => {
  // CREATING LOCAL ACTIVE INVENTORY SLOT
  const activeSlotVal: IntValue = new Instance("IntValue");
  activeSlotVal.Value = -1;
  activeSlotVal.Name = "activeSlot";
  activeSlotVal.Parent = player;

  // DATASTORE STUFF
  const invStore = DataStore2<InventoryData>("inventory", player);
  const storeInv = invStore.GetTable(new Inventory(player).exportData());
  invStore.OnUpdate(() => inventoryChanged.SendToPlayer(player));
  invStore.AfterSave((inv) => print("Done saving inventory!"));
  // SET LOCAL INVENTORY
  Inventories.set(player, new Inventory(player, storeInv));
  inventoryChanged.SendToPlayer(player);
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
  if (!Inventories.get(player)!.contents[invSlotNum].isEmpty())
    print(
      `${player.Name} wants to equip ${
        Inventories.get(player)!.contents[invSlotNum].currentItem.name
      }!`
    );
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
      if (Inventories.get(player) === undefined)
        return reject("inventory does not exist!");

      resolve(Inventories.get(player) as Inventory);
    });
  }
);
