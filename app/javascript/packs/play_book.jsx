// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.
import React, { Component } from "react";
import ReactDOM from "react-dom";
import Fullscreen from "react-full-screen";
import TopToolBar from "../components/TopToolBar";
import DrawerField from "../components/DrawerField";
import axios from "axios";

export default class PlayBook extends Component {
  constructor(props) {
    super(props);
    this.state = {
      actionName: [],
      isFull: false,
      isDrawingArrows: false,
      dashed: null,
      saved: false,
      name: "",
      imageData: "",
      arrwosArray: [],
      lines: [],
      oldPlayerPosition: [],
      // ballPosition: [{ ballX: 50, ballY: 20 }, { ballX: 50, ballY: 20 }],
      ballPosition: [{ ballX: 50, ballY: 20 }],
      players: this.addPlayersToInitialList(99, "ourTeam"),
      enemyPlayers: this.addPlayersToInitialList(18, "enemy"),
      stop: false
    };

    this.fieldRef = React.createRef();
    this.handleFullScreen = this.handleFullScreen.bind(this);
    this.handleStartDrowingArrows = this.handleStartDrowingArrows.bind(this);
    this.handleUndo = this.handleUndo.bind(this);
    this.handleUpdateArrowsPosition = this.handleUpdateArrowsPosition.bind(
      this
    );
    this.handleUpdateBallPosition = this.handleUpdateBallPosition.bind(this);
    this.handleUpdateEnemyPlayersPosition = this.handleUpdateEnemyPlayersPosition.bind(
      this
    );
    this.handleUpdateOldPlayersPosition = this.handleUpdateOldPlayersPosition.bind(
      this
    );
    this.handleUpdatePlayersPosition = this.handleUpdatePlayersPosition.bind(
      this
    );
    this.handleUpdateLines = this.handleUpdateLines.bind(this);
    this.setImageData = this.setImageData.bind(this);
    this.changeName = this.changeName.bind(this);
    this.updateLines = this.updateLines.bind(this);
    this.handleUpdateLinesStatus = this.handleUpdateLinesStatus.bind(this);
    this.handleStop = this.handleStop.bind(this);
  }

  handleStop() {
    this.setState({
      stop: this.state.stop ? false : true
    });
  }

  addPlayersToInitialList(playerNumber, team) {
    const ourPlayerX = 100;
    const ourPlayerY = 20;
    const enemyPlayerX = 180;
    const enemyPlayerY = 20;

    let playerList = [];
    for (
      let playerIterator = 1;
      playerIterator <= playerNumber;
      playerIterator++
    ) {
      if (team == "ourTeam") {
        playerList.push({ x: ourPlayerX, y: ourPlayerY, id: playerIterator });
      } else {
        playerList.push({
          x: enemyPlayerX,
          y: enemyPlayerY,
          id: playerIterator
        });
      }
    }
    return playerList;
  }

  changeName = newName => {
    this.setState({ name: newName });
  };

  setImageData() {}

  handleSave = () => {
    let image = this.fieldRef.current.getStage().toDataURL();

    axios.post(
      "/play_books.json",
      { play_book: { name: this.state.name, data_uri: image } },
      {
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content
        }
      }
    );

