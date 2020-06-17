import React from "react";
import { Arrow } from "react-konva";

export default function CustomArrow(props) {
  const { startPos, endPos, dashed, fill, stroke } = props;

  return (
    <Arrow
      points={[startPos.x, startPos.y, endPos.x, endPos.y]}
      pointerLength={20}
      pointerWidth={20}
      fill={fill}
      stroke={stroke}
      dash={dashed}
      strokeWidth={4}
    />
  );
}
