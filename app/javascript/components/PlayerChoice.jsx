import React, { Component } from "react";
import axios from "axios";

export default class PlayerChoice extends Component {
  constructor(props) {
    super(props);

    this.state = {
      playerNumber: "",
      players: [],
      isLoading: false
    };
  }

  fetchPlayers = () => {
    axios
      .get("/api/v1/players.json", {
        headers: {
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content
        }
      })
      .then(response => {
        if (response.data.data.length > 1) {
          this.setState({
            players: response.data.data,
            isLoading: false
          });
        } else {
          this.setState({
            players: [
              { id: 1, name: "", number: 1, surname: "" },
              { id: 2, name: "", number: 2, surname: "" },
              { id: 3, name: "", number: 3, surname: "" },
              { id: 4, name: "", number: 4, surname: "" },
              { id: 5, name: "", number: 5, surname: "" },
              { id: 6, name: "", number: 6, surname: "" },
              { id: 7, name: "", number: 7, surname: "" },
              { id: 8, name: "", number: 8, surname: "" },
              { id: 9, name: "", number: 9, surname: "" },
              { id: 10, name: "", number: 10, surname: "" },
              { id: 11, name: "", number: 11, surname: "" },
              { id: 12, name: "", number: 12, surname: "" },
              { id: 13, name: "", number: 13, surname: "" },
              { id: 14, name: "", number: 14, surname: "" },
              { id: 15, name: "", number: 15, surname: "" },
              { id: 16, name: "", number: 16, surname: "" },
              { id: 17, name: "", number: 17, surname: "" },
              { id: 18, name: "", number: 18, surname: "" }
            ],
            isLoading: false
          });
        }
      });
  };

  componentDidMount() {
    this.fetchPlayers();
  }

  submitForm = () => {
    this.props.onClickChange(this.state.playerNumber);
  };

  onChange = e => {
    this.setState({
      playerNumber: e.target.value
    });
    this.props.onClickChange(e.target.value);
  };

  render() {
    return (
      <div className="PlayerNumberChoice">
        <select onChange={this.onChange}>
          {this.state.players.map(player => (
            <option value={player.number} key={player.id}>
              {player.name + " " + player.surname + " " + player.number}
            </option>
          ))}
        </select>
      </div>
    );
  }
}