    this.setState({
      saved: true
    });
    window.location.reload();
  };

  handleFullScreen() {
    this.state.isFull
      ? this.setState({ isFull: false })
      : this.setState({ isFull: true });
  }

  handleStartDrowingArrows(dashed) {
    if (this.state.dashed === dashed) {
      this.setState(previousState => ({
        isDrawingArrows: !previousState.isDrawingArrows
      }));
    } else {
      this.setState({
        isDrawingArrows: true,
        dashed: dashed
      });
    }
  }

  handleUndo() {
    const playersPosition = this.state.players;
    const enemyPlayersPosition = this.state.enemyPlayers;
    const playersOldPosition = this.state.oldPlayerPosition;
    const item = this.state.actionName;
    const arrows = this.state.arrwosArray;
    const ballPosition = this.state.ballPosition;
    const lines = this.state.lines;

    switch (item[item.length - 1]) {
      case "updateArrow":
        arrows.pop();
        item.pop();
        this.setState({
          arrwosArray: arrows,
          actionName: item
        });
        break;

      case "updateBall":
        ballPosition.pop();
        item.pop();
        this.setState({
          ballPosition: ballPosition,
          actionName: item
        });
        break;

      case "updateEnemyPlayer":
        if (playersOldPosition.length - 1 < 0) break;
        enemyPlayersPosition[
          playersOldPosition[playersOldPosition.length - 1].playerId - 1
        ].x = playersOldPosition[playersOldPosition.length - 1].playerX;
        enemyPlayersPosition[
          playersOldPosition[playersOldPosition.length - 1].playerId - 1
        ].y = playersOldPosition[playersOldPosition.length - 1].playerY;
        playersOldPosition.pop();
        item.pop();
        this.setState({
          enemyPlayers: enemyPlayersPosition,
          actionName: item
        });
        break;

      case "updatePlayer":
        if (playersOldPosition.length - 1 < 0) break;
        playersPosition[
          playersOldPosition[playersOldPosition.length - 1].playerId - 1
        ].x = playersOldPosition[playersOldPosition.length - 1].playerX;
        playersPosition[
          playersOldPosition[playersOldPosition.length - 1].playerId - 1
        ].y = playersOldPosition[playersOldPosition.length - 1].playerY;
        playersOldPosition.pop();
        item.pop();
        this.setState({
          players: playersPosition,
          actionName: item
        });
        break;

      case "updateLine":
        lines.pop();
        item.pop();
        if (lines.length == 1) {
          lines.pop();
        }
        this.setState({
          lines: lines,
          actionName: item
        });
        break;

      default:
        lines.pop();
        item.pop();
        this.setState({
          lines: lines,
          actionName: item
        });
        break;
    }
  }

  handleUpdateArrowsPosition(arrwosArray) {
    const item = this.state.actionName;
    item.push("updateArrow");
    this.setState({
      arrwosArray: arrwosArray,
      actionName: item
    });
  }

  handleUpdateBallPosition(ballPosition) {
    const item = this.state.actionName;
    item.push("updateBall");
    this.setState({
      ballPosition: ballPosition,
      actionName: item
    });
  }

  handleUpdateEnemyPlayersPosition(playersPosition) {
    const item = this.state.actionName;
    item.push("updateEnemyPlayer");
    this.setState({
      enemyPlayers: playersPosition,
      actionName: item
    });
  }

  handleUpdatePlayersPosition(playersPosition) {
    const item = this.state.actionName;
    item.push("updatePlayer");
    this.setState({
      players: playersPosition,
      actionName: item
    });
  }

  handleUpdateLines(lines) {
    this.setState({
      lines: lines
    });
  }

  handleUpdateLinesStatus() {
    const item = this.state.actionName;
    item.push("updateLine");
    this.setState({
      actionName: item
    });
  }

  handleUpdateOldPlayersPosition(playersPosition) {
    const item = this.state.oldPlayerPosition;
    item.push(playersPosition);
    this.setState({
      oldPlayerPosition: item
    });
  }

  updateLines() {
    this.setState({
      lines: [...this.state.lines, []]
    });
  }

  render() {
    return (
      <div className="PlayBook">
        <Fullscreen
          enabled={this.state.isFull}
          onChange={isFull => this.setState({ isFull })}
        >
          <div className="full-screenable-node d-flex flex-column">
            <TopToolBar
              onChangeToFullScreen={this.handleFullScreen}
              onHandleStartDrowingArrows={this.handleStartDrowingArrows}
              onHandleSave={this.handleSave}
              onChangeName={this.changeName}
              onHandleUndo={this.handleUndo}
              navRef={this.navRef}
              name={this.state.name}
              onChangeName={this.changeName}
              onHandleStop={this.handleStop}
            />
            <DrawerField
              startDrawingArrows={this.state.isDrawingArrows}
              startDrawingArrowsDashed={this.state.dashed}
              arrwosArray={this.state.arrwosArray}
              players={this.state.players}
              lines={this.state.lines}
              enemyPlayers={this.state.enemyPlayers}
              ballPosition={this.state.ballPosition}
              onHandleUpdateArrowsPosition={this.handleUpdateArrowsPosition}
              onHandleUpdateBallPosition={this.handleUpdateBallPosition}
              onHandleUpdateOldPlayersPosition={
                this.handleUpdateOldPlayersPosition
              }
              onHandleUpdateEnemyPlayersPosition={
                this.handleUpdateEnemyPlayersPosition
              }
              onHandleUpdatePlayersPosition={this.handleUpdatePlayersPosition}
              onHandleUpdateLines={this.handleUpdateLines}
              onSetImageData={this.setImageData}
              onUpdateLines={this.updateLines}
              fieldRef={this.fieldRef}
              onHandleUpdateLinesStatus={this.handleUpdateLinesStatus}
              stop={this.state.stop}
            />
          </div>
        </Fullscreen>
      </div>
    );
  }
}

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(<PlayBook />, document.getElementById("play_book"));
});
