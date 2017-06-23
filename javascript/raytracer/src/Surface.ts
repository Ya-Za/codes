import { Point, Vector } from "./Vector";

import { Color } from "./Color";
import { Ray } from "./Ray";

export interface Surface {
    reflect: (pos: Point) => number;
    diffuse: (pos: Point) => Color;
    specular: (pos: Point) => Color;
    roughness: number;
}

export const Shiny: Surface = {
    reflect: (pos: Point) => 0.7,
    diffuse: (pos: Point) => Color.white,
    specular: (pos: Point) => Color.gray,
    roughness: 250
};

export const CheckerBoard: Surface = {
    reflect: (pos: Point) => {
        if ((Math.floor(pos.x) + Math.floor(pos.z)) % 2 === 0) {
            return 0.7;
        } else {
            return 0.1;
        }
    },
    diffuse: (pos: Point) => {
        if ((Math.floor(pos.x) + Math.floor(pos.z)) % 2 === 0) {
            return Color.black;
        } else {
            return Color.white;
        }
    },
    specular: (pos: Point) => Color.white,
    roughness: 150
};
