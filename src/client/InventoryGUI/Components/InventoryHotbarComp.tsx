import Roact from "@rbxts/roact";
import { InventorySlot } from "shared/inventory/invSlot";
import { InvSlot } from "./InvSlotComp";
interface InvState {
  selectedSlot: number;
}

export class InventoryGui extends Roact.Component<
  { contents: Array<InventorySlot>; activeSlot: IntValue },
  InvState
> {
  constructor(props: { contents: Array<InventorySlot>; activeSlot: IntValue }) {
    super(props);

    this.setState({
      selectedSlot: this.props.activeSlot.Value,
    });
  }

  render(): Roact.Element {
    return (
      <screengui>
        <frame
          Position={new UDim2(0.1, 0, 0.9, -60)}
          Size={new UDim2(0, 1000, 0, 50)}
          BackgroundTransparency={1}
        >
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
                onClick={() => {
                  this.props.activeSlot.Value =
                    this.props.activeSlot.Value === i ? -1 : i;
                  this.setState({ selectedSlot: this.props.activeSlot.Value });
                }}
                selected={this.props.activeSlot.Value === i}
              />
            );
          })}
        </frame>
      </screengui>
    );
  }

  didMount() {
    this.setState({ selectedSlot: this.props.activeSlot.Value });
  }
}
