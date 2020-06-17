import React from "react";

const InputName = props => {
  return (
    <div className="form-group d-flex flex-row">
      <label className="servName" htmlFor="formGroupExampleInput">
        Name
      </label>
      <input
        type="text"
        className="form-control"
        value={props.name}
        size={16}
        onChange={e => props.onChangeName(e.target.value)}
      />
    </div>
  );
};

export default InputName;
