import { Players } from "@rbxts/services";
import { Inventory, InventoryData } from "shared/inventory/inventory";
import DataStore2 from "@rbxts/datastore2";
import NetServerEvent from "@rbxts/net/out/ServerEvent";

const createLocalInventorySlot = (player: Player) => {
  const activeSlotVal: IntValue = new Instance("IntValue");
  activeSlotVal.Value = -1;
  activeSlotVal.Name = "activeSlot";
  activeSlotVal.Parent = player;
  
}

const createInventoryDataStore = (player: Player, inventoryChanged: NetServerEvent) => {
  const invStore = DataStore2<InventoryData>("inventory", player);
  const storeInv = invStore.GetTable(new Inventory(player).exportData());
  invStore.OnUpdate(() => inventoryChanged.SendToPlayer(player));
  invStore.AfterSave((inv) => print("Done saving inventory!"));
  return storeInv;
}

const updateLocalInventory = (player: Player, storeInv: InventoryData, localInventories: Map<Player,Inventory>, inventoryChanged: NetServerEvent) => {
  localInventories.set(player, new Inventory(player, storeInv));
  inventoryChanged.SendToPlayer(player);
}

export { createInventoryDataStore, createLocalInventorySlot, updateLocalInventory}