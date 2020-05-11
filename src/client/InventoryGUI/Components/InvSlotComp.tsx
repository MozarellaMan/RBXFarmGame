import * as Roact from "@rbxts/roact";
import { Players } from "@rbxts/services";

interface InvSlotState {
  active: boolean;
  hovered: boolean;
}

const backgroundColour = Color3.fromRGB(240, 189, 108);
const borderColour = Color3.fromRGB(102, 63, 0);
const selectedBorderColour = Color3.fromRGB(252, 86, 3);
const hoveredBorderColour = Color3.fromRGB(176, 91, 0);

export class InvSlot extends Roact.PureComponent<
  { itemName: string; amount: number; order: number; selected: boolean; onClick: Callback },
  InvSlotState
> {
  selectedBinding: Roact.RoactBinding<number>;
  changeSelectedBinding: Roact.RoactBindingFunc<number>;

  constructor(props: { itemName: string; amount: number; order: number; selected: boolean; onClick: Callback }) {
    super(props);

    this.setState({
      active: true,
      hovered: false,
    });

    {
      [this.selectedBinding, this.changeSelectedBinding] = Roact.createBinding(0);
    }
  }

  public render(): Roact.Element {
    const { active, hovered } = this.state;

    const clickBorder = this.props.selected ? selectedBorderColour : borderColour;
    const hoveredBorder = hovered ? hoveredBorderColour : borderColour;

    return (
      <frame LayoutOrder={this.props.order} Size={new UDim2(0, 50, 0, 50)}>
        <textbutton
          Key="TimeLabel"
          Size={new UDim2(1, 0, 1, 0)}
          Text={`${this.props.itemName} \n ${this.props.amount}`}
          Event={{
            MouseEnter: (rbx) => this.setState({ hovered: true }),
            MouseLeave: (rbx) => this.setState({ hovered: false }),
            MouseButton1Down: (rbx) => this.props.onClick(),
          }}
          BorderSizePixel={hovered ? 5 : 3}
          BorderColor3={clickBorder}
          BackgroundColor3={backgroundColour}
          AutoButtonColor={false}
        />
      </frame>
    );
  }
}
