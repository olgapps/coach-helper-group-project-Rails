import React, { Component } from "react";
import InputName from "../components/InputName";

export default class TopToolBar extends Component {
  constructor(props) {
    super(props);
    this.handleSave = this.handleSave.bind(this);
    this.state = {
      activeDashedArrows: false,
      activeArrows: false,
      activeStop: false
    };
  }

  handleSave = e => {
    this.props.onHandleSave();
  };

  render() {
    const dashedArrowsClass = this.state.activeDashedArrows
      ? "TopToolBar btn btn-danger"
      : "TopToolBar btn btn-success";
    const arrowsClass = this.state.activeArrows
      ? "TopToolBar btn btn-danger"
      : "TopToolBar btn btn-success";
    const activeStop = this.state.activeStop
      ? "TopToolBar btn btn-danger"
      : "TopToolBar btn btn-success";

    return (
      <div className="TopToolBar d-flex justify-content-end">
        <InputName
          name={this.props.name}
          onChangeName={this.props.onChangeName}
        />
        <button
          className={activeStop}
          onClick={() => {
            this.props.onHandleStop();
            this.setState({
              activeStop: !this.state.activeStop
            });
          }}
        >
          {this.state.activeStop ? "Start drawing" : "Stop drawing"}
        </button>
        <button
          className="TopToolBar btn btn-success"
          onClick={this.props.onHandleSave}
        >
          Save To Play Book
        </button>
        <button
          className={arrowsClass}
          onClick={() => {
            this.props.onHandleStartDrowingArrows(false);
            this.setState({
              activeArrows: !this.state.activeArrows,
              activeDashedArrows: false
            });
          }}
        >
          Arrows
        </button>
        <button
          className={dashedArrowsClass}
          onClick={() => {
            this.props.onHandleStartDrowingArrows(true);
            this.setState({
              activeDashedArrows: !this.state.activeDashedArrows,
              activeArrows: false
            });
          }}
        >
          Dashed Arrows
        </button>
        <button
          className="TopToolBar btn btn-success"
          onClick={() => this.props.onHandleUndo()}
        >
          Undo
        </button>
        <button
          className="TopToolBar btn btn-success"
          onClick={() => this.props.onChangeToFullScreen()}
        >
          Toggle Fullscreen
        </button>
      </div>
    );
  }
}
