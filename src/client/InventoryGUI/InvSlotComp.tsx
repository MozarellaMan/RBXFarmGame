import * as Roact from "@rbxts/roact"
import { Players } from "@rbxts/services"

interface InvSlotState {
  active: boolean
  selected: boolean
}

export class InvSlot extends Roact.Component<{ itemName: string; amount: number }, InvSlotState> {
  constructor(props: { itemName: string; amount: number }) {
    super(props)
    this.setState({
      active: true,
      selected: false,
    })
  }

  public render(): Roact.Element {
    const { active, selected } = this.state

    return (
      <frame Size={new UDim2(0, 100, 0, 100)}>
        <textlabel
          Key="TimeLabel"
          Size={new UDim2(1, 0, 1, 0)}
          Text={`${this.props.itemName} \n ${this.props.amount}`}
        />
      </frame>
    )
  }

  public didMount() {}

  public willUnmount() {}
}
